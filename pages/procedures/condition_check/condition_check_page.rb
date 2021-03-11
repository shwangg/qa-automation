class ConditionCheckPage

  include Logging
  include Page
  include CollectionSpacePages
  include Sidebar
  include CoreConditionCheckInfoForm
  include PAHMAConditionCheckTechAssessInfoForm

  def create_new_condition_check(data_set)
    enter_condition_check_info_data data_set
    click_save_button
    when_exists(delete_button, Config.short_wait)
  end

  def create_new_pahma_condition_check(data_set)
    enter_pahma_cond_check_info data_set
    save_record
  end

  def enter_number_and_text(data)
    enter_condition_ref_num data
    enter_condition_note data
  end

  def enter_number(data)
    enter_condition_ref_num data
  end
end
