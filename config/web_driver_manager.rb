require 'selenium-webdriver'
require_relative 'config'

class WebDriverManager

  def WebDriverManager.launch_browser
    driver_config = Config.settings['webdriver']
    browser = case driver_config['browser']

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
                 puts 'Designated WebDriver is not supported'
                 nil
             end
    browser.manage.window.resize_to(1600, 900)
    browser
  end

end
