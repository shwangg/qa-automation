require_relative '../../../spec_helper'

class CoreUseOfCollectionsPage

  include Logging
  include Page
  include CollectionSpacePages
  include CoreSidebar
  include CoreUseOfCollectionsInfoForm

  DEPLOYMENT = Deployment::CORE

end
