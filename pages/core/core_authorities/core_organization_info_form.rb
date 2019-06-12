require_relative '../../../spec_helper'

module CoreOrganizationInfoForm

  include Logging
  include Page
  include CollectionSpacePages
  include OrganizationInfoForm

  DEPLOYMENT = Deployment::CORE

  def add_term_grp_btn; add_button_locator([fieldset(CoreOrgData::ORG_TERM_GRP.name)]) end
  def move_org_term_grp_top_btn(index); move_top_button_locator([fieldset(CoreOrgData::ORG_TERM_GRP.name)], index) end
  def main_body_name_input(index); input_locator([fieldset(CoreOrgData::ORG_TERM_GRP.name, index)], CoreOrgData::MAIN_BODY_NAME.name) end
  def addition_to_name_input(index); input_locator([fieldset(CoreOrgData::ORG_TERM_GRP.name, index)], CoreOrgData::ADDITIONS_TO_NAME.name) end
  def org_record_type_input(index); input_locator([fieldset(CoreOrgData::ORG_RECORD_TYPES.name, index)]) end
  def org_record_type_options(index); input_options_locator([fieldset(CoreOrgData::ORG_RECORD_TYPES.name, index)]) end
  def group_input(index); input_locator([fieldset(CoreOrgData::GROUPS.name, index)]) end
  def function_input(index); input_locator([fieldset(CoreOrgData::FUNCTIONS.name, index)]) end
  def history_input(index); text_area_locator([fieldset(CoreOrgData::HISTORY_NOTES.name, index)]) end
  def foundation_date_input; input_locator_by_label(CoreOrgData::FOUNDING_DATE.label) end
  def foundation_place_input; input_locator([], CoreOrgData::FOUNDING_PLACE.name) end
  def dissolution_date_input; input_locator_by_label(CoreOrgData::DISSOLUTION_DATE.label) end
  def contact_name_input(index); input_locator([fieldset(CoreOrgData::CONTACT_NAMES.name, index)]) end
  def contact_name_options(index); input_options_locator([fieldset(CoreOrgData::CONTACT_NAMES.name, index)]) end

  # TERMS

  # Adds a term fieldset
  def add_term_grp
    wait_for_element_and_click add_term_grp_btn
  end

  # Moves the term at a given index to the top of the terms
  # @param [Integer] index
  def move_term_grp_top(index)
    wait_for_element_and_click move_org_term_grp_top_btn(index)
  end

  # Completes the various fields in a term fieldset per a given set of test data, adding or removing data.
  # @param [Hash] test_data
  def enter_terms(test_data)
    test_terms = test_data[CoreOrgData::ORG_TERM_GRP.name]
    hide_notifications_bar
    prep_fieldsets_for_test_data([fieldset(CoreOrgData::ORG_TERM_GRP.name)], test_terms)

    test_terms.each do |test_term|
      index = test_terms.index test_term
      logger.info "Entering org term data set at index #{index}: #{test_term}"
      enter_display_name(test_term[CoreOrgData::TERM_DISPLAY_NAME.name], index)
      wait_for_element_and_type(org_term_name_input(index), test_term[CoreOrgData::TERM_NAME.name])
      wait_for_element_and_type(org_term_qualifier_input(index), test_term[CoreOrgData::TERM_QUALIFIER.name])
      wait_for_options_and_select(org_term_status_input(index), org_term_status_options(index), test_term[CoreOrgData::TERM_STATUS.name])
      wait_for_options_and_select(org_term_type_input(index), org_term_type_options(index), test_term[CoreOrgData::TERM_TYPE.name])
      wait_for_options_and_select(org_term_flag_input(index), org_term_flag_options(index), test_term[CoreOrgData::TERM_FLAG.name])
      wait_for_options_and_select(org_term_language_input(index), org_term_language_options(index), test_term[CoreOrgData::TERM_LANGUAGE.name])
      wait_for_element_and_click org_term_pref_for_lang_input(index) if test_term[CoreOrgData::TERM_PREF_FOR_LANGUAGE.name]
      wait_for_element_and_type(main_body_name_input(index), test_term[CoreOrgData::MAIN_BODY_NAME.name])
      wait_for_element_and_type(addition_to_name_input(index), test_term[CoreOrgData::ADDITIONS_TO_NAME.name])
      enter_auto_complete(org_term_source_name_input(index), org_term_source_name_options(index), test_term[CoreOrgData::TERM_SOURCE.name], 'Local Citations')
      wait_for_element_and_type(org_term_source_detail_input(index), test_term[CoreOrgData::TERM_SOURCE_DETAIL.name])
      wait_for_element_and_type(org_term_source_id_input(index), test_term[CoreOrgData::TERM_SOURCE_ID.name])
      wait_for_element_and_type(org_term_source_note_input(index), test_term[CoreOrgData::TERM_SOURCE_NOTE.name])
    end
  end

  # Verifies that the values of the various fields in a term fieldset match the corresponding fields in a given set of
  # test data. Returns an array of mismatches.
  # @param [Hash] test_data
  # @return [Array<String>]
  def verify_terms(test_data)
    test_terms = test_data[CoreOrgData::ORG_TERM_GRP.name]
    errors = []
    test_terms.each do |test_term|
      index = test_terms.index test_term
      text_values_match?(test_term[CoreOrgData::TERM_DISPLAY_NAME.name], element_value(display_name_input index), errors)
      text_values_match?(test_term[CoreOrgData::TERM_NAME.name], element_value(org_term_name_input index), errors)
      text_values_match?(test_term[CoreOrgData::TERM_QUALIFIER.name], element_value(org_term_qualifier_input index), errors)
      text_values_match?(test_term[CoreOrgData::TERM_STATUS.name], element_value(org_term_status_input index), errors)
      text_values_match?(test_term[CoreOrgData::TERM_TYPE.name], element_value(org_term_type_input index), errors)
      text_values_match?(test_term[CoreOrgData::TERM_FLAG.name], element_value(org_term_flag_input index), errors)
      text_values_match?(test_term[CoreOrgData::TERM_LANGUAGE.name], element_value(org_term_language_input index), errors)
      # TODO - element does not indicate its state # text_values_match?(test_term[CoreOrgData::TERM_PREF_FOR_LANGUAGE.name], element_value(org_term_pref_for_lang_input index), errors)
      text_values_match?(test_term[CoreOrgData::MAIN_BODY_NAME.name], element_value(main_body_name_input index), errors)
      text_values_match?(test_term[CoreOrgData::ADDITIONS_TO_NAME.name], element_value(addition_to_name_input index), errors)
      text_values_match?(test_term[CoreOrgData::TERM_SOURCE.name], element_value(org_term_source_name_input index), errors)
      text_values_match?(test_term[CoreOrgData::TERM_SOURCE_DETAIL.name], element_value(org_term_source_detail_input index), errors)
      text_values_match?(test_term[CoreOrgData::TERM_SOURCE_ID.name], element_value(org_term_source_id_input index), errors)
      text_values_match?(test_term[CoreOrgData::TERM_SOURCE_NOTE.name], element_value(org_term_source_note_input index), errors)
    end
    errors
  end

  # TYPES

  # Adds or remove org types per a given set of test data
  # @param [Hash] test_data
  def enter_types(test_data)
    test_types = test_data[CoreOrgData::ORG_RECORD_TYPES.name]
    test_types = [{CoreOrgData::ORG_RECORD_TYPE.name => ''}] unless test_types
    hide_notifications_bar
    prep_fieldsets_for_test_data([fieldset(CoreOrgData::ORG_RECORD_TYPES.name)], test_types)

    test_types.each do |test_type|
      index = test_types.index test_type
      logger.info "Entering org type data set at index #{index}: #{test_type}"
      wait_for_options_and_select(org_record_type_input(index), org_record_type_options(index), test_type[CoreOrgData::ORG_RECORD_TYPE.name])
    end
  end

  # Verifies that the value of the org types (if any) match the corresponding fields in a given set of test data. Returns
  # an array of mismatches
  # @param [Hash] test_data
  # @return [Array<String>]
  def verify_types(test_data)
    test_types = test_data[CoreOrgData::ORG_RECORD_TYPES.name]
    errors = []
    test_types = [{CoreOrgData::ORG_RECORD_TYPE.name => ''}] unless test_types
    test_types.each do |test_type|
      index = test_types.index test_type
      text_values_match?(test_type[CoreOrgData::ORG_RECORD_TYPE.name], element_value(org_record_type_input(index)), errors)
    end
    errors
  end

  # GROUPS

  # Adds or removes groups per a given set of test data
  # @param [Hash] test_data
  def enter_groups(test_data)
    test_groups = test_data[CoreOrgData::GROUPS.name]
    test_groups = [{CoreOrgData::GROUP.name => ''}] unless test_groups
    hide_notifications_bar
    prep_fieldsets_for_test_data([fieldset(CoreOrgData::GROUPS.name)], test_groups)

    test_groups.each do |test_grp|
      index = test_groups.index test_grp
      logger.info "Entering org group data set at index #{index}: #{test_grp}"
      wait_for_element_and_type(group_input(index), test_grp[CoreOrgData::GROUP.name])
    end
  end

  # Verifies that the value of the groups (if any) match the corresponding fields in a given set of test data. Returns an
  # array of mismatches
  # @param [Hash] test_data
  # @return [Array<String>]
  def verify_groups(test_data)
    test_groups = test_data[CoreOrgData::GROUPS.name]
    errors = []
    test_groups = [{CoreOrgData::GROUP.name => ''}] unless test_groups
    test_groups.each do |test_grp|
      index = test_groups.index test_grp
      text_values_match?(test_grp[CoreOrgData::GROUP.name], element_value(group_input(index)), errors)
    end
    errors
  end

  # FUNCTIONS

  # Adds or removes functions per a given set of test data
  # @param [Hash] test_data
  def enter_functions(test_data)
    test_functions = test_data[CoreOrgData::FUNCTIONS.name]
    test_functions = [{CoreOrgData::FUNCTION.name => ''}] unless test_functions
    hide_notifications_bar
    prep_fieldsets_for_test_data([fieldset(CoreOrgData::FUNCTIONS.name)], test_functions)

    test_functions.each do |test_function|
      index = test_functions.index test_function
      logger.info "Enter org function data set at index #{index}: #{test_function}"
      wait_for_element_and_type(function_input(index), test_function[CoreOrgData::FUNCTION.name])
    end
  end

  # Verifies that the value of the functions (if any) match the corresponding fields in a given set of test data. Returns
  # an array of mismatches
  # @param [Hash] test_data
  # @return [Array<String>]
  def verify_functions(test_data)
    test_functions = test_data[CoreOrgData::FUNCTIONS.name]
    errors = []
    test_functions = [{CoreOrgData::FUNCTION.name => ''}] unless test_functions
    test_functions.each do |test_function|
      index = test_functions.index test_function
      text_values_match?(test_function[CoreOrgData::FUNCTION.name], element_value(function_input(index)), errors)
    end
    errors
  end

  # HISTORY NOTES

  # Adds or removes history notes per a given set of test data
  # @param [Hash] test_data
  def enter_history_notes(test_data)
    test_histories = test_data[CoreOrgData::HISTORY_NOTES.name]
    test_histories = [{CoreOrgData::HISTORY_NOTE.name => ''}] unless test_histories
    hide_notifications_bar
    prep_fieldsets_for_test_data([fieldset(CoreOrgData::HISTORY_NOTES.name)], test_histories)

    test_histories.each do |test_history|
      index = test_histories.index test_history
      logger.info "Entering org history note data set at index #{index}: #{test_history}"
      wait_for_element_and_type(history_input(index), test_history[CoreOrgData::HISTORY_NOTE.name])
    end
  end

  # Verifies that the value of the history notes (if any) match the corresponding fields in a given set of test data. Returns
  # an array of mismatches
  # @param [Hash] test_data
  # @return [Array<String>]
  def verify_history_notes(test_data)
    test_histories = test_data[CoreOrgData::HISTORY_NOTES.name]
    errors = []
    test_histories = [{CoreOrgData::HISTORY_NOTE.name => ''}] unless test_histories
    test_histories.each do |test_history|
      index = test_histories.index test_history
      text_values_match?(test_history[CoreOrgData::HISTORY_NOTE.name], element_value(history_input(index)), errors)
    end
    errors
  end

  # FOUNDATION & DISSOLUTION

  # Adds or removes a foundation date per a given set of test data
  # @param [Hash] test_data
  def enter_foundation_date(test_data)
    test_date = test_data[CoreOrgData::FOUNDING_DATE.name]
    logger.info "Entering org foundation date: #{test_date}"
    hide_notifications_bar
    enter_simple_date(foundation_date_input, test_date)
  end

  # Verifies that the value of the foundation date (if any) matches the corresponding field in a given set of test data.
  # Returns an array of mismatches.
  # @param [Hash] test_data
  # @return [Array<String>]
  def verify_foundation_date(test_data)
    errors = []
    text_values_match?(test_data[CoreOrgData::FOUNDING_DATE.name], element_value(foundation_date_input), errors)
    errors
  end

  # Adds or removes a foundation place per a given set of test data
  # @param [Hash] test_data
  def enter_foundation_place(test_data)
    test_place = test_data[CoreOrgData::FOUNDING_PLACE.name]
    logger.info "Entering org foundation place: #{test_place}"
    hide_notifications_bar
    wait_for_element_and_type(foundation_place_input, test_place)
  end

  # Verifies that the value of the foundation place (if any) matches the corresponding field in a given set of test data.
  # Returns an array of mismatches
  # @param [Hash] test_data
  # @return [Array<String>]
  def verify_foundation_place(test_data)
    errors = []
    text_values_match?(test_data[CoreOrgData::FOUNDING_PLACE.name], element_value(foundation_place_input), errors)
    errors
  end

  # Adds or removes a dissolution data per a given set of test data
  # @param [Hash] test_data
  def enter_dissolution_date(test_data)
    test_date = test_data[CoreOrgData::DISSOLUTION_DATE.name]
    logger.info "Entering org dissolution date: #{test_date}"
    hide_notifications_bar
    enter_simple_date(dissolution_date_input, test_date)
  end

  # Verifies that the value of the dissolution data (if any) matches the corresponding field in a given set of test data.
  # Returns an array of mismatches
  # @param [Hash] test_data
  # @return [Array<String>]
  def verify_dissolution_date(test_data)
    errors = []
    text_values_match?(test_data[CoreOrgData::DISSOLUTION_DATE.name], element_value(dissolution_date_input), errors)
    errors
  end

  # CONTACT NAMES

  # Adds or removes contact names per a given set of test data
  # @param [Hash] test_data
  def enter_contact_names(test_data)
    test_names = test_data[CoreOrgData::CONTACT_NAMES.name]
    test_names = [{CoreOrgData::CONTACT_NAME.name => ''}] unless test_names
    hide_notifications_bar
    prep_fieldsets_for_test_data([fieldset(CoreOrgData::CONTACT_NAMES.name)], test_names)

    test_names.each do |test_name|
      index = test_names.index test_name
      logger.info "Entering org contact name data set at index #{index}: #{test_name}"
      enter_auto_complete(contact_name_input(index), contact_name_options(index), test_name[CoreOrgData::CONTACT_NAME.name], 'Local Persons')
    end
  end

  # Verifies that the values of the contact names (if any) match the corresponding fields in a given set of test data.
  # Returns an array of mismatches
  # @param [Hash] test_data
  # @return [Array<String>]
  def verify_contact_names(test_data)
    test_names = test_data[CoreOrgData::CONTACT_NAMES.name]
    errors = []
    test_names = [{CoreOrgData::CONTACT_NAME.name => ''}] unless test_names
    test_names.each do |test_name|
      index = test_names.index test_name
      text_values_match?(test_name[CoreOrgData::CONTACT_NAME.name], element_value(contact_name_input(index)), errors)
    end
    errors
  end

end
