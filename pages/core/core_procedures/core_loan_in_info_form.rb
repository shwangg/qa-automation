require_relative '../../../spec_helper'

module CoreLoanInInfoForm

  include Logging
  include Page
  include CollectionSpacePages

  DEPLOYMENT = Deployment::CORE

  def object_num_input; input_locator([], CoreLoanInData::LOAN_IN_NUM.name) end
  def object_num_options; input_options_locator([], CoreLoanInData::LOAN_IN_NUM.name) end
  def lender_input(index); input_locator([fieldset(CoreLoanInData::LENDER_GROUP.name, index)], CoreLoanInData::LENDER.name) end
  def lender_options(index); input_options_locator([fieldset(CoreLoanInData::LENDER_GROUP.name, index)], CoreLoanInData::LENDER.name) end
 
  def enter_loan_in_number(data)
    logger.debug "Entering loan in number #{data[CoreLoanInData::LOAN_IN_NUM.name]}"
    wait_for_options_and_type(object_num_input, object_num_options, data[CoreLoanInData::LOAN_IN_NUM.name])
  end

  def enter_lender_group(data)
    users = data[CoreLoanInData::LENDER_GROUP.name] || [CoreLoanInData.empty_user]
    hide_notifications_bar
    prep_fieldsets_for_test_data([fieldset(CoreLoanInData::LENDER_GROUP.name)], users)
    users.each_with_index do |user, index|
      logger.info "Entering user data set at index #{index}: #{user}"
      enter_auto_complete(lender_input(index), lender_options(index), user[CoreLoanInData::LENDER.name])
    end
  end

  def loan_in_note_input_locator; text_area_locator([], CoreLoanInData::LOAN_IN_NOTE.name) end

  # Enters loan in note
  # @param [Hash] data_set
  def enter_loan_in_note(data_set)
    loan_in_note = data_set[CoreLoanInData::LOAN_IN_NOTE.name]
    logger.debug "Entering loan in note '#{loan_in_note}'"
    wait_for_element_and_type(loan_in_note_input_locator, loan_in_note) if loan_in_note
  end
end
