require_relative '../../../spec_helper'

class BOTGARDENSearchResultsPage < CoreUCBSearchResultsPage

  include Logging
  include Page
  include CollectionSpacePages

  DEPLOYMENT = Deployment::BOTGARDEN

end
