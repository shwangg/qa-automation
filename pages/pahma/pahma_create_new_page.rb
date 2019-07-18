require_relative '../../spec_helper'

class PAHMACreateNewPage < CoreCreateNewPage

  include Logging
  include Page
  include CollectionSpacePages

  DEPLOYMENT = Deployment::PAHMA

end
