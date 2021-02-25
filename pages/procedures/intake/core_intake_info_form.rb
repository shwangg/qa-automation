module CoreIntakeInfoForm

  include Logging
  include Page
  include CollectionSpacePages

  def ref_num_input_locator; input_locator([], CoreIntakeData::ENTRY_NUMBER.name) end

  # Enters entry number
  # @param [Hash] data_set
  def enter_entry_num(data_set)
    title = data_set[CoreIntakeData::ENTRY_NUMBER.name]
    logger.debug "Entering reference number '#{title}'"
    ref_num_options_locator = input_options_locator([], CoreIntakeData::ENTRY_NUMBER.name)
    wait_for_options_and_type(ref_num_input_locator, ref_num_options_locator, title)
  end

  def entry_note_input_locator; text_area_locator([], CoreIntakeData::ENTRY_NOTE.name) end

  # Enters entry note
  # @param [Hash] data_set
  def enter_entry_note(data_set)
    entry_note = data_set[CoreIntakeData::ENTRY_NOTE.name]
    logger.debug "Entering entry note '#{entry_note}'"
    wait_for_element_and_type(entry_note_input_locator, entry_note) if entry_note
  end

  def intake_template_input; {:xpath => '//div[contains(@class,"RecordHeader")]//div[contains(@class,"DropdownMenuInput")]/input'} end
  def intake_template_options; {:xpath => '//div[contains(@class,"RecordHeader")]//li'} end

  def select_intake_template(template)
    logger.info "Selecting template '#{template}'"
    wait_for_options_and_select(intake_template_input, intake_template_options, template)
  end
end
