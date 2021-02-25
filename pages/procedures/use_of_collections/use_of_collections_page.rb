class UseOfCollectionsPage

  include Logging
  include Page
  include CollectionSpacePages
  include Sidebar
  include CoreUseOfCollectionsInfoForm
  include PAHMAUseOfCollectionsInfoForm

  def enter_number_and_text(data)
    enter_reference_nbr data
    enter_note data
  end
  
  def enter_number(data)
    enter_reference_nbr data
  end
end
