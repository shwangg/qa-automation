require_relative '../../spec_helper'

include Logging
include WebDriverManager

Before do
  @config = TestConfig.new
  @config.set_driver launch_browser
  @page = WebAppPage.new @config.driver
  @bmu_page = BMUPage.new @config.driver
  @img_browser_page = ImageBrowserPage.new @config.driver
  @i_reports_page = IReportsPage.new @config.driver
  @landing_page = LandingPage.new @config.driver
  @login_page = LoginPage.new @config.driver
  @search_page = WebappSearchPage.new @config.driver
end

After do
  quit_browser @config.driver
end
