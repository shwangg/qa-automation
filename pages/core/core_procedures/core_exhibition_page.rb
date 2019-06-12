require_relative '../../../spec_helper'

class CoreExhibitionPage < ExhibitionPage

  include Logging
  include Page
  include CollectionSpacePages
  include CoreExhibitionInfoForm

  DEPLOYMENT = Deployment::CORE

end
