require_relative '../../../spec_helper'

class CoreUseOfCollectionsPage

  include Logging
  include Page
  include CollectionSpacePages
  include SidebarPages
  include CoreUseOfCollectionsInfoForm

  DEPLOYMENT = Deployment::CORE

end
