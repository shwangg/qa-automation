require_relative '../spec_helper'

describe 'CollectionSpace' do

  include Logging
  include WebDriverManager

  before(:all) do
    @test = TestConfig.new Deployment::CORE
    @test.set_driver launch_browser
    @admin = @test.get_admin_user
    @login_page = LoginPage.new @test
    @login_page.load_page
  end

  after(:all) { quit_browser @test.driver }

  it('allows a user to log in') { @login_page.log_in(@admin.username, @admin.password) }

  it('allows a user to log out') { @login_page.log_out }

end
