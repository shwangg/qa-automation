require_relative '../../../spec_helper'

class CoreAuthorityPage < AuthorityPage

  include Logging
  include Page
  include CollectionSpacePages

  DEPLOYMENT = Deployment::CORE

end
