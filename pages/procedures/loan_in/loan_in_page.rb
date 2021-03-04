class LoanInPage

  include Logging
  include Page
  include CollectionSpacePages
  include Sidebar
  include CoreLoanInInfoForm

  # Enters new acquisition data, save it, and wait for a delete button to appear
  # @param [Hash] data_set
  def create_new_loan_in(data_set)
    enter_loan_in_info_data data_set
    click_save_button
    when_exists(delete_button, Config.short_wait)
  end

  def enter_loan_in_id_data(data)
    enter_loan_in_number data
  end

  def enter_number_and_text(data)
    enter_loan_in_number data
    enter_loan_in_note data
  end
  
  def enter_number(data)
    enter_loan_in_number data
  end

  # Enters data in the various forms on the new object page
  # @param [Hash] data_set
  def enter_loan_in_info_data(data_set)
    enter_loan_in_id_data data_set
    enter_lender_group data
  end

end
