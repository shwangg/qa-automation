class ConservationPage

  include Logging
  include Page
  include CollectionSpacePages
  include Sidebar
  include CoreConservationInfoForm

  def create_new_conservation(data_set)
    enter_conservation_info_data data_set
    click_save_button
    when_exists(delete_button, Config.short_wait)
  end

  def enter_number_and_text(data)
    enter_conservation_ref_num data
    enter_fabrication_note data
  end

  def enter_number(data)
    enter_conservation_ref_num data
  end
end
