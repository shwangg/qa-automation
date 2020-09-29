require_relative '../../../spec_helper'

module CoreConditionCheckInfoForm

  include Logging
  include Page
  include CollectionSpacePages

  DEPLOYMENT = Deployment::CORE

  def ref_num_input_locator; input_locator([], CoreConditionCheckData::COND_REF_NUM.name) end

  # Enters condition reference number
  # @param [Hash] data_set
  def enter_condition_ref_num(data_set)
    cond_ref_num = data_set[CoreConditionCheckData::COND_REF_NUM.name]
    logger.debug "Entering reference number '#{cond_ref_num}'"
    ref_num_options_locator = input_options_locator([], CoreConditionCheckData::COND_REF_NUM.name)
    wait_for_options_and_type(ref_num_input_locator, ref_num_options_locator, cond_ref_num)
  end

  

  def cond_note_input_locator; text_area_locator([], CoreConditionCheckData::COND_NOTE.name) end

  # Enters condition note
  # @param [Hash] data_set
  def enter_condition_note(data_set)
    cond_note = data_set[CoreConditionCheckData::COND_NOTE.name]
    logger.debug "Entering condition note '#{cond_note}'"
    wait_for_element_and_type(cond_note_input_locator, cond_note) if cond_note
  end
end
