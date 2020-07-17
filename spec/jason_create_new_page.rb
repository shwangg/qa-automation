require_relative '../spec_helper'
expectedURL = "https://core-dev.cspace.berkeley.edu/cspace/core/create"
describe 'CollectionSpace' do

  include Logging
  include WebDriverManager

  test_run = TestConfig.new

  before(:all) do
    test_run = TestConfig.new
    test_run.set_driver launch_browser
    @admin = test_run.get_admin_user
    @login_page = test_run.get_page CoreLoginPage
    @search_page = test_run.get_page CoreSearchPage
    @login_page.load_page
    @create_new_page = test_run.get_page CoreCreateNewPage
    @login_page.log_in(@admin.username, @admin.password)
  end

  after(:all) { quit_browser test_run.driver }

  it('create new page') {
    @search_page.click_create_new_link
    @create_new_page.click_create_new_link
   }
   it('Checks if new page url is correct') {
    if expectedURL == test_run.driver.current_url
    end
  }
  end