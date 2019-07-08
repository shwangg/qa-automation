require_relative '../spec_helper'

describe 'CollectionSpace' do

  include Logging
  include WebDriverManager

  test_run = TestConfig.new

  before(:all) do
    test_run = TestConfig.new
    test_run.set_driver launch_browser
    @admin = test_run.get_admin_user
    @login_page = test_run.get_page CoreLoginPage
    @login_page.load_page
  end

  after(:all) { quit_browser test_run.driver }

  it('allows a user to log in') { @login_page.log_in(@admin.username, @admin.password) }

  it('allows a user to log out') { @login_page.log_out }

end
