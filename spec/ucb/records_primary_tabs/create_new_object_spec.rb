require_relative '../../../spec_helper'

[Deployment::CORE_UCB, Deployment::PAHMA].each do |deploy|

  test_run = TestConfig.new deploy
  test_data = test_run.create_object_test_data deploy
  test_data.each { |test| test_run.set_unique_test_id(test, CoreObjectData::OBJECT_NUM.name); sleep(1) }

  describe "#{deploy.name} CollectionSpace" do

    include Logging
    include WebDriverManager

    before(:all) do
      test_run.set_driver launch_browser
      @admin = test_run.get_admin_user
      @login_page = LoginPage.new test_run
      @search_page = SearchPage.new test_run
      @search_results_page = SearchResultsPage.new test_run
      @create_new_page = CreateNewPage.new test_run
      @object_page = ObjectPage.new test_run

      @login_page.load_page
      @login_page.log_in(@admin.username, @admin.password)
    end

    after(:all) { quit_browser test_run.driver }

    test_data.each do |test|

      it("allows a user to click the Create New link for test ID #{test[CoreObjectData::OBJECT_NUM.name]}") { @search_page.click_create_new_link }
      it("allows a user to click the Object link for test ID #{test[CoreObjectData::OBJECT_NUM.name]}") { @create_new_page.click_create_new_object }

      if deploy == Deployment::CORE_UCB
        it("allows a user to enter an Object Number for test ID #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.enter_object_number test }
        it("allows a user to enter Number of Object for test ID #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.enter_num_objects test }
        it("allows a user to enter Other Numbers for test ID #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.enter_other_numbers test }
        it("allows a user to enter Responsible Departments for test ID #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.enter_resp_depts test }
        it("allows a user to select Collection for test ID #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.select_collection test }
        it("allows a user to select Status for test ID #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.select_status test }
        it("allows a user to enter Publish To for test ID #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.enter_publish_to test }
        it("allows a user to select Inventory Status for test ID #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.select_inventory_status test }
        it("allows a user to enter Brief Description for test ID #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.enter_brief_description test }
        it("allows a user to enter Distinguishing Features for test ID #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.enter_dist_features test }
        it("allows a user to enter Comments for test ID #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.enter_comments test }
        it("allows a user to enter Titles for test ID #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.enter_titles test }
        it("allows a user to enter Object Names for test ID #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.enter_object_names test }
      end

      if deploy == Deployment::PAHMA
        it("allows a user to enter a Museum Number for test ID #{test[PAHMAObjectData::OBJECT_NUM.name]}") { @object_page.enter_pahma_museum_number test }
        it("allows a user to select a Legacy Dept for test ID #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.select_pahma_legacy_dept test }
        it("allows a user to enter a Number of Pieces for test ID #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.enter_pahma_num_pieces test }
        it("allows a user to enter a Count Note for test ID #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.enter_pahma_count_note test }
        it("allows a user to select Is Component for test ID #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.select_pahma_is_component test }
        it("allows a user to select Object Statuses for test ID #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.select_pahma_object_statuses test }
        it("allows a user to enter Alternate Numbers for test ID #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.enter_pahma_alt_num test }
        it("allows a user to enter a Description for test ID #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.enter_pahma_desc test }
        it("allows a user to enter Object Classes for test ID #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.enter_pahma_object_classes test }
        it("allows a user to enter Object Names for test ID #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.enter_pahma_object_names test }
        it("allows a user to enter Responsible Collection Mananger for test ID #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.enter_pahma_resp_collection_mgr test }
        it("allows a user to select Object Type for test ID #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.select_pahma_object_type test }
        it("allows a user to enter Associated Cultural Groups for test ID #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.enter_pahma_assoc_cult_grps test }
        it("allows a user to enter Ethnographic File Codes for test ID #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.enter_pahma_enthno_file_codes test }
        it("allows a user to enter Comments for test ID #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.enter_pahma_comments test }
        it("allows a user to enter Annotations for test ID #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.enter_pahma_annotations test }
        it("allows a user to enter Dimensions for test ID #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.enter_pahma_dimensions test }
        it("allows a user to enter Materials for test ID #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.enter_pahma_materials test }
        it("allows a user to enter Taxonomics for test ID #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.enter_pahma_taxonomics test }
        it("allows a user to enter Titles for test ID #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.enter_pahma_titles test }
        it("allows a user to enter Context of Use for test ID #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.enter_pahma_usages test }
        it("allows a user to select Series for test ID #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.select_pahma_series test }
        it("allows a user to select Collections for test ID #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.select_pahma_collections test }
        it("allows a user to select TMS Source for test ID #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.select_pahma_tms_source test }
      end

      it("allows a user to save new object num #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.save_record }
      
      it("shows the right Object Number for test ID #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.verify_object_num test }

      if deploy == Deployment::CORE_UCB
        it("shows the right Number of Object for test ID #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.verify_num_objects test }
        it("shows the right Other Numbers for test ID #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.verify_other_num test }
        it("shows the right Responsible Departments for test ID #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.verify_resp_depts test }
        it("shows the right Collection for test ID #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.verify_collection test }
        it("shows the right Status for test ID #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.verify_status test }
        it("shows the right Publish To for test ID #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.verify_publish_to_list test }
        it("shows the right Inventory Status for test ID #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.verify_inventory_status test }
        it("shows the right Brief Description for test ID #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.verify_brief_descriptions test }
        it("shows the right Distinguishing Features for test ID #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.verify_distinguishing_features test }
        it("shows the right Comments for test ID #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.verify_comments test }
        it("shows the right Titles for test ID #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.verify_titles test }
        it("shows the right Object Names for test ID #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.verify_object_names test }
      end

      it "allows a user to search Objects for object num #{test[CoreObjectData::OBJECT_NUM.name]}" do
        @object_page.click_search_link
        @search_page.full_text_search test[CoreObjectData::OBJECT_NUM.name]
        @search_results_page.wait_for_results
        expect(@search_results_page.row_exists? test[CoreObjectData::OBJECT_NUM.name]).to be true
      end
    end
  end
end
