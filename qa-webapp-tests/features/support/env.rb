require_relative '../../spec_helper'

include Logging
include WebDriverManager

Before do
  @config = TestConfig.new
  @config.set_driver launch_browser
  @page = WebAppPage.new @config
  @bmu_page = BMUPage.new @config
  @img_browser_page = ImageBrowserPage.new @config
  @i_reports_page = IReportsPage.new @config
  @landing_page = LandingPage.new @config
  @login_page = WebappLoginPage.new @config
  @search_page = WebappSearchPage.new @config
end

After do
  quit_browser @config.driver
end
