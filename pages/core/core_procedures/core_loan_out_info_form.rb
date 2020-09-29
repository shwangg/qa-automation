require_relative '../../../spec_helper'

module CoreLoanOutInfoForm

  include Logging
  include Page
  include CollectionSpacePages

  DEPLOYMENT = Deployment::CORE

  def object_num_input; input_locator([], CoreLoanOutData::LOAN_OUT_NUM.name) end
  def object_num_options; input_options_locator([], CoreLoanOutData::LOAN_OUT_NUM.name) end
  
  def enter_loan_out_number(data)
    logger.debug "Entering loan out number #{data[CoreLoanOutData::LOAN_OUT_NUM.name]}"
    wait_for_options_and_type(object_num_input, object_num_options, data[CoreLoanOutData::LOAN_OUT_NUM.name])
  end
  
  def loan_out_note_input_locator; text_area_locator([], CoreLoanOutData::LOAN_OUT_NOTE.name) end

  # Enters loan out note
  # @param [Hash] data_set
  def enter_loan_out_note(data_set)
    loan_out_note = data_set[CoreLoanOutData::LOAN_OUT_NOTE.name]
    logger.debug "Entering loan out note '#{loan_out_note}'"
    wait_for_element_and_type(loan_out_note_input_locator, loan_out_note) if loan_out_note
  end
end