require_relative '../../../spec_helper'

class PAHMASearchResultsPage < CoreSearchResultsPage

  include Logging
  include Page
  include CollectionSpacePages

  DEPLOYMENT = Deployment::PAHMA

end
