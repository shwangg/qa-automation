require_relative '../../spec_helper'

class PAHMASearchResultsPage < SearchResultsPage

  include Logging
  include Page
  include CollectionSpacePages

  DEPLOYMENT = Deployment::PAHMA

end
