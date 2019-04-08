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

  # Waits a short time for an input to be present and enters a given string
  # @param [Hash] locator
  # @param [String] string
  def wait_for_element_and_type(locator, string)
    wait_for_element_and_click locator
    element(locator).clear
    element(locator).send_keys string if string
  end

  # Waits a short time for an input to be present and enters a given string, then waits for and select an option matching the string
  # @param [Hash] input_locator
  # @param [Hash] options_locator
  # @param [String] string
  def wait_for_autocomplete_and_select(input_locator, options_locator, string)
    wait_for_element_and_type(input_locator, string)
    wait_until(Config.short_wait) { elements(options_locator).any? &:displayed? }
    wait_until(Config.short_wait) { (elements(options_locator).select { |el| el.text == string }).any? }
    (elements(options_locator).find { |el| el.text == string }).click
  end

  # Clicks an input, waits for options to appear, enters a given string, and waits for the element's value to match
  # what was sent to the element. Retries if the value has not been updated.
  # @param [Hash] input_locator
  # @param [Hash] options_locator
  # @param [String] string
  def wait_for_options_and_type(input_locator, options_locator, string)
    wait_for_element_and_click input_locator
    wait_until(Config.short_wait) { elements(options_locator).any? &:displayed? }
    tries = 2
    begin
      tries -= 1
      element(input_locator).clear
      element(input_locator).send_keys string if string
      sleep Config.click_wait
      @driver.action.send_keys(:tab).perform
      wait_until(1, 'Element value not updated, retrying') { element(input_locator).attribute('value') == string.to_s }
    rescue
      tries.zero? ? fail : retry
    end
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
    sleep Config.click_wait
  end

  # Hits the Tab key
  def hit_tab
    @driver.action.send_keys(:tab).perform
    sleep Config.click_wait
  end

  # Hits the Escape key
  def hit_escape
    @driver.action.send_keys(:escape).perform
    sleep Config.click_wait
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
