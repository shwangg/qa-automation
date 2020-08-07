require_relative '../spec_helper'

test_run = TestConfig.new
# test_data = test_run.create_autocomplete_term_matching_search_test_data
test_data = {
  {"briefDescriptions"=>[{"briefDescription"=>"duplicate"}]}
}

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
    @create_new_page = test_run.get_page CoreCreateNewPage
    @object_page = test_run.get_page CoreObjectPage
    @login_page.load_page
    @login_page.log_in(@admin.username, @admin.password)
    @search_page.click_create_new_link
    @create_new_page.click_create_new_object
  end
  # {"briefDescriptions"=>[{"briefDescription"=>"Test 1 - brief description 1"}, {"briefDescription"=>"Test 1 - brief description 2"}]

    after(:all) { quit_browser test_run.driver }
    test_data.each do |test|
        it "create new record with #{test}" do
            test_run.set_unique_test_id(test_data, CoreObjectData::OBJECT_NUM.name)
            data_input_errors = @object_page.enter_number_and_text test
            Config.click_wait
            @object_page.hit_tab
            begin
              @object_page.click_clone_button
            rescue
              print('ok')
            end

            begin
              @object_page.click_save_button
              @object_page.click_clone_button
            rescue
              print("bad")
            end
        # @object_page.create_new_object test[CoreObjectData::OBJECT_NUM.name]
        # begin
        #   click_save_button
        # rescue
        #   # error
        # end
        @object_page.click_search_link
        # search for duplicates
        # Confirm exists for both

        end
    end

    # test_data.each do |test|
    #     it "allows an admin to create a new collection loan in with #{test}" do
    #         @create_new_page.click_create_new_object
            
            
    #     end
    # end
end
