require_relative '../spec_helper'

module WebDriverManager

  include Logging

  # Launches the configured browser and returns the browser driver, headless if so configured. Allows Chrome, Firefox, or
  # Safari, though Chrome is the main one supported for now.
  # @return [Selenium::WebDriver]
  def launch_browser
    driver_config = Config.webdriver_settings
    browser = driver_config[:browser]
    logger.warn "Launching #{browser.capitalize}"
    driver = case browser

               when 'chrome'
                 options = Selenium::WebDriver::Chrome::Options.new
                 options.add_argument 'headless' if driver_config[:headless]
                 Selenium::WebDriver.for :chrome, :options => options

               when 'firefox'
                 options = Selenium::WebDriver::Firefox::Options.new
                 options.add_argument '-headless' if driver_config[:headless]
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

  # Quits the browser
  # @param [Selenium::WebDriver] driver
  def quit_browser(driver)
    logger.warn "Quitting #{driver.browser.capitalize}"
    driver.quit
  end

end
