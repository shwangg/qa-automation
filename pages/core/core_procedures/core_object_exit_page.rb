require_relative '../../../spec_helper'

class CoreObjectExitPage

  include Logging
  include Page
  include CollectionSpacePages
  include CoreSidebar
  include CoreObjectExitInfoForm

  DEPLOYMENT = Deployment::CORE

  def enter_number_and_text(data)
    enter_exit_number data
    enter_exit_note data
  end
  
  def enter_number(data)
    enter_exit_number data
  end
end
