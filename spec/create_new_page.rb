require_relative '../spec_helper'
expectedURL = "https://core-dev.cspace.berkeley.edu/cspace/core/create"
describe 'CollectionSpace' do

  include Logging
  include WebDriverManager

  before(:all) do
    @test = TestConfig.new Deployment::CORE_UCB
    @test.set_driver launch_browser
    @admin = @test.get_admin_user
    @login_page = LoginPage.new @test
    @search_page = SearchPage.new @test
    @create_new_page = CreateNewPage.new @test

    @login_page.load_page
    @login_page.log_in(@admin.username, @admin.password)
  end

  after(:all) { quit_browser @test.driver }

  it('create new page') {
    @search_page.click_create_new_link
    @create_new_page.click_create_new_link
   }
   it('Checks if new page url is correct') {
    if expectedURL == @test.driver.current_url
    end
  }
  end