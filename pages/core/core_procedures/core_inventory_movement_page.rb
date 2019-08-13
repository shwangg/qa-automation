require_relative '../../../spec_helper'

class CoreInventoryMovementPage

  include CorePages
  include CoreSidebar
  include CoreInventoryMovementInfoForm

  DEPLOYMENT = Deployment::CORE

  # Completes the Info form on the page
  # @param [Hash] data
  def complete_info_form(data)
    enter_reference_number data
    enter_normal_location data
    enter_current_location data
    enter_location_date data
  end

  # Completes the Info form, saves the record, and adds the resulting record's URL to the test data
  # @param [Hash] data
  def create_unlocked_movement(data)
    complete_info_form data
    save_record_only
    data.merge!({:url => url})
  end

end
