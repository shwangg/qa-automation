require_relative '../../../spec_helper'

class CoreValuationPage

  include Logging
  include Page
  include CollectionSpacePages
  include CoreSidebar
  include CoreValuationInfoForm

  DEPLOYMENT = Deployment::CORE


  def enter_number_and_text(data)
    enter_value_number data
    enter_value_note data
  end
  
  def enter_number(data)
    enter_value_number data
  end
end