module PAHMAConditionCheckTechAssessInfoForm

  include Logging
  include Page
  include CollectionSpacePages
  include CoreConditionCheckInfoForm

  def enter_pahma_cond_check_info(data)
    enter_condition_ref_num data
    enter_condition_date data
    enter_next_check_date data
    select_condition_description data
    select_conservation_treatment_priority data
    enter_condition_note data
  end

end
