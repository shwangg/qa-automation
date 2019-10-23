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
                 options = {w3c: false}
                 options = Selenium::WebDriver::Chrome::Options.new(:options => options)
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
    log_js_errors driver
    driver.quit
  end

  # Prints errors in the browser console to the log file
  # @param [Selenium::WebDriver] driver
  def log_js_errors(driver)
    if "#{driver.browser}" == 'chrome'
      js_log = driver.manage.logs.get(:browser)
      messages = js_log.map &:message
      messages.each { |msg| logger.error "Possible JS error: #{msg}" }
    end
  end

end
