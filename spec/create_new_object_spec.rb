require_relative '../spec_helper'

describe 'CollectionSpace' do

  include Logging
  include WebDriverManager

  test_run = TestConfig.new
  test_data = test_run.create_object_test_data

  before(:all) do
    test_run.set_driver launch_browser
    @admin = test_run.get_admin_user
    @login_page = test_run.get_page LoginPage
    @search_page = test_run.get_page SearchPage
    @create_new_page = test_run.get_page CreateNewPage
    @new_object_page = test_run.get_page NewObjectPage

    @login_page.load_page
    @login_page.log_in(@admin.username, @admin.password)
  end

  after(:all) { quit_browser test_run.driver }

  test_data.each do |test|
    it "allows an admin to create a new collection object with #{test}" do
      test_run.set_unique_test_id(test, ObjectData::OBJECT_NUM.name)
      @search_page.click_create_new_link
      @create_new_page.click_create_new_object
      @new_object_page.create_new_object test
    end
  end

end
