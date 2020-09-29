require_relative '../../../spec_helper'

class CoreUseOfCollectionsPage

  include Logging
  include Page
  include CollectionSpacePages
  include CoreSidebar
  include CoreUseOfCollectionsInfoForm

  DEPLOYMENT = Deployment::CORE


  def enter_number_and_text(data)
    enter_reference_nbr data
    enter_note data
  end
  
  def enter_number(data)
    enter_reference_nbr data
  end
end
