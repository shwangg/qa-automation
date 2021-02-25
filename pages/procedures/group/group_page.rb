class GroupPage

  include Logging
  include Page
  include CollectionSpacePages
  include Sidebar
  include CoreGroupInfoForm

  def enter_number_and_text(data)
    enter_title data
    enter_scope_note data
  end
  
  def enter_number(data)
    enter_title data
  end

  def select_related(related)
    select_group_related related
  end

  def select_and_unrelate_two
    select_and_unrelate_two_objects
  end
end
