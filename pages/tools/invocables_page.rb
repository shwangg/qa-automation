class InvocablesPage < ToolsPage

  include Page
  include Logging
  include CollectionSpacePages

  # Select invocable
  def invocable_description_locator; text_area_locator([], CoreInvocablesData::INVOCABLE_DESC.name) end
  def invocable_name_locator; input_locator([], CoreInvocablesData::INVOCABLE_NAME.name) end
  def invocable_report_filename_locator; input_locator([], CoreInvocablesData::INVOCABLE_REPORT_FILENAME.name) end
  def invocable_no_ctx_locator; input_locator([], CoreInvocablesData::INVOCABLE_NO_CONTEXT.name) end
  def invocable_single_ctx_locator; input_locator([], CoreInvocablesData::INVOCABLE_SINGLE_CONTEXT.name) end
  def invocable_group_ctx_locator; input_locator([], CoreInvocablesData::INVOCABLE_GROUP_CONTEXT.name) end
  def invocable_list_ctx_locator; input_locator([], CoreInvocablesData::INVOCABLE_LIST_CONTEXT.name) end
  def invocable_batch_doctypes_locator; input_locator_by_label(CoreInvocablesData::INVOCABLE_DOC_TYPES_GROUP.label) end
  def invocable_batch_doctype_locator(type); {xpath: "//input[@value='#{type}']"} end
  def invocable_report_doctypes_locator; input_locator_by_label(CoreInvocablesData::INVOCABLE_DOC_TYPES_GROUP.label) end
  def invocable_mimetype_locator; input_locator_by_label(CoreInvocablesData::INVOCABLE_REPORT_OUTPUT_MIME.label) end
  def invocable_classname_locator;  {:xpath => '//label[contains(., "Java class")]//following-sibling::textarea'} end
  def invocable_batch_new_focus_locator; input_locator([], CoreInvocablesData::INVOCABLE_BATCH_CREATES_NEW_FOCUS.name) end

  def invocable_modal; {:xpath => '//div[@class="cspace-ui-InvocationModal--common"]'} end
  def run_on_input; input_locator_by_label('Run on') end
  def invocable_option; input_options_locator_by_label('Run on') end
  def select_run_on_record_button; {xpath: '//button[text()="Select…"]'} end

  def select_invocable(invocable_name)
    {:xpath => "//div[@class=\"cspace-ui-SearchResultTable--common\"]//*[@aria-label=\"row\"][contains(.,\"#{invocable_name}\")]"}
  end

  # Clicks a search results row containing a given string
  # @param [String] unique_identifier
  def click_invocable(unique_identifier)
    wait_for_page_and_click select_invocable(unique_identifier)
  end

  # Edit the name of the invocable
  def edit_invocable_name_and_save(new_name)
    logger.debug("Changing name to '#{new_name}'")
    wait_for_element_and_type(invocable_name_locator, new_name) if new_name
    click_save_button
  end

  # Edit the description
  def edit_description_and_save(description)
    logger.debug("Changing the description to '#{description}'")
    wait_for_element_and_type(invocable_description_locator, description) if description
    click_save_button
  end

  def choose_run_on_option(option)
    wait_for_options_and_select(run_on_input, invocable_option, option)
  end

  def click_select_record_button
    wait_for_element_and_click select_run_on_record_button
  end

  def enter_target_record(option)
    enter_auto_complete(input_locator_by_label('Target record'), input_options_locator_by_label('Target record'), option)
  end

end
