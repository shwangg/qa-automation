require_relative '../spec_helper'

module Page

  include Logging

  def initialize(driver)
    @driver = driver
  end

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

  # Waits a given number of seconds for a block to complete. Logs an optional message if block fails.
  # @param [Integer] timeout
  # @param [String] msg
  def wait_until(timeout, msg=nil, &blk)
    wait = Selenium::WebDriver::Wait.new :timeout => timeout, :message => msg
    wait.until &blk
  end

  # Checks equivalence of two parameters. Will fail if they do not match or if they are not instances of String or Nil.
  # @param [Object] expected
  # @param [Object] actual
  # @param [Array<Object>] errors
  # @return [boolean]
  def text_values_match?(expected, actual, errors=nil)
    logger.debug "Checking for '#{expected}'"
    wait_until(0.5) { expected.to_s == actual.to_s }
    true
  rescue
    errors << "Expected '#{expected}', got '#{actual}'" if errors
    false
  end

  # Returns an element with a given locator, or nil if it cannot be found
  # @param [Hash] locator
  # @return [Selenium::WebDriver::Element]
  def element(locator)
    @driver.find_element(locator)
  rescue Selenium::WebDriver::Error::NoSuchElementError
    nil
  end

  # Returns an array of elements with a given locator, or an empty array if none can be found
  # @param [Hash] locator
  # @return [Array<Selenium::WebDriver::Element>]
  def elements(locator)
    @driver.find_elements(locator)
  end

  # Returns to true if a given element can be found
  # @param [Hash] locator
  # @return [boolean]
  def exists?(locator)
    @driver.find_element(locator).size
    true
  rescue
    false
  end

  # Returns the value attribute of an element with a given locator
  # @param [Hash] locator
  # @return [String]
  def element_value(locator)
    element(locator).attribute('value') if exists?(locator)
  end

  # Uses JavaScript to scroll to the top of the page
  def scroll_to_top
    @driver.execute_script('window.scrollTo(0, 0);')
  end

  # Waits a configurable time and then clicks an element with a given locator
  # @param [Hash] locator
  def click_element(locator)
    wait_until(Config.short_wait) { element(locator).enabled? }
    sleep Config.click_wait
    element(locator).click
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
    click_element locator
  end

  # Waits a moderate time for an element to be present and clicks it. Intended for page loads.
  def wait_for_page_and_click(locator)
    when_exists(locator, Config.medium_wait)
    click_element locator
  end

  # Waits a short time for an input to be present, enters a given string, and waits for the element's value to match
  # what was sent to the element. Some elements load input prompts with some latency, which can truncate the text entered.
  # Retry once if the initially entered value is not updated as expected.
  # @param [Hash] locator
  # @param [String] string
  def wait_for_element_and_type(locator, string)
    wait_for_element_and_click locator
    tries = 2
    begin
      tries -= 1
      element(locator).clear
      element(locator).send_keys string if string
      wait_until(2, 'Element value not updated, retrying') { element(locator).attribute('value') == string.to_s }
    rescue
      tries.zero? ? fail : retry
    end
  end

  # Clicks an input, waits for options to appear, and enters a given string
  # @param [Hash] input_locator
  # @param [Hash] options_locator
  # @param [String] string
  def wait_for_options_and_type(input_locator, options_locator, string)
    wait_for_element_and_click input_locator
    wait_until(Config.short_wait) { elements(options_locator).any? &:displayed? }
    element(input_locator).clear
    element(input_locator).send_keys string if string
  end

  # Clicks an input, waits for options to appear, and selects a given option
  # @param [Hash] input_locator
  # @param [Hash] options_locator
  # @param [String] option
  def wait_for_options_and_select(input_locator, options_locator, option)
    wait_for_element_and_click input_locator
    wait_until(Config.short_wait) { elements(options_locator).any? &:displayed? }
    option ?
        (elements(options_locator).find { |el| el.text == option }).click :
        (elements(options_locator).find { |el| el.text.strip.empty? }).click
  end

  # Hits the Enter key
  def hit_enter
    @driver.action.send_keys(:enter).perform
  end

  # Returns true if a clock completes, otherwise false
  # @return [boolean]
  def verify_block(&blk)
    yield
    true
  rescue => e
    logger.debug e.message
    false
  end

  # Attempts to perform an action. If the action fails, adds an action object to an array. Useful for catching errors with
  # individual fields in forms while allowing the rest of the fields to be completed.
  # @param [Array<Object>] errors
  # @param [Object] action
  # @return [Array<Object>]
  def attempt_action(errors, action, &blk)
    yield
  rescue => e
    logger.error "Action failed: #{action}"
    logger.error "#{e.message + "\n"}#{e.backtrace.join("\n ")}"
    errors << action

    # Hit ESC key in case the action has left open an element that obscures other elements (e.g., a drop-down, an alert)
    @driver.action.send_keys(:escape).perform
  end

end
