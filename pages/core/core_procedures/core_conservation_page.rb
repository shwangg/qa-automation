require_relative '../../../spec_helper'

# File was created in order to call the page in the create_quick_records test

class CoreConservationPage
    include Logging
    include Page
    include CollectionSpacePages
    include CoreSidebar
    include CoreAcquisitionInfoForm
  
end