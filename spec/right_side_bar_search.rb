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
      @object_page = test_run.get_page CoreObjectPage
      @acquisition_page = test_run.get_page CoreAcquisitionPage
      @media_handling_page = test_run.get_page CoreMediaHandlingPage

      @login_page.load_page
      @login_page.log_in("students@cspace.berkeley.edu", "cspacestudents")
      #@admin.username, @admin.password)
    end

    after(:all) { quit_browser test_run.driver }

    related_obj_open_button = {:xpath => '//button[@name = "add"]/preceding-sibling::a[contains(@href,"collectionobject")]'}
    related_proc_open_button = {:xpath => '//button[@name = "add"]/preceding-sibling::a[contains(@href,"procedure")]'}

    it "search related object records" do
      @search_page.click_create_new_link
      @create_new_page.click_create_new_object
      test_1_object = {  CoreObjectData::OBJECT_NUM.name => Time.now.to_i  }
    #  test_1_ref_num = Time.now.to_i
  #    @object_page.wait_for_element_and_type(@object_page.input_locator([],"objectNumber"), test_1_ref_num)
  #    @object_page.click_save_button
      @object_page.create_new_object test_1_object
      @object_page.scroll_to_top
      @object_page.wait_for_element_and_click(related_obj_open_button)
      header_text = @object_page.element_text(:xpath => '//div[contains(@class, "SearchResultSummary")]//span')
      expect(header_text == "No records found")

      @object_page.wait_for_element_and_click(:xpath => "//a[contains(., \"#{test_1_object[CoreObjectData::OBJECT_NUM.name]}\")]")
      @object_page.select_related_type("Objects")
      related_obj_1, related_obj_2 = Time.now.to_i, 6 * Time.now.to_i
      [related_obj_1, related_obj_2].each do |ref_num|
        @object_page.click_create_new_button
        @object_page.wait_for_element_and_type(@object_page.input_locator([],"objectNumber"), ref_num)
        @object_page.save_record
      end
      @object_page.wait_for_element_and_click(related_obj_open_button)
      test_run.driver.navigate.refresh
      [related_obj_1, related_obj_2].each do |ref_num|
        related_obj_row = {:xpath => "//div[@role = \"gridcell\"][contains(text(), \"#{ref_num}\")]"}
        expect(@object_page.exists? related_obj_row)
      end
      title_bar_expected = {:xpath => "//header[contains(., \"Objects related to \"#{test_1_object[CoreObjectData::OBJECT_NUM.name]}\"\")]"}
      expect(@object_page.exists? title_bar_expected)
    end

    it "search related procedural records" do
      @search_page.click_create_new_link
      @create_new_page.click_create_new_acquisition
      test_2_acquisition = { CoreAcquisitionData::ACQUIS_REF_NUM.name => Time.now.to_i }
    #  test_2_ref_num = Time.now.to_i
    #  @object_page.wait_for_element_and_type(@object_page.input_locator([],"acquisitionReferenceNumber"), test_1_ref_num)
      @acquisition_page.create_new_acquisition test_2_acquisition
      @acquisition_page.scroll_to_top
      @acquisition_page.wait_for_element_and_click(related_proc_open_button)
      header_text = @object_page.element_text(:xpath => '//div[contains(@class, "SearchResultSummary")]//span')
      expect(header_text == "No records found")

      @acquisition_page.wait_for_element_and_click(:xpath => "//a[contains(., \"#{test_2_acquisition[CoreAcquisitionData::ACQUIS_REF_NUM.name]}\")]")
      @acquisition_page.select_related_type("Media Handling")
      related_proc_1, related_proc_2 = Time.now.to_i, 6 * Time.now.to_i
      [related_proc_1, related_proc_2].each do |ref_num|
        @acquisition_page.click_create_new_button
        @acquisition_page.wait_for_element_and_type(@acquisition_page.input_locator([],"identificationNumber"), ref_num)
        @acquisition_page.save_record
      end
      @acquisition_page.wait_for_element_and_click(related_proc_open_button)
      test_run.driver.navigate.refresh
      [related_proc_1, related_proc_2].each do |ref_num|
        related_proc_row = {:xpath => "//div[@role = \"gridcell\"][contains(text(), \"#{ref_num}\")]"}
        expect(@acquisition_page.exists? related_proc_row)
      end
      title_bar_expected = {:xpath => "//header[contains(., \"Procedures related to \"#{test_2_acquisition[CoreAcquisitionData::ACQUIS_REF_NUM.name]}\"\")]"}
      expect(@acquisition_page.exists? title_bar_expected)
    end

    it "test keyboard accessibility" do
      ##TODO
      #test that the search button (for Search Related Objects/Procedures) can be navigated to and activated by keyboard only
      #expect: should be able to do all the above using keyboard only; tab-ordering and keys should be logical; should be able to see focus at all times  
    end

  end
end
