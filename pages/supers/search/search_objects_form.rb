require_relative '../../../spec_helper'

module SearchObjectsForm

  include Logging
  include Page
  include CollectionSpacePages

  # OBJECT NUMBER

  def object_num_input(index)
    input_locator([fieldset(CoreObjectData::OBJECT_NUM.name, index)])
  end

  def object_num_delete_btn(index)
    delete_button_locator([fieldset(CoreObjectData::OBJECT_NUM.name, index)])
  end

  def object_num_add_btn
    add_button_locator([fieldset(CoreObjectData::OBJECT_NUM.name)])
  end

end
