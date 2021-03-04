require_relative '../../../spec_helper'

test_run = TestConfig.new Deployment::CORE_UCB
test_data = test_run.create_object_test_data
test_data.each { |test| test_run.set_unique_test_id(test, CoreObjectData::OBJECT_NUM.name); sleep(1) }

describe 'CollectionSpace' do

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

    it("allows an admin to click Create New for #{test[CoreObjectData::OBJECT_NUM.name]}") { @search_page.click_create_new_link }
    it("allows an admin to click an Object to create for #{test[CoreObjectData::OBJECT_NUM.name]}") { @create_new_page.click_create_new_object }
    it("allows an admin to enter an Object Number for #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.enter_object_number test }
    it("allows an admin to enter Number of Object for #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.enter_num_objects test }
    it("allows an admin to enter Other Numbers for #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.enter_other_numbers test }
    it("allows an admin to enter Responsible Departments for #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.enter_resp_depts test }
    it("allows an admin to select Collection for #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.select_collection test }
    it("allows an admin to select Status for #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.select_status test }
    it("allows an admin to enter Publish To for #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.enter_publish_to test }
    it("allows an admin to select Inventory Status for #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.select_inventory_status test }
    it("allows an admin to enter Brief Description for #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.enter_brief_description test }
    it("allows an admin to enter Distinguishing Features for #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.enter_dist_features test }
    it("allows an admin to enter Comments for #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.enter_comments test }
    it("allows an admin to enter Titles for #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.enter_titles test }
    it("allows an admin to enter Object Names for #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.enter_object_names test }
    it("allows an admin to save new object #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.save_record }

    it("shows the right Object Number for #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.verify_object_num test }
    it("shows the right Number of Object for #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.verify_num_objects test }
    it("shows the right Other Numbers for #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.verify_other_num test }
    it("shows the right Responsible Departments for #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.verify_resp_depts test }
    it("shows the right Collection for #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.verify_collection test }
    it("shows the right Status for #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.verify_status test }
    it("shows the right Publish To for #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.verify_publish_to_list test }
    it("shows the right Inventory Status for #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.verify_inventory_status test }
    it("shows the right Brief Description for #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.verify_brief_descriptions test }
    it("shows the right Distinguishing Features for #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.verify_distinguishing_features test }
    it("shows the right Comments for #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.verify_comments test }
    it("shows the right Titles for #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.verify_titles test }
    it("shows the right Object Names for #{test[CoreObjectData::OBJECT_NUM.name]}") { @object_page.verify_object_names test }

    it "allows an admin to search Objects for #{test[CoreObjectData::OBJECT_NUM.name]}" do
      @object_page.click_search_link
      @search_page.full_text_search test[CoreObjectData::OBJECT_NUM.name]
      @search_results_page.wait_for_results
      expect(@search_results_page.row_exists? test[CoreObjectData::OBJECT_NUM.name]).to be true
    end
  end
end
