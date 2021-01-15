require_relative '../../../spec_helper'

class CoreProcedurePage

  include Logging
  include Page
  include CollectionSpacePages
  include CoreSidebar

  DEPLOYMENT = Deployment::CORE

end
