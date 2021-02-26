module CoreGroupInfoForm

  include Logging
  include Page
  include CollectionSpacePages

  def title_input; input_locator([], CoreGroupData::TITLE.name) end
  def enter_title(data)
    logger.debug "Entering title #{data[CoreGroupData::TITLE.name]}"
    wait_for_element_and_type(title_input, data[CoreGroupData::TITLE.name])
  end

  def scope_note_input_locator; text_area_locator([], CoreGroupData::SCOPE_NOTE.name) end

  # Enters scope note
  # @param [Hash] data_set
  def enter_scope_note(data_set)
    scope_note = data_set[CoreGroupData::SCOPE_NOTE.name]
    logger.debug "Entering group note '#{scope_note}'"
    wait_for_element_and_type(scope_note_input_locator, scope_note) if scope_note
  end

  def group_related_input; {:xpath => '//nav[contains(@class,"RecordBrowserNavBar")]//div[contains(@class,"DropdownMenuInput")]/input'} end
  def group_related_options; {:xpath => '//nav[contains(@class,"RecordBrowserNavBar")]//li'} end

  def select_group_related(related)
    logger.info "Selecting related '#{related}'"
    wait_for_options_and_select(group_related_input, group_related_options, related)
  end

  def first_row_input; input_locator([], "0") end
  def second_row_input; input_locator([], "1") end

  def select_and_unrelate_two_objects
    wait_for_element_and_click first_row_input
    wait_for_element_and_click second_row_input
    wait_for_element_and_click unrelate_button
    hit_tab
    hit_enter
    sleep 1
  end

end
