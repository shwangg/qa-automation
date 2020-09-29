require_relative '../../../spec_helper'

class CoreIntakePage

  include Logging
  include Page
  include CollectionSpacePages
  include CoreSidebar
  include CoreIntakeInfoForm

  DEPLOYMENT = Deployment::CORE


  def enter_number_and_text(data)
    enter_entry_num data
    enter_entry_note data
  end
  
  def enter_number(data)
    enter_entry_num data
  end

  def select_template(template)
    select_intake_template(template)
  end
end