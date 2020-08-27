require_relative '../../../spec_helper'

class CoreGroupPage

  include Logging
  include Page
  include CollectionSpacePages
  include CoreSidebar
  include CoreGroupInfoForm

  DEPLOYMENT = Deployment::CORE


  def enter_number_and_text(data)
    enter_title data
    enter_scope_note data
  end
  
  def enter_number(data)
    enter_title data
  end
end