require_relative '../spec_helper'

describe 'CollectionSpace' do

  include Logging
  include WebDriverManager

  before(:all) do
    @driver = launch_browser
    test = TestConfig.new @driver
    @homepage = test.get_page(@driver, Homepage)
    @admin = test.get_users.find { |u| u.role == UserRole::ADMIN }
    @homepage.load_page
  end

  after(:all) { quit_browser @driver }

  it('allows a user to log in') { @homepage.log_in(@admin.username, @admin.password) }

  it('allows a user to log out') { @homepage.log_out }

end
