module CoreConditionCheckInfoForm

  include Logging
  include Page
  include CollectionSpacePages

  def ref_num_input_locator; input_locator([], CoreConditionCheckData::COND_REF_NUM.name) end

  # Enters condition reference number
  # @param [Hash] data_set
  def enter_condition_ref_num(data_set)
    cond_ref_num = data_set[CoreConditionCheckData::COND_REF_NUM.name]
    logger.debug "Entering reference number '#{cond_ref_num}'"
    ref_num_options_locator = input_options_locator([], CoreConditionCheckData::COND_REF_NUM.name)
    wait_for_options_and_type(ref_num_input_locator, ref_num_options_locator, cond_ref_num)
  end

  # CONDITION DATE

  def condition_date_input_locator; input_locator([], CoreConditionCheckData::COND_CHECK_DATE.name) end

  # Enters an condition date
  # @param [Hash] data_set
  def enter_condition_date(data_set)
    cond_date = data_set[CoreConditionCheckData::COND_CHECK_DATE.name]
    if cond_date
      logger.info "Entering condition date '#{data_set[CoreConditionCheckData::COND_CHECK_DATE.name]}'"
      enter_simple_date(condition_date_input_locator, cond_date)
    end
  end

  # OBJECT AUDIT CATEGORY

  def object_audit_input_locator; input_locator([], CoreConditionCheckData::OBJ_AUDIT_CATEGORY.name) end

  # Selects an object audit
  # @param [Hash] data_set
  def select_object_audit_category(data_set)
    obj_audit = data_set[CoreConditionCheckData::OBJ_AUDIT_CATEGORY.name]
    if obj_audit
      logger.debug "Entering object auditd '#{obj_audit}'"
      object_audit_options_locator = input_options_locator([], CoreConditionCheckData::OBJ_AUDIT_CATEGORY.name)
      hit_escape
      wait_for_options_and_select(object_audit_input_locator, object_audit_options_locator, obj_audit)
    end
  end


  # CONSERVATIVE TREATMENT PRIORITY

  def conservation_treatment_input_locator; input_locator([], CoreConditionCheckData::CONS_TREATMENT_PRIORITY.name) end

  # Selects an priority
  # @param [Hash] data_set
  def select_conservation_treatment_priority(data_set)
    priority = data_set[CoreConditionCheckData::CONS_TREATMENT_PRIORITY.name]
    if priority
      logger.debug "Entering priority '#{priority}'"
      conservation_treatment_options_locator = input_options_locator([], CoreConditionCheckData::CONS_TREATMENT_PRIORITY.name)
      hit_escape
      wait_for_options_and_select(conservation_treatment_input_locator, conservation_treatment_options_locator, priority)
    end
  end

  # NEXT CHECK DATE
  def next_check_date_input_locator; input_locator([], CoreConditionCheckData::NXT_COND_CHECK_DATE.name) end

  # Enters an condition date
  # @param [Hash] data_set
  def enter_next_check_date(data_set)
    check_date = data_set[CoreConditionCheckData::NXT_COND_CHECK_DATE.name]
    if check_date
      logger.info "Entering check date '#{data_set[CoreConditionCheckData::NXT_COND_CHECK_DATE.name]}'"
      enter_simple_date(next_check_date_input_locator, check_date)
    end
  end

  # CONDITION DESCRIPTION

  def condition_description_input_locator(index); input_locator([fieldset(CoreConditionCheckData::COND_CHECK_GRP_LIST.name, index)], CoreConditionCheckData::COND_DESC.name) end
  def condition_description_options_locator(index); input_options_locator([fieldset(CoreConditionCheckData::COND_CHECK_GRP_LIST.name, index)], CoreConditionCheckData::COND_DESC.name) end

  # Selects condition description
  # @param [Hash] data_set
  def select_condition_description(data_set)
    conditions = data_set[CoreConditionCheckData::COND_CHECK_GRP_LIST.name]
    conditions && conditions.each do |cond, index|
      logger.debug "Entering condition description #{cond} at index #{index}"
      wait_for_options_and_select(condition_description_input_locator(index), condition_description_options_locator(index), cond[CoreConditionCheckData::COND_DESC.name])
    end
  end

  # CONDITION NOTE

  def cond_note_input_locator; text_area_locator([], CoreConditionCheckData::COND_NOTE.name) end

  # Enters condition note
  # @param [Hash] data_set
  def enter_condition_note(data_set)
    cond_note = data_set[CoreConditionCheckData::COND_NOTE.name]
    logger.debug "Entering condition note '#{cond_note}'"
    wait_for_element_and_type(cond_note_input_locator, cond_note) if cond_note
  end

  # DISPLAY RECOMMENDATION

  def disp_rec_input_locator; text_area_locator([], CoreConditionCheckData::DISP_REC.name) end

  # Enters display recommendation
  # @param [Hash] data_set
  def enter_display_recommendation(data_set)
    disp_rec = data_set[CoreConditionCheckData::DISP_REC.name]
    logger.debug "Entering condition note '#{disp_rec}'"
    wait_for_element_and_type(disp_rec_input_locator, disp_rec) if disp_rec
  end

  # HANDLING RECOMMENDATION

  def handling_rec_input_locator; text_area_locator([], CoreConditionCheckData::HANDLING_REC.name) end

  # Enters handling recommendation
  # @param [Hash] data_set
  def enter_handling_recommendation(data_set)
    handling_rec = data_set[CoreConditionCheckData::HANDLING_REC.name]
    logger.debug "Entering condition note '#{handling_rec}'"
    wait_for_element_and_type(handling_rec_input_locator, handling_rec) if handling_rec
  end

  def header_1; {:xpath => '//span[contains(.,"Object Condition Information")]'} end
  def header_2; {:xpath => '//span[contains(.,"Object Recommendation/Requirement Information")]'} end

  def expand_headers
    unless exists? object_audit_input_locator
      wait_for_element_and_click header_1
      wait_for_element_and_click header_2
    end
  end

  def enter_condition_check_info_data(data_set)
    hide_notifications_bar
    expand_headers
    scroll_to_top
    enter_condition_ref_num data_set
    enter_condition_date data_set
    select_object_audit_category data_set
    select_conservation_treatment_priority data_set
    enter_next_check_date data_set
    select_condition_description data_set
    enter_condition_note data_set
    enter_display_recommendation data_set
    enter_handling_recommendation data_set
  end
end
