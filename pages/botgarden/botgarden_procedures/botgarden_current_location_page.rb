require_relative '../../../spec_helper'

class BOTGARDENCurrentLocationPage < CoreProcedurePage

  include Logging
  include BOTGARDENPages
  include CollectionSpacePages
  include CoreSidebar
  include BOTGARDENCurrentLocationInfoForm

  DEPLOYMENT = Deployment::BOTGARDEN

  def enter_current_loc_data(data)
    enter_action_date data
    enter_action_code data
    enter_garden_location data
  end


end
