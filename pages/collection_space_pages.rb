require_relative '../spec_helper'

module CollectionSpacePages

  include Page
  include Logging

  # ELEMENT LOCATORS

  def quick_search_type_select; {:xpath => '//div[contains(@class,"QuickSearchInput")]//div[contains(@class,"DropdownMenuInput")]/input'} end
  def quick_search_type_options; {:xpath => '//div[contains(@class,"QuickSearchInput")]//li'} end
  def quick_search_input; {:xpath => '//div[contains(@class,"QuickSearchInput")]//input[@placeholder="Search"]'} end
  def quick_search_button; {:xpath => '//div[contains(@class,"QuickSearchInput")]//button'} end
  def my_collection_space_link; {:xpath => '//a[contains(.,"My CollectionSpace")]'} end
  def create_new_link; {:xpath => '//a[contains(.,"Create New")]'} end
  def search_link; {:xpath => '//a[contains(.,"Search")]'} end
  def admin_link; {:xpath => '//a[contains(.,"Administration")]'} end
  def sign_out_link; {:xpath => '//a[contains(.,"Sign out")]'} end
  def save_button; {:name => 'save'} end
  def delete_button; {:name => 'delete'} end
  def header_bar; {:xpath => '//header/div'} end
  def page_heading; {:xpath => '//h1'} end

  def notifications_bar; {:xpath => '//div[@class="cspace-ui-NotificationBar--common"]'} end
  def notifications_close_button; {:name => 'close'} end

  def confirm_delete_msg_span; {:xpath => '//div[contains(@class,"ConfirmRecordDeleteModal")]//div/span'} end
  def confirm_delete_cancel_button; {:xpath => '//div[contains(@class,"ConfirmRecordDeleteModal")]//button[@name="cancel"]'} end

  # Returns a hash containing both the data name used to locate a set of data fields on the page and also the index of the data (i.e., which row)
  # @param [String] data_name
  # @param [Integer] index
  # @return [Hash]
  def fieldset(data_name, index=nil)
    {:data_name => data_name, :index => index}
  end

  # Returns the XPath to a given set of fields in the UI, with nesting determined by the given fieldsets if any
  # @param [Array<Hash>] fieldsets
  # @return [String]
  def fieldset_xpath(fieldsets=nil)
    xpath = ''
    if fieldsets
      # For each fieldset, append to the XPath string
      fieldsets.each do |pair|
        xpath << "//fieldset[@data-name=\"#{pair[:data_name]}\"]" if pair[:data_name]
        xpath << "//div[@data-instancename=\"#{pair[:index]}\"]" if pair[:index]
      end
    end
    xpath
  end

  # Returns a hash containing the XPath to an input element, with a data-name attribute if given
  # @param [Array<Hash>] fieldsets
  # @param [String] input_data_name
  # @return [Hash]
  def input_locator(fieldsets, input_data_name=nil)
    {:xpath => "#{fieldset_xpath fieldsets}//input#{'[@data-name="' + input_data_name + '"]' if input_data_name}"}
  end

  def input_locator_by_label(label)
    {:xpath => "//label[contains(., \"#{label}\")]/following-sibling::div//input"}
  end

  # Returns a hash containing the XPath to a text_area element, with a data-name attribute if given
  # @param [Hash] fieldset
  # @param [String] text_data_name
  # @return [Hash]
  def text_area_locator(fieldset, text_data_name=nil)
    {:xpath => "#{fieldset_xpath fieldset}//textarea#{'[@data-name="' + text_data_name + '"]' if text_data_name}"}
  end

  # Returns a hash containing the XPath to a set of options for an input, with a data-name attribute if given
  # @param [Hash] fieldset
  # @param [String] options_data_name
  # @return [Hash]
  def input_options_locator(fieldset, options_data_name=nil)
    {:xpath => "#{fieldset_xpath fieldset}//input#{'[@data-name="' + options_data_name + '"]' if options_data_name}/following-sibling::div//li"}
  end

  def input_options_locator_by_label(label)
    {:xpath => "//label[contains(., \"#{label}\")]/following-sibling::div//li"}
  end

  # Returns a has containing the XPath to a structured date input
  # @param [Hash] fieldset
  # @return [Hash]
  def structured_date_input_locator(fieldset)
    {:xpath => "#{fieldset_xpath fieldset}//div[contains(@class, 'StructuredDateInput')]/input"}
  end

  # Returns a hash containing the XPath to a 'move top' button for a row
  # @param [Hash] fieldset
  # @return [Hash]
  def move_top_button_locator(fieldset)
    {:xpath => "(#{fieldset_xpath fieldset}//button)[1]"}
  end

  # Returns a hash containing the XPath to a 'delete' button for a row
  # @param [Hash] fieldset
  # @return [Hash]
  def delete_button_locator(fieldset)
    {:xpath => "(#{fieldset_xpath fieldset}//button)[2]"}
  end

  # Returns a hash containing the XPath to an 'add' button for adding a row to a fieldset
  # @param [Hash] fieldset
  # @return [Hash]
  def add_button_locator(fieldset)
    {:xpath => "(#{fieldset_xpath fieldset}//button[@data-name=\"add\"])[last()]"}
  end

  # PAGE INTERACTIONS

  # Waits for a given page title to load
  # @param [String] title_prefix
  def wait_for_title(title_prefix)
    wait_until(Config.medium_wait) { title == "#{title_prefix} | CollectionSpace" }
  end

  # Performs a search in the header bar, selecting a type and entering a search string
  # @param [String] type_string
  # @param [String] term_string
  def quick_search(type_string, term_string)
    logger.info "Performing quick search for '#{term_string}' in '#{type_string}'"
    wait_for_options_and_select(quick_search_type_select, quick_search_type_options, type_string)
    wait_for_element_and_type(quick_search_input, term_string)
    wait_for_element_and_click quick_search_button
  end

  # Clicks the 'Create New' link in the navigation menu
  def click_create_new_link
    logger.info 'Clicking link to Create New'
    wait_for_element_and_click create_new_link
  end

  # Clicks the 'Search' link in the navigation menu
  def click_search_link
    logger.info 'Clicking link to Search'
    wait_for_element_and_click search_link
  end

  # Clicks the save button
  def click_save_button
    wait_for_element_and_click save_button
  end

  # Clicks save and waits for confirmation the record has been saved
  def save_record
    click_save_button
    wait_for_notification 'Saved'
  end

  # Clicks the delete button
  def click_delete_button
    wait_for_element_and_click delete_button
  end

  # Clicks delete, confirms the deletion, and waits for confirmation the record has been deleted
  def delete_record
    click_delete_button
    wait_for_element_and_click confirm_delete_msg_span
    wait_for_notification 'Deleted'
  end

  # Returns the delete confirmation message text
  # @return [String]
  def confirm_delete_msg
    when_exists(confirm_delete_msg_span, Config.short_wait)
    element_text confirm_delete_msg_span
  end

  # Clicks the cancel button on a delete confirmation pop-up
  def cancel_deletion
    wait_for_element_and_click confirm_delete_cancel_button
  end

  # Logs out using the sign out link in the header
  def log_out
    logger.info 'Logging out'
    wait_for_element_and_click sign_out_link
    wait_until(Config.short_wait) { url.include? '/login' }
  end

  # Waits for the notifications bar to contain a given string
  # @param [String] string
  def wait_for_notification(string)
    when_displayed(notifications_bar, Config.short_wait)
    wait_until(Config.short_wait) { element_text(notifications_bar).include? string }
  end

  # Closes the notifications bar if it is present
  def close_notifications_bar
    click_element notifications_close_button if exists?(notifications_close_button)
  end

  # Hides the notifications bar to ensure it does not obscure elements on the page
  def hide_notifications_bar
    when_exists(notifications_bar, Config.short_wait)
    @driver.execute_script("arguments[0].style.visibility='hidden';", element(notifications_bar))
  end

  # Hides the header bar to ensure it does not obscure elements on the page
  def hide_header_bar
    when_exists(header_bar, Config.short_wait)
    @driver.execute_script("arguments[0].style.visibility='hidden';", element(header_bar))
  end

  # STRUCTURED DATES

  def date_period; input_locator([], ObjectData::DATE_PERIOD.name) end
  def date_assoc; input_locator([], ObjectData::DATE_ASSOC.name) end
  def date_note; input_locator([], ObjectData::DATE_NOTE.name) end
  def date_earliest_year; input_locator([], ObjectData::DATE_EARLIEST_YEAR.name) end
  def date_earliest_month; input_locator([], ObjectData::DATE_EARLIEST_MONTH.name) end
  def date_earliest_day; input_locator([], ObjectData::DATE_EARLIEST_DAY.name) end
  def date_earliest_era; input_locator([], ObjectData::DATE_EARLIEST_ERA.name) end
  def date_earliest_certainty; input_locator([], ObjectData::DATE_EARLIEST_CERTAINTY.name) end
  def date_earliest_qualif; input_locator([], ObjectData::DATE_EARLIEST_QUALIF.name) end
  def date_earliest_qualif_value; input_locator([], ObjectData::DATE_EARLIEST_QUALIF_VALUE.name) end
  def date_earliest_qualif_unit; input_locator([], ObjectData::DATE_EARLIEST_QUALIF_UNIT.name) end
  def date_latest_year; input_locator([], ObjectData::DATE_LATEST_YEAR.name) end
  def date_latest_month; input_locator([], ObjectData::DATE_LATEST_MONTH.name) end
  def date_latest_day; input_locator([], ObjectData::DATE_LATEST_DAY.name) end
  def date_latest_era; input_locator([], ObjectData::DATE_LATEST_ERA.name) end
  def date_latest_certainty; input_locator([], ObjectData::DATE_LATEST_CERTAINTY.name) end
  def date_latest_qualif; input_locator([], ObjectData::DATE_LATEST_QUALIF.name) end
  def date_latest_qualif_value; input_locator([], ObjectData::DATE_LATEST_QUALIF_VALUE.name) end
  def date_latest_qualif_unit; input_locator([], ObjectData::DATE_LATEST_QUALIF_UNIT.name) end

  # TERM POP-UPS

  def term_popup_link(term_string); {:xpath => "//div[@class='cspace-ui-MiniViewPopup--common']//a[text()=\"#{term_string}\"]"} end

  # Clicks the term link in a term pop-up
  # @param [String] term_string
  def click_term_popup_link(term_string)
    wait_for_element_and_click term_popup_link(term_string)
  end

end
