module CoreValuationControlInfoForm

  include Logging
  include Page
  include CollectionSpacePages

  # REFERENCE NUM BER

  def ref_num_input_locator; input_locator([], CoreValuationControlData::VALUE_NUM.name) end
  def ref_num_input_options_locator; input_options_locator([], CoreValuationControlData::VALUE_NUM.name) end

  # Enters an valuation control reference number
  # @param [Hash] data_set
  def enter_valuation_control_ref_num(data_set)
    vc_ref_num = data_set[CoreValuationControlData::VALUE_NUM.name]
    logger.debug "Entering reference number '#{vc_ref_num}'"
    wait_for_options_and_type(ref_num_input_locator, ref_num_input_options_locator, vc_ref_num)
  end

  # AMOUNT

  def amount_input_loc(index); input_locator([fieldset(CoreValuationControlData::VALUE_AMTS_LIST.name, index)], CoreValuationControlData::VALUE_AMT.name) end

  # NOTE

  def value_note_input_locator; text_area_locator([], CoreValuationControlData::VALUE_NOTE.name) end

  # Enters value_ note
  # @param [Hash] data_set
  def enter_value_note(data_set)
    value_note = data_set[CoreValuationControlData::VALUE_NOTE.name]
    logger.debug "Entering value_note '#{value_note}'"
    wait_for_element_and_type(value_note_input_locator,value_note) if value_note
  end

  # Combines all data entry methods
  # @param [Hash] data_set
  def enter_valuation_control_info_data(data_set)
    hide_notifications_bar
    enter_valuation_control_ref_num data_set
  end

end
