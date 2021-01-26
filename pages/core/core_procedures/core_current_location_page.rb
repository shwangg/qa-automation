require_relative '../../../spec_helper'


class CoreCurrentLocationPage
    include Logging
    include Page
    include CollectionSpacePages
    include CoreSidebar
    include CoreCurrentLocationInfoForm
  

    DEPLOYMENT = Deployment::CORE

     
end