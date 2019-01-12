require_relative '../spec_helper'

describe 'CollectionSpace' do

  include Logging
  include WebDriverManager

  test_run = TestConfig.new

  before(:all) do
    test_run = TestConfig.new
    test_run.set_driver launch_browser
    @admin = test_run.get_admin_user
    @homepage = test_run.get_page Homepage
    @homepage.load_page
  end

  after(:all) { quit_browser test_run.driver }

  it('allows a user to log in') { @homepage.log_in(@admin.username, @admin.password) }

  it('allows a user to log out') { @homepage.log_out }

end
