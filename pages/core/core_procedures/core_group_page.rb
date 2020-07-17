require_relative '../../../spec_helper'

class CoreGroupPage

  include Logging
  include Page
  include CollectionSpacePages
  include CoreSidebar
  include CoreExhibitionInfoForm

  DEPLOYMENT = Deployment::CORE

end