class SearchPage

  include Page
  include CollectionSpacePages
  include CoreSearchAcquisitionsForm
  include CoreSearchConditionCheckForm
  include CoreSearchConservationForm
  include CoreSearchObjectsForm
  include CoreSearchOrganizationsForm
  include CoreSearchPersonsForm
  include PAHMASearchObjectsForm

  def search_button_one; {:xpath => '(//button[@name="search"])[1]'} end
  def search_button_two; {:xpath => '(//button[@name="search"])[2]'} end
  def clear_button; {:name => 'clear'} end
  def add_field_button; {:xpath => '//span[contains(.,"+ Field")]'} end
  def add_group_button; {:xpath => '//span[contains(.,"+ Group")]'} end
  def modal_clear_button; {:xpath => '//footer//button[@name="clear"]'} end


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

  def click_modal_clear_button
    wait_for_element_and_click modal_clear_button
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
    usernames.each_with_index do |username, index|
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
  def perform_adv_search_for_all(data_set)
    click_clear_button
    select_adv_search_all_option
    enter_object_id_search_data data_set
    click_search_button
  end

  # ADDING SEARCH OPTIONS

  def single_field_input_locator(rep); {:xpath => '(//div[contains(@class,"FieldConditionInput")]//input[@data-name="field"])[' + rep.to_s + ']'} end
  def single_field_options_locator(rep); {:xpath => '(//div[contains(@class,"FieldConditionInput")]//input[@data-name="field"])[' + rep.to_s + ']/following-sibling::div//li'} end
  def field_is_input_locator(rep); {:xpath => '(//div[contains(@class,"FieldConditionInput")]//input[@data-name="searchOp"])[' + rep.to_s + ']'} end
  def field_is_options_locator(rep); {:xpath => '(//div[contains(@class,"FieldConditionInput")]//input[@data-name="searchOp"])[' + rep.to_s + ']/following-sibling::div//li'} end
  # grab FieldCondition div, then div with span, then next sibling, then input for searchOp
  # add a single field
  def add_single_field(field, searchOp)
    wait_for_element_and_click add_field_button
    logger.debug "adding a #{field} field"
    wait_for_options_and_select(single_field_input_locator(1), single_field_options_locator(1), field)
    # wait_for_options_and_select(field_is_input_locator(1), field_is_options_locator(1), searchOp)
  end

  def single_group_input_locator(rep); {:xpath => '(//div[contains(@class,"GroupConditionInput")]//input[@data-name="group"])[' + rep.to_s + ']'} end
  def single_group_options_locator(rep); {:xpath => '(//div[contains(@class,"GroupConditionInput")]//input[@data-name="group"])[' + rep.to_s + ']/following-sibling::div//li'} end
  def group_boolean_input_locator(rep); {:xpath => '(//div[contains(@class,"GroupConditionInput")]//input[@data-name="booleanSearchOp"])[' + rep.to_s + ']'} end
  def group_boolean_options_locator(rep); {:xpath => '(//div[contains(@class,"GroupConditionInput")]//input[@data-name="booleanSearchOp"])[' + rep.to_s + ']/following-sibling::div//li'} end
  def group_field_input_locator(rep); {:xpath => '(//div[contains(@class,"GroupConditionInput")]//input[@data-name="field"])[' + rep.to_s + ']'} end
  def group_field_options_locator(rep); {:xpath => '(//div[contains(@class,"GroupConditionInput")]//input[@data-name="field"])[' + rep.to_s + ']/following-sibling::div//li'} end
  def group_is_input_locator(rep); {:xpath => '(//div[contains(@class,"GroupConditionInput")]//input[@data-name="searchOp"])[' + rep.to_s + ']'} end
  def group_is_options_locator(rep); {:xpath => '(//div[contains(@class,"GroupConditionInput")]//input[@data-name="searchOp"])[' + rep.to_s + ']/following-sibling::div//li'} end


  # add a single group
  def add_single_group(group, booleanOp, field, searchOp)
    wait_for_element_and_click add_group_button
    logger.debug "adding a #{group} group"
    wait_for_options_and_select(single_group_input_locator(1), single_group_options_locator(1), group)
    wait_for_options_and_select(group_boolean_input_locator(1), group_boolean_options_locator(1), booleanOp)
    wait_for_options_and_select(group_field_input_locator(1), group_field_options_locator(1), field)
    wait_for_options_and_select(group_is_input_locator(1), group_is_options_locator(1), searchOp)
  end

  def add_field_to_group_button; {:xpath => '//div[contains(@class,"GroupConditionInput")]//span[contains(.,"+ Field")]'} end

  def add_field_to_group(field, is, rep)
    wait_for_element_and_click add_field_to_group_button
    logger.debug "adding a #{field} to group"
    wait_for_options_and_select(group_field_input_locator(rep), group_field_options_locator(rep), field)
    # wait_for_options_and_select(group_is_input_locator(rep), group_is_options_locator(rep), bol)
  end

  def group_select_input_locator(index, rep); {:xpath => '(//div[contains(@class,"GroupConditionInput")]//fieldset[contains(@class,"RepeatingInput")]//input[@data-name="' + index.to_s + '"])[' + rep.to_s + ']'} end
  def group_select_options_locator(index, rep); {:xpath => '(//div[contains(@class,"GroupConditionInput")]//fieldset[contains(@class,"RepeatingInput")]//input[@data-name="' + index.to_s + '"])[' + rep.to_s + ']/following-sibling::div//li'} end

  def select_from_single_group(data, rep)
    logger.debug "Selecting #{data}"
    wait_for_options_and_select(group_select_input_locator(0, rep), group_select_options_locator(0, rep), data)
  end

  def group_date_input_locator(name, rep); {:xpath => '(//div[contains(@class,"GroupConditionInput")]//div[contains(@class,"DateInput")]//input[@data-name="' + name + '"])[' + rep.to_s + ']'} end

  def date_from_single_group(data, name, rep)
    input = element group_date_input_locator(name, rep)
    input.clear
    sleep Config.click_wait
    input.send_keys data
    hit_enter
    hit_tab
  end
end
