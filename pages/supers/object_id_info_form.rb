require_relative '../../spec_helper'

module ObjectIdInfoForm

  include Logging
  include Page
  include CollectionSpacePages

  def object_num_input
    input_locator([], ObjectData::OBJECT_NUM.name)
  end

  def object_num_options
    input_options_locator([], ObjectData::OBJECT_NUM.name)
  end

end
