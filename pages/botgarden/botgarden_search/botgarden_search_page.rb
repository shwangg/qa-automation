require_relative '../../../spec_helper'

class BOTGARDENSearchPage < CoreUCBSearchPage

  include Page
  include CollectionSpacePages

  DEPLOYMENT = Deployment::BOTGARDEN

  # OBJECT NUMBER
=begin
  def object_num_input(index)
    input_locator [fieldset(BOTGARDENObjectPage::OBJECT_NUM.name, index)]
  end

  def object_num_delete_btn(index)
    delete_button_locator [fieldset(BOTGARDENObjectPage::OBJECT_NUM.name, index)]
  end

  def object_num_add_btn
    add_button_locator [fieldset(BOTGARDENObjectPage::OBJECT_NUM.name)]
  end
=end
end
