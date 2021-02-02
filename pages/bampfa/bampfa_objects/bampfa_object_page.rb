require_relative '../../../spec_helper'

class BAMPFAObjectPage < CoreUCBObjectPage

  include Logging
  include Page
  include CollectionSpacePages
#  include BOTGARDENPages
  include BAMPFASidebar
  include BAMPFAObjectIdInfoForm

  DEPLOYMENT = Deployment::BAMPFA

end