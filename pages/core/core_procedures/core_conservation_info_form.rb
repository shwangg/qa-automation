require_relative '../../../spec_helper'

module CoreConservationInfoForm

  include Logging
  include Page
  include CollectionSpacePages

  DEPLOYMENT = Deployment::CORE

  def ref_num_input_locator; input_locator([], CoreConservationData::CONSERV_NUM.name) end

  # Enters conservation reference number
  # @param [Hash] data_set
  def enter_conservation_ref_num(data_set)
    conserv_num = data_set[CoreConservationData::CONSERV_NUM.name]
    logger.debug "Entering reference number '#{conserv_num}'"
    ref_num_options_locator = input_options_locator([], CoreConservationData::CONSERV_NUM.name)
    wait_for_options_and_type(ref_num_input_locator, ref_num_options_locator, conserv_num)
  end

  

  def fabric_note_input_locator; text_area_locator([], CoreConservationData::FABRIC_NOTE.name) end

  # Enters conservation note
  # @param [Hash] data_set
  def enter_conservation_note(data_set)
    fabric_note = data_set[CoreConservationData::FABRIC_NOTE.name]
    logger.debug "Entering conservation note '#{fabric_note}'"
    wait_for_element_and_type(fabric_note_input_locator, fabric_note) if fabric_note
  end
end
