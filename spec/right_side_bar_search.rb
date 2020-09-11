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
      @login_page.log_in(@admin.username, @admin.password)
    end

    after(:all) { quit_browser test_run.driver }

    test_1_object = {  CoreObjectData::OBJECT_NUM.name => Time.now.to_i  }
    title_bar_1_expected = {:xpath => "//header[contains(., \"Objects related to \"#{test_1_object[CoreObjectData::OBJECT_NUM.name]}\"\")]"}
    test_2_acquisition = { CoreAcquisitionData::ACQUIS_REF_NUM.name => Time.now.to_i }
    title_bar_2_expected = {:xpath => "//header[contains(., \"Procedures related to \"#{test_2_acquisition[CoreAcquisitionData::ACQUIS_REF_NUM.name]}\"\")]"}
    related_rec_1, related_rec_2 = 3 * Time.now.to_i, 6 * Time.now.to_i

    def rec_id_link(page); {:xpath => "//a[contains(., \"#{page}\")]"} end
    def related_rec_row(reference_number); {:xpath => "//div[@role = \"gridcell\"][contains(text(), \"#{reference_number}\")]"} end

    it "search related object records" do
       @search_page.click_create_new_link
       @create_new_page.click_create_new_object
       @object_page.create_new_object test_1_object
       @object_page.scroll_to_top
       @object_page.click_open_related_object
       header_text = @object_page.element_text(:xpath => '//div[contains(@class, "SearchResultSummary")]//span')
       expect(header_text == "No records found")

       @object_page.wait_for_element_and_click(rec_id_link(test_1_object[CoreObjectData::OBJECT_NUM.name]))
       @object_page.select_related_type("Objects")
       [related_rec_1, related_rec_2].each do |ref_num|
         @object_page.click_create_new_button
         @object_page.wait_for_element_and_type(@object_page.input_locator([],"objectNumber"), ref_num)
         @object_page.save_record
       end
       @object_page.click_open_related_object
       test_run.driver.navigate.refresh
       [related_rec_1, related_rec_2].each do |ref_num|
         expect(@object_page.exists? related_rec_row(ref_num))
       end
       expect(@object_page.exists? title_bar_1_expected)
     end

    it "search related procedural records" do
      @search_page.click_create_new_link
      @create_new_page.click_create_new_acquisition
      @acquisition_page.create_new_acquisition test_2_acquisition
      @acquisition_page.scroll_to_top
      @acquisition_page.click_open_related_procedures
      header_text = @object_page.element_text(:xpath => '//div[contains(@class, "SearchResultSummary")]//span')
      expect(header_text == "No records found")

      @acquisition_page.wait_for_element_and_click(rec_id_link(test_2_acquisition[CoreAcquisitionData::ACQUIS_REF_NUM.name]))
      @acquisition_page.select_related_type("Media Handling")
      [related_rec_1, related_rec_2].each do |ref_num|
        @acquisition_page.click_create_new_button
        @acquisition_page.wait_for_element_and_type(@acquisition_page.input_locator([],"identificationNumber"), ref_num)
        @acquisition_page.save_record
      end
      @acquisition_page.click_open_related_procedures
      test_run.driver.navigate.refresh
      [related_rec_1, related_rec_2].each do |ref_num|
        expect(@acquisition_page.exists? related_rec_row(ref_num))
      end
      expect(@acquisition_page.exists? title_bar_2_expected)
    end

  end
end
