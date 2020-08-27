require_relative '../spec_helper'

test_run = TestConfig.new

if test_run.deployment == Deployment::CORE

  describe 'CollectionSpace' do

    include Logging
    include WebDriverManager

    before(:all) do
      test_run.set_driver launch_browser
      @admin = test_run.get_admin_user
      @login_page = test_run.get_page CoreLoginPage
      @create_new_page = test_run.get_page CoreCreateNewPage
      @search_page = test_run.get_page CoreSearchPage
      @search_results_page = test_run.get_page CoreSearchResultsPage
      @object_page = test_run.get_page CoreObjectPage
      @acquisition_page = test_run.get_page CoreAcquisitionPage

      @login_page.load_page
      @login_page.log_in(@admin.username, @admin.password)

      @test_proc = {
        CoreAcquisitionData::ACQUIS_METHOD.name => 'gift',
        CoreAcquisitionData::ACCESSION_DATE_GRP.name => (Date.today - 1).to_s
      }
      test_run.set_unique_test_id(@test_proc, CoreAcquisitionData::ACQUIS_REF_NUM.name)
      @search_page.click_create_new_link
      @create_new_page.click_create_new_acquisition
      @acquisition_page.create_new_acquisition @test_proc
      @core_id = "#{@test_proc[CoreAcquisitionData::ACQUIS_REF_NUM.name]}"
    end

    after(:all) { quit_browser test_run.driver }

    current_date = (Date.today - 1).to_s
    primary_tab = {:xpath => '//button[contains(., "Primary Record")]'}
    all_secondary_tabs = ["Objects", "Acquisitions", "Condition Checks", "Conservation Treatments",
                          "Exhibitions" , "Groups", "Intakes", "Loans In", "Loans Out", "Location/Movement/Inventory",
                          "Media Handling", "Object Exits", "Use of Collections", "Valuation Controls"]

    it "Navigates Between Secondary and Primary Tabs" do
      @search_page.quick_search("Acquisitions", [], @core_id)
      @search_results_page.click_result(0)

      i = 30
      [["close", "Location/Movement/Inventory"], ["cancel", "Exhibitions"]].each do |(button, tab)|
        @acquisition_page.wait_for_element_and_type(@acquisition_page.structured_date_input_locator([]),  (Date.today - i).to_s)
        @acquisition_page.hit_enter
        @acquisition_page.select_related_type tab

        dialog_popup = @acquisition_page.element_text(:xpath => '//div[@role = "dialog"]//div')
        expect(dialog_popup.include? "about to leave a record that has unsaved changes").to be true

        @acquisition_page.wait_for_element_and_click(:xpath => "//div[@role = \"presentation\"]//button[@name = \"#{button}\"]")
        expect(@acquisition_page.exists? dialog_popup).to be false
        i += 1
      end

      movement_tab = {:xpath => '//button[@data-recordtype = "movement"][1]'}
      @acquisition_page.wait_for_element_and_click(movement_tab)
      @acquisition_page.revert_and_continue
      expect(@acquisition_page.enabled? movement_tab).to be false

      @acquisition_page.wait_for_element_and_click(primary_tab)
      ad_text = test_run.driver.find_element(:xpath => '//label[contains(., "Accession date")]/following-sibling::div//input').attribute('value')
      expect(ad_text == current_date)
      @acquisition_page.wait_for_element_and_click(:xpath => '//button[@aria-label = "close"]')
      @acquisition_page.wait_for_element_and_type(@acquisition_page.structured_date_input_locator([]),  (Date.today - i).to_s)
      @acquisition_page.hit_enter
      current_date = (Date.today - i).to_s

      exhibition_tab = {:xpath => '//button[@data-recordtype = "exhibition"]'}
      @acquisition_page.wait_for_element_and_click(exhibition_tab)
      dialog_popup = @acquisition_page.element_text(:xpath => '//div[@role = "dialog"]//div')
      expect(dialog_popup.include? "about to leave a record that has unsaved changes").to be true

      @acquisition_page.save_and_continue
      expect(@acquisition_page.enabled? exhibition_tab).to be false

      @acquisition_page.wait_for_element_and_click(primary_tab)
      ad_text = test_run.driver.find_element(:xpath => '//label[contains(., "Accession date")]/following-sibling::div//input').attribute('value')
      expect(ad_text == current_date)

      @acquisition_page.wait_for_element_and_click(:xpath => '//button[@aria-label = "close"]')
    end

    it "Navigates Between ALL Secondary and Primary Tabs" do
      @acquisition_page.quick_search("Acquisitions", [], @core_id)
      @search_results_page.click_result(0)

      i = 8
      all_secondary_tabs.each do |tab|
        ["close", "cancel"].each do |button|
          @acquisition_page.wait_for_element_and_type(@acquisition_page.structured_date_input_locator([]),  (Date.today - i).to_s)
          @acquisition_page.hit_enter
          @acquisition_page.select_related_type tab

          dialog_popup = @acquisition_page.element_text(:xpath => '//div[@role = "dialog"]//div')
          expect(dialog_popup.include? "about to leave a record that has unsaved changes").to be true

          @acquisition_page.wait_for_element_and_click(:xpath => "//div[@role = \"presentation\"]//button[@name = \"#{button}\"]")
          expect(@acquisition_page.exists? dialog_popup).to be false
          if button == "close"
            @acquisition_page.wait_for_element_and_click(:xpath => '//button[@aria-label = "close"]')
          end
          i += 1
        end

        secondary_tab = {:xpath => "//button[contains(., \"#{tab}\")]"}
        @acquisition_page.wait_for_element_and_click(secondary_tab)
        @acquisition_page.revert_and_continue
        expect(@acquisition_page.enabled? secondary_tab).to be false

        @acquisition_page.wait_for_element_and_click(primary_tab)
        ad_text = test_run.driver.find_element(:xpath => '//label[contains(., "Accession date")]/following-sibling::div//input').attribute('value')
        expect(ad_text == current_date).to be true
        @acquisition_page.wait_for_element_and_type(@acquisition_page.structured_date_input_locator([]),  (Date.today - i).to_s)
        @acquisition_page.hit_enter
        current_date = (Date.today - i).to_s

        @acquisition_page.wait_for_element_and_click(secondary_tab)
        dialog_popup = @acquisition_page.element_text(:xpath => '//div[@role = "dialog"]//div')
        expect(dialog_popup.include? "about to leave a record that has unsaved changes").to be true

        @acquisition_page.save_and_continue
        expect(@acquisition_page.enabled? secondary_tab).to be false

        @acquisition_page.wait_for_element_and_click(primary_tab)
        ad_text = test_run.driver.find_element(:xpath => '//label[contains(., "Accession date")]/following-sibling::div//input').attribute('value')
        expect(ad_text == current_date)
        @acquisition_page.wait_for_element_and_click(:xpath => '//button[@aria-label = "close"]')
        i += 1
      end
    end
  end

end
