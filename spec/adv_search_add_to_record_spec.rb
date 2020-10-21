require_relative '../spec_helper'

test_run = TestConfig.new
def new_search; {:xpath => '//label[text()="Find"]'} end

describe 'CollectionSpace' do

  include Logging
  include WebDriverManager
  include Page
  include CollectionSpacePages

  before(:all) do
    test_run = TestConfig.new
    test_run.set_driver launch_browser
    @admin = test_run.get_admin_user
    @login_page = test_run.get_page CoreLoginPage
    @search_page = test_run.get_page CoreSearchPage
    @result_page = test_run.get_page CoreSearchResultsPage
    @create_new_page = test_run.get_page CoreCreateNewPage
    @group_page = test_run.get_page CoreGroupPage
    @login_page.load_page
    @login_page.log_in(@admin.username, @admin.password)
  end

    after(:all) { quit_browser test_run.driver }

    context 'Relate Cataloging Records to an Existing Group Record' do

      it "creates and saves new group object" do
        @search_page.click_create_new_link
        @create_new_page.click_create_new_group
        data = {CoreGroupData::TITLE.name => "group1 sean"}
        @group_page.enter_number data
        @group_page.click_save_button
      end

      it "search for objects with empty search box" do
        @group_page.click_search_link
        @search_page.select_record_type_option("Objects")
        @search_page.full_text_search("")
        @result_page.wait_for_results
        expect(@result_page.row_exists? "").to be true
      end

      it "selects the first two objects from search and relate them to the previous group object" do
        @result_page.relate_first_two
        @result_page.when_exists(new_search, Config.long_wait)
        @search_page.select_record_type_option("Groups")
        @search_page.full_text_search("group1 sean")
        @result_page.relate_record("group1 sean")
      end

    end

    context 'View Procedure Record to See Related Records' do

      it "search and select the test group data" do
        @result_page.click_search_link
        @search_page.select_record_type_option("Groups")
        @search_page.full_text_search("group1 sean")
        @result_page.wait_for_results
        @result_page.click_result("group1 sean")
      end

      it "check for relations and remove them, then delete record" do
        @group_page.select_related('Objects')
        @group_page.select_and_unrelate_two
        @group_page.select_primary
        @group_page.delete_record
      end

    end
end
