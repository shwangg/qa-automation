require_relative '../spec_helper'

module WebDriverManager

  include Logging
  include Config

  def launch_browser
    driver_config = webdriver_settings
    browser = driver_config['browser']
    logger.warn "Launching #{browser.capitalize}"
    driver = case driver_config['browser']

               when 'chrome'
                 options = Selenium::WebDriver::Chrome::Options.new
                 options.add_argument 'headless' if driver_config['headless']
                 Selenium::WebDriver.for :chrome, :options => options

               when 'firefox'
                 options = Selenium::WebDriver::Firefox::Options.new
                 options.add_argument '-headless' if driver_config['headless']
                 Selenium::WebDriver.for :firefox, :options => options

               when 'safari'
                 Selenium::WebDriver.for :safari

               else
                 logger.error 'Designated WebDriver is not supported'
                 fail
             end
    driver.manage.window.resize_to(1600, 900)
    driver
  end

  def quit_browser(driver)
    logger.warn "Quitting #{driver.browser.capitalize}"
    driver.quit
  end

end
