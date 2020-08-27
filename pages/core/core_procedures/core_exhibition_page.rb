require_relative '../../../spec_helper'

class CoreExhibitionPage

  include Logging
  include Page
  include CollectionSpacePages
  include CoreSidebar
  include CoreExhibitionInfoForm

  DEPLOYMENT = Deployment::CORE


  def enter_number_and_text(data)
    enter_exhibition_num data
    enter_planning_note data
  end
  
  def enter_number(data)
    enter_exhibition_num data
  end
end
