require_relative '../../../spec_helper'

class CoreValuationPage

  include Logging
  include Page
  include CollectionSpacePages
  include CoreSidebar
  include CoreExhibitionInfoForm

  DEPLOYMENT = Deployment::CORE

end