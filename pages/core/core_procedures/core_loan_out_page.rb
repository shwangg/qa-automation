require_relative '../../../spec_helper'

class CoreLoanOutPage

  include Logging
  include Page
  include CollectionSpacePages
  include CoreSidebar
  include CoreLoanOutInfoForm

  DEPLOYMENT = Deployment::CORE


  def enter_number_and_text(data)
    enter_loan_out_number data
    enter_loan_out_note data
  end
  
  def enter_number(data)
    enter_loan_out_number data
  end
end