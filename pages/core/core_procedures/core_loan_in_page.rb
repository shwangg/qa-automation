require_relative '../../../spec_helper'

class CoreLoanInPage

  include Logging
  include Page
  include CollectionSpacePages
  include CoreSidebar
<<<<<<< HEAD
<<<<<<< HEAD
  include CoreExhibitionInfoForm

  DEPLOYMENT = Deployment::CORE

end
=======
=======
>>>>>>> 04ee7d97cc5e0a786fa7c2aa24f059c9ad1ab6f7
  include CorePages
  include CoreLoanInInfoForm

  DEPLOYMENT = Deployment::CORE

  # Enters new acquisition data, save it, and wait for a delete button to appear
  # @param [Hash] data_set
  # @return [Array<Object>]
  def create_new_loan_in(data_set)
    data_input_errors = enter_loan_in_info_data data_set
    # click_save_button
    # when_exists(delete_button, Config.short_wait)
  end

  def enter_loan_in_id_data(data)
    # enter_loan_in_number data
    enter_lender_group data
  end

  # Enters data in the various forms on the new object page
  # @param [Hash] data_set
  # @return [Array<Object>]
  def enter_loan_in_info_data(data_set)
    enter_loan_in_id_data data_set
  end

end
<<<<<<< HEAD
>>>>>>> 38e746f... completed test
=======
>>>>>>> 04ee7d97cc5e0a786fa7c2aa24f059c9ad1ab6f7
