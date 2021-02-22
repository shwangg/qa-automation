require_relative '../../spec_helper'

class BAMPFACreateNewPage < CoreUCBCreateNewPage

  include Logging
  include Page
  include CollectionSpacePages

  DEPLOYMENT = Deployment::BAMPFA

end
