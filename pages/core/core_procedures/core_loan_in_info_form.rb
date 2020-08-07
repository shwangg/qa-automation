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
  def found_0; {:xpath => '//span[contains(.,"No matching terms found")]'} end
  def found_1; {:xpath => '//span[contains(.,"1 matching term found")]'} end
  def found_2; {:xpath => '//span[contains(.,"2 matching terms found")]'} end
  def found_3; {:xpath => '//span[contains(.,"3 matching terms found")]'} end
 
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
end
