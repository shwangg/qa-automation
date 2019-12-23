require_relative '../../spec_helper'

class PAHMACreateNewPage < CoreUCBCreateNewPage

  include Logging
  include Page
  include CollectionSpacePages

  DEPLOYMENT = Deployment::PAHMA

end
