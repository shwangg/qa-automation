require_relative '../../spec_helper'

class CoreCreateNewPage < CreateNewPage

  include Logging
  include Page
  include CollectionSpacePages

  DEPLOYMENT = Deployment::CORE

end
