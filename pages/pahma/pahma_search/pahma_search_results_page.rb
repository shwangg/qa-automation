require_relative '../../../spec_helper'

class PAHMASearchResultsPage < CoreUCBSearchResultsPage

  include Logging
  include Page
  include CollectionSpacePages

  DEPLOYMENT = Deployment::PAHMA

end
