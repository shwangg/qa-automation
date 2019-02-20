require_relative '../../spec_helper'

class PAHMACreateNewPage < CreateNewPage

  include Logging
  include Page
  include CollectionSpacePages

  DEPLOYMENT = Deployment::PAHMA

end
