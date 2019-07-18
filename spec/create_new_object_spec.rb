require_relative '../spec_helper'

test_run = TestConfig.new
test_data = test_run.create_object_test_data

if test_run.deployment == Deployment::CORE

  describe 'CollectionSpace' do

    include Logging
    include WebDriverManager

    before(:all) do
      test_run.set_driver launch_browser
      @admin = test_run.get_admin_user
      @login_page = test_run.get_page CoreLoginPage
      @search_page = test_run.get_page CoreSearchPage
      @search_results_page = test_run.get_page CoreSearchResultsPage
      @create_new_page = test_run.get_page CoreCreateNewPage
      @object_page = test_run.get_page CoreObjectPage

      @login_page.load_page
      @login_page.log_in(@admin.username, @admin.password)
    end

    after(:all) { quit_browser test_run.driver }

    test_data.each do |test|
      it "allows an admin to create a new collection object with #{test}" do
        test_run.set_unique_test_id(test, CoreObjectData::OBJECT_NUM.name)
        @search_page.click_create_new_link
        @create_new_page.click_create_new_object
        data_input_errors = @object_page.create_new_object test
        expect(data_input_errors).to be_empty
      end

      it "allows an admin to search Objects for a new collection object with #{test}" do
        @object_page.click_search_link
        @search_page.full_text_search test[CoreObjectData::OBJECT_NUM.name]
        @search_results_page.wait_for_results
        expect(@search_results_page.row_exists? test[CoreObjectData::OBJECT_NUM.name]).to be true
      end

      it "search results allow a user to view object metadata for a new collection object with #{test}" do
        @search_results_page.click_result test[CoreObjectData::OBJECT_NUM.name]
        object_data_errors = @object_page.verify_object_data test
        expect(object_data_errors).to be_empty
      end
    end
  end
end
