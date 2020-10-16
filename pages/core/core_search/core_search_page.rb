require_relative '../../../spec_helper'

class CoreSearchPage

  include Page
  include CollectionSpacePages
  include CoreSearchAcquisitionsForm
  include CoreSearchConditionCheckForm
  include CoreSearchObjectsForm

  DEPLOYMENT = Deployment::CORE

  def search_button_one; {:xpath => '(//button[@name="search"])[1]'} end
  def search_button_two; {:xpath => '(//button[@name="search"])[2]'} end
  def clear_button; {:name => 'clear'} end

  def record_type_input; {:xpath => '//label[text()="Find"]/following-sibling::div/input'} end
  def record_type_options; {:xpath => '//label[text()="Find"]/following-sibling::div//li'} end

  def adv_search_boolean_input; input_locator([], 'booleanSearchOp') end
  def adv_search_boolean_options; input_options_locator([], 'booleanSearchOp') end

  def select_record_type_option(option)
    logger.info "Selecting record type '#{option}'"
    wait_for_options_and_select(record_type_input, record_type_options, option)
  end

  # Selects the advanced search 'All' option for applying conditionals
  def select_adv_search_all_option
    wait_for_options_and_select(adv_search_boolean_input, adv_search_boolean_options, 'All')
  end

  # Selects the advanced search 'Any' option for applying conditionals
  def select_adv_search_any_option
    wait_for_options_and_select(adv_search_boolean_input, adv_search_boolean_options, 'Any')
  end

  # Clicks the second 'Search' button. If the button is not clickable because an element is obscuring it, tries to click
  # the first button instead.
  def click_search_button
    tries = 2
    begin
      tries -= 1
      wait_for_element_and_click search_button_two
    rescue Selenium::WebDriver::Error::WebDriverError
      tries.zero? ? fail : (wait_for_element_and_click search_button_one)
    end
  end

  # Clicks the 'Clear' button
  def click_clear_button
    wait_for_element_and_click clear_button
  end

  # KEYWORD

  def keywords_input_locator; {:xpath => '//label[text()="Keywords"]/following-sibling::input'} end

  # Enters a keyword string
  # @param [String] string
  def enter_keyword(string)
    logger.info "Searching for keyword '#{string}'"
    wait_for_element_and_type(keywords_input_locator, string)
  end

  # Enters a keyword search term and clicks search
  # @param [String] string
  def full_text_search(string)
    enter_keyword string
    hit_enter
  end

  # LAST UPDATED BY

  def last_updated_by_input_locator(index); input_locator([fieldset(CollectionSpaceData::UPDATED_BY.name, index)]) end

  # Enters a set of usernames in last-updated-by fields
  # @param [Array<String>] usernames
  def enter_last_updated_by(usernames)
    usernames.each do |username|
      index = usernames.index username
      logger.info "Entering last updated by '#{username}' at index #{index}"
      add_button_locator = add_button_locator([fieldset(CollectionSpaceData::UPDATED_BY.name)])
      wait_for_element_and_click add_button_locator unless index.zero?
      wait_for_element_and_type(last_updated_by_input_locator(index), username)
      hit_tab
    end
  end

  # LAST UPDATED TIME

  def last_updated_time_input_locator; input_locator([], CollectionSpaceData::UPDATED_AT.name) end

  # Enters a pair of dates in the last-updated-time fields
  # @param [String] after_date_str
  # @param [String] before_date_str
  def enter_last_updated_times(after_date_str, before_date_str)
    logger.info "Entering last updated on-or-after '#{after_date_str}' and on-or-before '#{before_date_str}'"
    if after_date_str
      elements(last_updated_time_input_locator)[0].clear
      sleep Config.click_wait
      elements(last_updated_time_input_locator)[0].send_keys after_date_str
      hit_enter
      hit_tab
    end
    if before_date_str
      elements(last_updated_time_input_locator)[1].clear
      sleep Config.click_wait
      elements(last_updated_time_input_locator)[1].send_keys before_date_str
      hit_enter
      hit_tab
    end
  end

  # Enters object search criteria and hits search. Returns an array of any errors caused by form fields.
  # @param [Hash] data_set
  # @return [Array<Object>]
  def perform_adv_search_for_all(data_set)
    click_clear_button
    select_adv_search_all_option
    search_input_errors = enter_object_id_search_data data_set
    click_search_button
    search_input_errors
  end

end
