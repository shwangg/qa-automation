require_relative '../../spec_helper'

class CoreSearchPage < SearchPage

  include Page
  include CollectionSpacePages

  DEPLOYMENT = Deployment::CORE

end
