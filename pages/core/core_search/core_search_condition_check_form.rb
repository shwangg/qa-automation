require_relative '../../../spec_helper'

module CoreSearchConditionCheckForm

  include Logging
  include Page
  include CollectionSpacePages

  DEPLOYMENT = Deployment::CORE

  def ref_num_input_locator(index); input_locator([fieldset(CoreConditionCheckData::COND_REF_NUM.name, index)]) end

  # Enters condition ref number
  # @param [Hash] data_set
  def enter_condition_ref_num(data_set)
    cond_ref_num = data_set[CoreConditionCheckData::COND_REF_NUM.name]
    print(cond_ref_num)
    logger.debug "Entering condition ref number '#{cond_ref_num}'"
    wait_for_element_and_type(ref_num_input_locator(0), cond_ref_num) if cond_ref_num
  end

  # Clicks the Search link and the Clear button, and selects 'Acquisitions' from the record type
  def load_search_condition_check_form
    click_search_link
    click_clear_button
    select_record_type_option 'Condition Checks'
  end

  # CONDITION DATE

  def condition_date_input_locator; input_locator([], CoreConditionCheckData::COND_CHECK_DATE.name) end

  # Enters an condition date
  # @param [Hash] data_set
  def enter_condition_date(data_set)
    cond_date = data_set[CoreConditionCheckData::COND_CHECK_DATE.name]
    if cond_date
      logger.debug "Enter accession date '#{cond_date}'"
      input = element condition_date_input_locator
      input.clear
      sleep Config.click_wait
      input.send_keys cond_date
      hit_enter
      hit_tab
    end
  end

  # OBJECT AUDIT CATEGORY

  def obj_audit_input_locator(index); input_locator([fieldset(CoreConditionCheckData::OBJ_AUDIT_CATEGORY.name, index)]) end

  # Selects an object audit
  # @param [Hash] data_set
  def select_object_audit_category(data_set)
    obj_audit = data_set[CoreConditionCheckData::OBJ_AUDIT_CATEGORY.name]
    print(obj_audit)
    logger.debug "Selecting #{obj_audit}"
    obj_audit_options_locator = input_options_locator([fieldset(CoreConditionCheckData::OBJ_AUDIT_CATEGORY.name, 0)])
    wait_for_options_and_select(obj_audit_input_locator(0),obj_audit_options_locator, obj_audit) if obj_audit
  end

  # CONSERVATIVE TREATMENT PRIORITY

  def conservation_treatment_input_locator(index); input_locator([fieldset(CoreConditionCheckData::CONS_TREATMENT_PRIORITY.name, index)]) end

  # Selects an priority
  # @param [Hash] data_set
  def select_conservation_treatment_priority(data_set)
    priority = data_set[CoreConditionCheckData::CONS_TREATMENT_PRIORITY.name]
    print(priority)
    logger.debug "Selecting #{priority}"
    conservation_treatment_options_locator = input_options_locator([fieldset(CoreConditionCheckData::CONS_TREATMENT_PRIORITY.name, 0)])
    wait_for_options_and_select(conservation_treatment_input_locator(0),conservation_treatment_options_locator, priority) if priority
  end

  # NEXT CHECK DATE

  def next_check_date_input_locator; input_locator([], CoreConditionCheckData::NXT_COND_CHECK_DATE.name) end

  # Enters an condition date
  # @param [Hash] data_set
  def enter_next_check_date(data_set)
    check_date = data_set[CoreConditionCheckData::NXT_COND_CHECK_DATE.name]
    print(check_date)
    if check_date
      logger.debug "Enter accession date '#{check_date}'"
      input = element next_check_date_input_locator
      input.clear
      sleep Config.click_wait
      input.send_keys check_date
      hit_enter
      hit_tab
    end
  end

  # CONDITION DESCRIPTION

  def condition_description_input_locator(index); input_locator([fieldset(CoreConditionCheckData::COND_DESC.name, index)]) end

  # Selects condition description
  # @param [Hash] data_set
  def select_condition_description(data_set)
    group = data_set[CoreConditionCheckData::COND_CHECK_GRP_LIST.name][0][CoreConditionCheckData::COND_DESC.name]
    print(group)
    logger.debug "Entering condition description #{group}"
    condition_description_options_locator = input_options_locator([fieldset(CoreConditionCheckData::COND_DESC.name, 0)])
    wait_for_options_and_select(condition_description_input_locator(0), condition_description_options_locator, group) if group
  end

  # CONDITION NOTE

  def cond_note_input_locator(index); input_locator([fieldset(CoreConditionCheckData::COND_NOTE.name, index)]) end

  # Enters condition note
  # @param [Hash] data_set
  def enter_condition_note(data_set)
    cond_note = data_set[CoreConditionCheckData::COND_NOTE.name]
    logger.debug "Entering condition note '#{cond_note}'"
    wait_for_element_and_type(cond_note_input_locator(0), cond_note) if cond_note
  end
end
