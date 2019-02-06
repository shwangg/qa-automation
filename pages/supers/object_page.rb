require_relative '../../spec_helper'

class ObjectPage

  include Logging
  include Page
  include CollectionSpacePages
  include ObjectIdInfoForm

  def page_heading; {:xpath => '//h1'} end

end
