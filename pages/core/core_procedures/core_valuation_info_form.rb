require_relative '../../../spec_helper'

module CoreValuationInfoForm

  include Logging
  include Page
  include CollectionSpacePages

  DEPLOYMENT = Deployment::CORE

  def object_num_input; input_locator([], CoreValuationControlData::VALUE_NUM.name) end
  def object_num_options; input_options_locator([], CoreValuationControlData::VALUE_NUM.name) end
  
  def enter_value_number(data)
    logger.debug "Entering number #{data[CoreValuationControlData::VALUE_NUM.name]}"
    wait_for_options_and_type(object_num_input, object_num_options, data[CoreValuationControlData::VALUE_NUM.name])
  end
  
  def value_note_input_locator; text_area_locator([], CoreValuationControlData::VALUE_NOTE.name) end

  # Enters value_ note
  # @param [Hash] data_set
  def enter_value_note(data_set)
    value_note = data_set[CoreValuationControlData::VALUE_NOTE.name]
    logger.debug "Entering value_note '#{value_note}'"
    wait_for_element_and_type(value_note_input_locator,value_note) if value_note
  end
end