require_relative '../../spec_helper'

class PAHMAObjectPage < CoreObjectPage

  include Logging
  include Page
  include CollectionSpacePages
  include PAHMAObjectIdInfoForm

  DEPLOYMENT = Deployment::PAHMA

end
