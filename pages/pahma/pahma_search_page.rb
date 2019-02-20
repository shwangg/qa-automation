require_relative '../../spec_helper'

class PAHMASearchPage < SearchPage

  include Page
  include CollectionSpacePages

  DEPLOYMENT = Deployment::PAHMA

end
