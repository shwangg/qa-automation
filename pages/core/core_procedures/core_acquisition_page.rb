require_relative '../../../spec_helper'

class CoreAcquisitionPage < AcquisitionPage

  include Logging
  include Page
  include CollectionSpacePages
  include CoreAcquisitionInfoForm

  DEPLOYMENT = Deployment::CORE

end
