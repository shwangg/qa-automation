require_relative '../../../spec_helper'

class CoreMediaHandlingPage

  include Logging
  include Page
  include CollectionSpacePages
  include CoreSidebar
  include CoreMediaHandlingInfoForm

  DEPLOYMENT = Deployment::CORE

  def enter_number_and_text(data)
    enter_id_number data
    enter_description data
  end
  
  def enter_number(data)
    enter_id_number data
  end
end
