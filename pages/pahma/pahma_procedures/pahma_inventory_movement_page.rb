require_relative '../../../spec_helper'

class PAHMAInventoryMovementPage < CoreUCBInventoryMovementPage

  include PAHMAPages
  include PAHMASidebar
  include PAHMAInventoryMovementInfoForm

  DEPLOYMENT = Deployment::PAHMA

  def complete_info_form(data)
    enter_current_location data
    enter_location_date data
    enter_location_handlers data
    enter_reason data
    enter_methods data
    enter_note data
  end

end
