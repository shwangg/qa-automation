require_relative '../spec_helper'

module Page

  include Logging

  # Navigates to a URL
  # @param [String] url
  def get(url)
    @driver.get url
  end

  # Goes back one page
  def go_back
    @driver.navigate.back
  end

  # Executes the given JavaScript
  # @param [String] script
  def execute_script(script)
    @driver.execute_script script
  end

  # Saves a screenshot to a given path
  # @param [String] file_path
  def save_screenshot(file_path)
    @driver.save_screenshot file_path
  end

  # Returns the current page title
  # @return [String]
  def page_title
    @driver.title
  end

  # Returns the current page URL
  # @return [String]
  def url
    @driver.current_url
  end

  # Accepts a browser alert
  def accept_alert
    @driver.switch_to.alert.accept
  end

  # Waits a given number of seconds for a block to complete
  # @param [Integer] timeout
  def wait_until(timeout, &blk)
    wait = Selenium::WebDriver::Wait.new :timeout => timeout
    wait.until &blk
  end

  # Returns an element with a given locator, or nil if it cannot be found
  # @param [Hash] locator
  # @return [Selenium::WebDriver::Element]
  def element(locator)
    @driver.find_element(locator)
  rescue Selenium::WebDriver::Error::NoSuchElementError
    nil
  end

  # Returns to true if an element with a given locator can be found
  # @param [Hash] locator
  # @return [boolean]
  def exists?(locator)
    element(locator).size
    true
  rescue NoMethodError
    false
  end

  # Waits a given number of seconds to find an element
  # @param [Hash] locator
  # @param [Integer] timeout
  def when_exists(locator, timeout)
    wait_until(timeout) { exists? locator }
  end

  # Waits a given number of seconds for an element to cease to exist
  # @param [Hash] locator
  # @param [Integer] timeout
  def when_not_exists(locator, timeout)
    wait_until(timeout) { !element(locator) }
  end

  # Waits a given number of seconds for an existing element to be visible
  # @param [Hash] locator
  # @param [Integer] timeout
  def when_displayed(locator, timeout)
    wait_until(timeout) { element(locator).displayed? }
  end

  # Waits a given number of seconds for a visible element to become invisible
  # @param [Hash] locator
  # @@param [Integer] timeout
  def when_not_displayed(locator, timeout)
    wait_until(timeout) { !element(locator).displayed? }
  end

  # Waits a short time for an element to be present and clicks it. Intended for Ajax updates.
  # @param [Hash] locator
  def wait_for_element_and_click(locator)
    when_exists(locator, Config.short_wait)
    element(locator).click
  end

  # Waits a moderate time for an element to be present and clicks it. Intended for page loads.
  def wait_for_page_and_click(locator)
    when_exists(locator, Config.medium_wait)
    element(locator).click
  end

  # Waits a short time for an input to be present, removes any existing text from it, and sends a given string to it.
  # @param [Hash] locator
  # @param [String] string
  def wait_for_element_and_type(locator, string)
    wait_for_element_and_click locator
    element(locator).clear
    element(locator).send_keys string
  end

  # Waits a short time for a select to be present and selects the option with the given text.
  # @param [Hash] locator
  # @param [String] option
  def wait_for_element_and_select(locator, option)
    wait_for_element_and_click locator
    select = Selenium::WebDriver::Support::Select.new element(locator)
    select.select_by(:text, option)
  end

  # Returns true if a clock completes, otherwise false
  # @return [boolean]
  def verify_block(&blk)
    begin
      return true if yield
    rescue => e
      logger.debug e.message
      false
    end
  end

end
