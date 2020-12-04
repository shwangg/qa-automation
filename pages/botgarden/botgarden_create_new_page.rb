require_relative '../../spec_helper'

class BOTGARDENCreateNewPage < CoreUCBCreateNewPage

  include Logging
  include Page
  include CollectionSpacePages

  DEPLOYMENT = Deployment::BOTGARDEN

end
