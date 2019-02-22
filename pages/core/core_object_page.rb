require_relative '../../spec_helper'

class CoreObjectPage < ObjectPage

  include Logging
  include Page
  include CollectionSpacePages
  include CoreObjectIdInfoForm

  DEPLOYMENT = Deployment::CORE

end
