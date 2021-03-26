require_relative '../spec_helper'

describe 'CollectionSpace' do

  include Logging
  include WebDriverManager

  before(:all) do
    @test = TestConfig.new Deployment::CORE
    @test.set_driver launch_browser
    @admin = @test.get_admin_user
    @login_page = LoginPage.new @test
    @create_new_page = CreateNewPage.new @test
    @search_page = SearchPage.new @test
    @search_results_page = SearchResultsPage.new @test
    @object_page = ObjectPage.new @test
    @acquisition_page = AcquisitionPage.new @test

    @login_page.load_page
    @login_page.log_in(@admin.username, @admin.password)

    @test_proc = {
      CoreAcquisitionData::ACQUIS_METHOD.name => 'gift',
      CoreAcquisitionData::ACCESSION_DATE_GRP.name => (Date.today - 1).to_s
    }
    @test.set_unique_test_id(@test_proc, CoreAcquisitionData::ACQUIS_REF_NUM.name)
    @search_page.click_create_new_link
    @create_new_page.click_create_new_acquisition
    @acquisition_page.create_new_acquisition @test_proc
    @core_id = "#{@test_proc[CoreAcquisitionData::ACQUIS_REF_NUM.name]}"
  end

  after(:all) { quit_browser @test.driver }

  ## Methods and variables to be used for this test
  def accession_date_value; @acquisition_page.element_value(@acquisition_page.input_locator_by_label("Accession date")) end
  def secondary_tab(tab); {:xpath => "//button[text()= \"#{tab}\"]"} end
  def variation_button(type); {:xpath => "//div[@role = \"presentation\"]//button[@name = \"#{type}\"]"} end

  all_secondary_tabs = ["Objects", "Acquisitions", "Condition Checks", "Conservation Treatments", \
      "Exhibitions", "Groups", "Intakes", "Loans In", "Loans Out", "Location/Movement/Inventory", \
      "Media Handling", "Object Exits", "Use of Collections", "Valuation Controls"]
  current_date = (Date.today - 1).to_s
  days_1, days_2 = 15, 8
  unsaved_message = "You're about to leave a record that has unsaved changes."
  ##

  it "Navigates Between Secondary and Primary Tabs" do
    @search_page.quick_search("Acquisitions", [], @core_id)
    @search_results_page.click_result(0)
    [["close", "Location/Movement/Inventory"], ["cancel", "Exhibitions"]].each do |(button, tab)|
      @acquisition_page.wait_for_element_and_type(@acquisition_page.structured_date_input_locator([]), (Date.today - days_1).to_s)
      @acquisition_page.hit_enter
      @acquisition_page.select_related_type tab
      expect(@acquisition_page.element_text(@acquisition_page.modal_message)).to eql(unsaved_message)
      @acquisition_page.wait_for_element_and_click(variation_button(button))
      expect(@acquisition_page.exists? @acquisition_page.modal_message).to be false
      days_1 += 1
    end

    @acquisition_page.click_movement_secondary_tab
    @acquisition_page.revert_and_continue
    expect(@acquisition_page.enabled? @acquisition_page.movement_secondary_tab).to be false

    @acquisition_page.click_primary_record_tab
    expect(accession_date_value).to eql(current_date)
    @acquisition_page.click_close_tab("Location/Movement/Inventory")
    @acquisition_page.wait_for_element_and_type(@acquisition_page.structured_date_input_locator([]), (Date.today - days_1).to_s)
    @acquisition_page.hit_enter
    current_date = (Date.today - days_1).to_s

    @acquisition_page.click_exhibitions_tab
    expect(@acquisition_page.element_text(@acquisition_page.modal_message)).to eql(unsaved_message)
    @acquisition_page.save_and_continue
    expect(@acquisition_page.enabled? @acquisition_page.exhibition_tab).to be false

    @acquisition_page.click_primary_record_tab
    expect(accession_date_value).to eql(current_date)
    @acquisition_page.click_close_tab("Exhibitions")
  end

  all_secondary_tabs.each do |tab|
    it "Navigates Between \"#{tab}\" Secondary Tab and Primary Tab" do
      @acquisition_page.quick_search("Acquisitions", [], @core_id)
      @search_results_page.click_result(0)
      ["close", "cancel"].each do |button|
        @acquisition_page.wait_for_element_and_type(@acquisition_page.structured_date_input_locator([]), (Date.today - days_2).to_s)
        @acquisition_page.hit_enter
        @acquisition_page.select_related_type tab
        expect(@acquisition_page.element_text(@acquisition_page.modal_message)).to eql(unsaved_message)
        @acquisition_page.wait_for_element_and_click(variation_button(button))
        expect(@acquisition_page.exists? @acquisition_page.modal_message).to be false
        if button == "close"
          @acquisition_page.click_close_tab(tab)
        end
        days_2 += 1
      end

      @acquisition_page.wait_for_element_and_click(secondary_tab(tab))
      @acquisition_page.revert_and_continue
      expect(@acquisition_page.enabled? secondary_tab(tab)).to be false

      @acquisition_page.click_primary_record_tab
      expect(accession_date_value).to eql(current_date)
      @acquisition_page.wait_for_element_and_type(@acquisition_page.structured_date_input_locator([]), (Date.today - days_2).to_s)
      @acquisition_page.hit_enter
      current_date = (Date.today - days_2).to_s

      @acquisition_page.wait_for_element_and_click(secondary_tab(tab))
      expect(@acquisition_page.element_text(@acquisition_page.modal_message)).to eql(unsaved_message)
      @acquisition_page.save_and_continue
      expect(@acquisition_page.enabled? secondary_tab(tab)).to be false

      @acquisition_page.wait_for_element_and_click(@acquisition_page.primary_tab)
      expect(accession_date_value).to eql(current_date)
      @acquisition_page.click_close_tab(tab)
      days_2 += 1
    end
  end

end
