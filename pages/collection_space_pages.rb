require_relative '../spec_helper'

module CollectionSpacePages

  include Page
  include Logging

  # ELEMENT LOCATORS

  def my_collection_space_link; {:xpath => '//a[contains(.,"My CollectionSpace")]'} end
  def create_new_link; {:xpath => '//a[contains(.,"Create New")]'} end
  def search_link; {:xpath => '//a[contains(.,"Search")]'} end
  def admin_link; {:xpath => '//a[contains(.,"Administration")]'} end
  def sign_out_link; {:xpath => '//a[contains(.,"Sign out")]'} end
  def save_button; {:name => 'save'} end
  def delete_button; {:name => 'delete'} end
  def header_bar; {:xpath => '//header/div'} end
  def notifications_bar; {:xpath => '//div[@class="cspace-ui-NotificationBar--common"]'} end

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
  # @param [Hash] fieldset
  # @param [String] input_data_name
  # @return [Hash]
  def input_locator(fieldset, input_data_name=nil)
    {:xpath => "#{fieldset_xpath fieldset}//input#{'[@data-name="' + input_data_name + '"]' if input_data_name}"}
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

  # Logs out using the sign out link in the header
  def log_out
    logger.info 'Logging out'
    wait_for_element_and_click sign_out_link
    wait_until(Config.short_wait) { url.include? '/login' }
  end

  # Hides the notifications bar to ensure it does not obscure elements on the page
  def hide_notifications_bar
    when_exists(notifications_bar, Config.short_wait)
    @driver.execute_script("arguments[0].style.visibility='hidden';", element(notifications_bar))
  end

  def hide_header_bar
    when_exists(header_bar, Config.short_wait)
    @driver.execute_script("arguments[0].style.visibility='hidden';", element(header_bar))
  end

end
