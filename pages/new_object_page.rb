require_relative '../spec_helper'

class NewObjectPage

  include Logging
  include Page
  include CollectionSpacePages
  include NewObjectIdInfoForm

  def page_heading; {:xpath => '//h1'} end

end
