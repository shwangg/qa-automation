class LoanOutPage

  include Logging
  include Page
  include CollectionSpacePages
  include Sidebar
  include CoreLoanOutInfoForm

  def enter_number_and_text(data)
    enter_loan_out_number data
    enter_loan_out_note data
  end
  
  def enter_number(data)
    enter_loan_out_number data
  end
end
