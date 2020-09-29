module Page

  include Logging
  include WebDriverManager

  def initialize(driver)
    @driver = driver
  end

  # NAVIGATION

  # Navigates to a URL
  # @param [String] url
  def get(url)
    logger.info "Loading URL '#{url}'"
    @driver.get url
  end

  # Goes back one page
  def go_back
    @driver.navigate.back
  end

  # Reloads the current page
  def refresh_page
    logger.debug 'Refreshing the page'
    @driver.navigate.refresh
  end

  # Hovers over an element
  # @param [Hash] locator
  def mouseover(locator)
    @driver.action.move_to(element locator).perform
    sleep Config.click_wait
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

  # ELEMENTS

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

  # Returns true if a given element can be found
  # @param [Hash] locator
  # @return [boolean]
  def exists?(locator)
    @driver.find_element(locator).size
    true
  rescue
    false
  end

  # Returns true if a given element is enabled
  # @param [Hash] locator
  # @return [boolean]
  def enabled?(locator)
    @driver.find_element(locator).enabled?
  end

  # Returns true if a given element is visible
  # @param [Hash] locator
  # @return [boolean]
  def visible?(locator)
    @driver.find_element(locator).displayed?
  end

  # Returns the text of an element if it exists
  # @param [Hash] locator
  # @return [String]
  def element_text(locator)
    element(locator).text if exists?(locator)
  end

  # Returns the value attribute of an element if it exists
  # @param [Hash] locator
  # @return [String]
  def element_value(locator)
    element(locator).attribute('value') if exists?(locator)
  end

  # DOM UPDATES

  # Waits a given number of seconds for a block to complete. Logs an optional message if block fails.
  # @param [Integer] timeout
  # @param [String] msg
  def wait_until(timeout, msg=nil, &blk)
    wait = Selenium::WebDriver::Wait.new :timeout => timeout, :message => msg
    wait.until &blk
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
    when_exists(locator, timeout)
    wait_until(timeout) { element(locator).displayed? }
  end

  # Waits a given number of seconds for a visible element to become invisible
  # @param [Hash] locator
  # @param [Integer] timeout
  def when_not_displayed(locator, timeout)
    wait_until(timeout) { !element(locator).displayed? }
  end

  # Waits a given number of seconds for an existing element to be enabled
  # @param [Hash] locator
  # @param [Integer] timeout
  def when_enabled(locator, timeout)
    wait_until(timeout) { element(locator).enabled? }
    log_js_errors @driver
  end

  # Waits a given number of seconds for an existing element to be disabled
  # @param [Hash] locator
  # @param [Integer] timeout
  def when_not_enabled(locator, timeout)
    wait_until(timeout) { !element(locator).enabled? }
  end

  # ELEMENT INTERACTIONS

  # Waits a configurable time and then clicks an element with a given locator
  # @param [Hash] locator
  def click_element(locator)
    sleep Config.click_wait
    when_enabled(locator, Config.short_wait)
    element(locator).click
  end

  def click_element_js(locator)
    sleep Config.click_wait
    @driver.execute_script('arguments[0].click();', element(locator))
  end

  # Waits a short time for an element to be present and clicks it. Intended for Ajax updates.
  # @param [Hash] locator
  # @param [Integer] timeout
  def wait_for_element_and_click(locator, timeout = nil)
    when_exists(locator, (timeout || Config.short_wait))
    click_element locator
  end

  # Waits a moderate time for an element to be present and clicks it. Intended for page loads.
  # @param [Hash] locator
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
      hit_tab
      wait_until(1, 'Element value not updated, retrying') { element(input_locator).attribute('value') == string.to_s }
    rescue
      tries.zero? ? fail : retry
    end
  end

  def wait_for_element_and_select(select_locator, option_locator)
    wait_for_page_and_click select_locator
    wait_for_element_and_click option_locator
  end

  # Clicks an input, waits for options to appear, and selects a given option
  # @param [Hash] input_locator
  # @param [Hash] options_locator
  # @param [String] option
  def wait_for_options_and_select(input_locator, options_locator, option)
    wait_for_element_and_click input_locator
    wait_until(Config.short_wait) { elements(options_locator).any? &:displayed? }
    sleep 0.5
    (option && !option.empty?) ?
        (elements(options_locator).find { |el| el.text == option }).click :
        (elements(options_locator).find { |el| el.text.gsub(/[[:space:]]+/, '').empty? }).click
  end

  # Enters or removes data in an auto-complete field. If entering data, can select an existing option or create a new
  # record. If creating a new record, the text of the option is included as create_type.
  # @param [Hash] input_locator
  # @param [Hash] options_locator
  # @param [String] desired_option
  # @param [String] create_type
  def enter_auto_complete(input_locator, options_locator, desired_option, create_type=nil)
    # Force the current browser window into focus
    @driver.switch_to.window @driver.window_handle

    # User enters a value in the input
    if desired_option && !desired_option.empty?
      wait_for_element_and_type(input_locator, desired_option)
      wait_until(Config.short_wait) { elements(options_locator).any? &:displayed? }

      # User wants to create a new record
      if create_type
        sleep 1
        wait_until(Config.short_wait) { (elements(options_locator).select { |el| el.text == create_type }).any? }
        (elements(options_locator).find { |el| el.text == create_type }).click
        sleep Config.click_wait

      # User wants to select existing record
      else
        wait_until(Config.short_wait) { (elements(options_locator).select { |el| el.text == desired_option }).any? }
        (elements(options_locator).find { |el| el.text == desired_option }).click
      end

    # User wants to delete existing value. Removing the value is tricky, so checks that the field is actually emptied.
    # If not, retries once.
    else
      tries ||= 2
      begin
        tries -= 1
        wait_for_element_and_click input_locator
        value = element(input_locator).attribute('value')
        if value
          value.length.times do
            hit_backspace
            hit_delete
          end
          sleep 1
        end
        hit_tab
        sleep 0.5
        wait_until(1) { element(input_locator).attribute('value').empty? }
      rescue
        if tries.zero?
          fail
        else
          logger.warn 'Unable to remove data from an auto-complete, retrying'
          retry
        end
      end
    end
  end

  # KEYSTROKES

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

  # Hits the Delete key
  def hit_delete
    @driver.action.send_keys(:delete).perform
  end

  # Hits the Backspace key
  def hit_backspace
    @driver.action.send_keys(:backspace).perform
  end

  # Hits the Down Arrow key
  def hit_down_arrow
    @driver.action.send_keys(:arrow_down).perform
  end

  # Hits the Shift and Tab keys together
  def hit_shift_tab
    @driver.action.key_down(:shift).send_keys(:tab).key_up(:shift).perform
    sleep Config.click_wait
  end

  # Hits the Escape key
  def hit_escape
    @driver.action.send_keys(:escape).perform
    sleep Config.click_wait
  end

  # JAVASCRIPT INJECTION

  # Executes the given JavaScript snippet
  # @param [String] script
  def execute_script(script)
    @driver.execute_script script
  end

  # Uses JavaScript to scroll to the top of the page
  def scroll_to_top
    @driver.execute_script('window.scrollTo(0, 0);')
  end

  # Uses JavaScript to scroll to the bottom of the page
  def scroll_to_bottom
    @driver.execute_script('window.scrollTo(0, document.body.scrollHeight);')
  end

  # Uses JavaScript to scroll to a given element, retrying once
  # @param [Selenium::WebDriver::Element] element
  def scroll_to_element(element)
    tries ||= 2
    begin
      @driver.execute_script('arguments[0].scrollIntoView(true);', element)
    rescue Selenium::WebDriver::Error::JavascriptError
      retry unless (tries -= 1).zero?
    end
  end

  # HELPER METHODS FOR TESTS

  # Checks equivalence of two parameters. Will fail if they do not match or if they are not instances of String or Nil.
  # @param [Object] expected
  # @param [Object] actual
  # @param [Array<Object>] errors
  # @return [boolean]
  def text_values_match?(expected, actual, errors=nil)
    logger.debug "Checking for '#{expected}'"
    wait_until(0.5, "Expected '#{expected.to_s}', got '#{actual.to_s}'") { expected.to_s == actual.to_s }
    true
  rescue
    errors << "Expected '#{expected}', got '#{actual}'" if errors
    false
  end

  # Saves a screenshot to a given path
  # @param [String] file_path
  def save_screenshot(file_path)
    @driver.save_screenshot file_path
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

  # Waits for an actual value to match an expected value. Logs the mismatch if a failure occurs.
  # @param [Object] expected
  # @param [Object] actual
  def verify_values_match(expected, actual)
    logger.debug "Checking for '#{expected}'"
    wait_until(1, "Expected #{expected}, got #{actual}") { actual == expected.to_s }
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
    hit_escape
  end

  def switch_to_new_window
    @driver.switch_to.window @driver.window_handles.last
  end

  def new_window_opens?(expected_string)
    begin
      sleep 0.5
      windows = @driver.window_handles
      if windows.length > 1
        @driver.switch_to.window windows.last
        wait_until(Config.short_wait) { page_title.include?(expected_string) || url.include?(expected_string) }
        true
      else
        false
      end
    rescue => e
      logger.error "#{e.message}\n#{e.backtrace}"
      false
    ensure
      @driver.close if windows.length > 1
      @driver.switch_to.window windows.first
    end
  end
end
