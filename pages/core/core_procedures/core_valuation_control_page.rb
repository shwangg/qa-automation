require_relative '../../../spec_helper'

class CoreValuationControlPage

  include Logging
  include Page
  include CollectionSpacePages
  include CoreSidebar
  include CoreValuationControlInfoForm

  DEPLOYMENT = Deployment::CORE

  # Enters new valuation control data, save it, and wait for a delete button to appear
  # @param [Hash] data_set
  # @return [Array<Object>]
  def create_new_valuation_control(data_set)
    enter_valuation_control_info_data data_set
    click_save_button
    when_exists(delete_button, Config.short_wait)
  end

end
