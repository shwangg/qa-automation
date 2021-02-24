require_relative '../../../spec_helper'
deploy = Deployment::BAMPFA

describe 'BAMPFA' do

  include Logging
  include WebDriverManager

  test_run = TestConfig.new deploy
  test_id = Time.now.to_i

  before(:all) do
    test_run.set_driver launch_browser

    @admin = test_run.get_admin_user
    @create_new_page = test_run.get_page CoreCreateNewPage
    @login_page = test_run.get_page CoreLoginPage
    @object_page = test_run.get_page CoreObjectPage
    @search_page = test_run.get_page CoreSearchPage

    
    @login_page.load_page
    @login_page.log_in(@admin.username, @admin.password)
  end

  after(:all) { quit_browser test_run.driver }

  it 'Create new Object record' do
    @search_page.click_create_new_link
    sleep 5
  end

end