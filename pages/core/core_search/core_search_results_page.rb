require_relative '../../../spec_helper'

class CoreSearchResultsPage < SearchResultsPage

  include Logging
  include Page
  include CollectionSpacePages

  DEPLOYMENT = Deployment::CORE

end
