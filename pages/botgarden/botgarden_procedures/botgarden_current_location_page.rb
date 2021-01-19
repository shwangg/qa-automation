require_relative '../../../spec_helper'

class BOTGARDENCurrentLocationPage < CoreUCBCurrentLocationPage

  include Logging
  include Page
  include CollectionSpacePages
#  include BOTGARDENPages
  include BOTGARDENCurrentLocationInfoForm


  DEPLOYMENT = Deployment::BOTGARDEN

  def enter_current_location_data(data)
    enter_action_date data
    select_garden_location data
    enter_movement_note data
    select_action_code data
  end

end
