require_relative '../../../spec_helper'

class CoreOrganizationPage < OrganizationPage

  include Logging
  include Page
  include CollectionSpacePages

  DEPLOYMENT = Deployment::CORE

end
