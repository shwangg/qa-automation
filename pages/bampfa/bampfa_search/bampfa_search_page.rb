require_relative '../../../spec_helper'

class BAMPFASearchPage < CoreUCBSearchPage

  include Page
  include CollectionSpacePages

  DEPLOYMENT = Deployment::BAMPFA


end
