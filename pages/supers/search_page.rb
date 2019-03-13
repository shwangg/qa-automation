require_relative '../../spec_helper'

class SearchPage

  include Logging
  include Page
  include CollectionSpacePages

  def search_button; {:name => 'search'} end
  def clear_button; {:name => 'clear'} end

  def record_type_input; {:xpath => '//label[text()="Find"]/following-sibling::div/input'} end
  def keywords_input; {:xpath => '//label[text()="Keywords"]/following-sibling::input'} end

  def adv_search_boolean_input; input_locator([], 'booleanSearchOp') end
  def adv_search_boolean_options; input_options_locator([], 'booleanSearchOp') end

  # Selects the advanced search 'All' option for applying conditionals
  def select_adv_search_all_option
    wait_for_options_and_select(adv_search_boolean_input, adv_search_boolean_options, 'All')
  end

  # Selects the advanced search 'Any' option for applying conditionals
  def select_adv_search_any_option
    wait_for_options_and_select(adv_search_boolean_input, adv_search_boolean_options, 'Any')
  end

  # Clicks the 'Search' button
  def click_search_button
    wait_for_element_and_click search_button
  end

  # Clicks the 'Clear' button
  def click_clear_button
    wait_for_element_and_click clear_button
  end

  # Enters a keyword search term and clicks search
  # @param [String] string
  def full_text_search(string)
    logger.info "Searching for '#{string}'"
    wait_for_element_and_type(keywords_input, string)
    click_search_button
  end

end
