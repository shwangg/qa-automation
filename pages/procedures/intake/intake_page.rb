class IntakePage

  include Logging
  include Page
  include CollectionSpacePages
  include Sidebar
  include CoreIntakeInfoForm

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
