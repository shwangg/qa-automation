require_relative '../../../spec_helper'

class CoreUseOfCollectionsPage < UseOfCollectionsPage

  include Logging
  include Page
  include CollectionSpacePages

  DEPLOYMENT = Deployment::CORE

end
