module CorePersonInfoForm

  include Logging
  include Page
  include CollectionSpacePages

  def person_term_display_name_input(index); term_display_name_input [fieldset(CorePersonData::PERSON_TERM_GRP.name, index)] end
  def person_term_name_input(index); term_name_input [fieldset(CorePersonData::PERSON_TERM_GRP.name, index)] end
  def person_term_qualifier_input(index); term_qualifier_input [fieldset(CorePersonData::PERSON_TERM_GRP.name, index)] end
  def person_term_status_input(index); term_status_input [fieldset(CorePersonData::PERSON_TERM_GRP.name, index)] end
  def person_term_status_options(index); term_status_options [fieldset(CorePersonData::PERSON_TERM_GRP.name, index)] end
  def person_term_type_input(index); term_type_input [fieldset(CorePersonData::PERSON_TERM_GRP.name, index)] end
  def person_term_type_options(index); term_type_options [fieldset(CorePersonData::PERSON_TERM_GRP.name, index)] end
  def person_term_flag_input(index); term_flag_input [fieldset(CorePersonData::PERSON_TERM_GRP.name, index)] end
  def person_term_flag_options(index); term_flag_options [fieldset(CorePersonData::PERSON_TERM_GRP.name, index)] end
  def person_term_language_input(index); term_language_input [fieldset(CorePersonData::PERSON_TERM_GRP.name, index)] end
  def person_term_language_options(index); term_language_options [fieldset(CorePersonData::PERSON_TERM_GRP.name, index)] end
  def person_term_pref_for_lang_input(index); term_pref_for_lang_input [fieldset(CorePersonData::PERSON_TERM_GRP.name, index)] end

  def person_term_source_name_input(index); term_source_name_input [fieldset(CorePersonData::PERSON_TERM_GRP.name, index)] end
  def person_term_source_name_options(index); term_source_name_options [fieldset(CorePersonData::PERSON_TERM_GRP.name, index)] end
  def person_term_source_detail_input(index);term_source_detail_input [fieldset(CorePersonData::PERSON_TERM_GRP.name, index)] end
  def person_term_source_id_input(index); term_source_id_input [fieldset(CorePersonData::PERSON_TERM_GRP.name, index)] end
  def person_term_source_note_input(index); term_source_note_input [fieldset(CorePersonData::PERSON_TERM_GRP.name, index)] end

  def name_title_input(fieldsets); input_locator(fieldsets, CorePersonData::NAME_TITLE.name) end
  def name_title_options(fieldsets); input_options_locator(fieldsets, CorePersonData::NAME_TITLE.name) end
  def person_name_title_input(index); name_title_input [fieldset(CorePersonData::PERSON_TERM_GRP.name, index)] end
  def person_name_title_options(index); name_title_options [fieldset(CorePersonData::PERSON_TERM_GRP.name, index)] end

  def name_salutation_input(fieldsets); input_locator(fieldsets, CorePersonData::NAME_SALUTATION.name) end
  def name_salutation_options(fieldsets); input_options_locator(fieldsets, CorePersonData::NAME_SALUTATION.name) end
  def person_name_salutation_input(index); name_title_input [fieldset(CorePersonData::PERSON_TERM_GRP.name, index)] end
  def person_name_salutation_options(index); name_title_options [fieldset(CorePersonData::PERSON_TERM_GRP.name, index)] end

  def name_forename_input(index); input_locator([fieldset(CorePersonData::PERSON_TERM_GRP.name, index)], CorePersonData::NAME_FORENAME.name) end
  def name_middle_name_input(index); input_locator([fieldset(CorePersonData::PERSON_TERM_GRP.name, index)], CorePersonData::NAME_MIDDLE_NAME.name) end
  def name_surname_input(index); input_locator([fieldset(CorePersonData::PERSON_TERM_GRP.name, index)], CorePersonData::NAME_SURNAME.name) end
  def name_addition_input(index); input_locator([fieldset(CorePersonData::PERSON_TERM_GRP.name, index)], CorePersonData::NAME_ADDITION.name) end
  def name_initials_input(index); input_locator([fieldset(CorePersonData::PERSON_TERM_GRP.name, index)], CorePersonData::NAME_INITIALS.name) end

  def nationality_input(index); input_locator([fieldset(CorePersonData::NATIONALITY.name, index)]) end

  #TERMS
  def enter_terms(test_data)
    test_terms = test_data[CorePersonData::PERSON_TERM_GRP.name]
    hide_notifications_bar
    prep_fieldsets_for_test_data([fieldset(CorePersonData::PERSON_TERM_GRP.name)], test_terms)

    test_terms.each do |test_term|
      index = test_terms.index test_term
      logger.info "Entering person term data set at index #{index}: #{test_term}"

      wait_for_options_and_select(person_name_salutation_input(index), person_name_salutation_options(index), test_term[CorePersonData::NAME_SALUTATION.name])
      wait_for_options_and_select(person_name_title_input(index), person_name_title_options(index), test_term[CorePersonData::NAME_TITLE.name])

      wait_for_element_and_type(name_forename_input(index), test_term[CorePersonData::NAME_FORENAME.name])
      wait_for_element_and_type(name_middle_name_input(index), test_term[CorePersonData::NAME_MIDDLE_NAME.name])
      wait_for_element_and_type(name_surname_input(index), test_term[CorePersonData::NAME_SURNAME.name])
      wait_for_element_and_type(name_addition_input(index), test_term[CorePersonData::NAME_ADDITION.name])
      wait_for_element_and_type(name_initials_input(index), test_term[CorePersonData::NAME_INITIALS.name])

      wait_for_element_and_type(person_term_display_name_input(index), test_term[CorePersonData::TERM_DISPLAY_NAME.name])
      wait_for_element_and_type(person_term_name_input(index), test_term[CorePersonData::TERM_NAME.name])
      wait_for_element_and_type(person_term_qualifier_input(index), test_term[CorePersonData::TERM_QUALIFIER.name])
      wait_for_options_and_select(person_term_status_input(index), person_term_status_options(index), test_term[CorePersonData::TERM_STATUS.name])
      wait_for_options_and_select(person_term_type_input(index), person_term_type_options(index), test_term[CorePersonData::TERM_TYPE.name])
      wait_for_options_and_select(person_term_flag_input(index), person_term_flag_options(index), test_term[CorePersonData::TERM_FLAG.name])
      wait_for_options_and_select(person_term_language_input(index), person_term_language_options(index), test_term[CorePersonData::TERM_LANGUAGE.name])
      wait_for_element_and_click person_term_pref_for_lang_input(index) if test_term[CorePersonData::TERM_PREF_FOR_LANGUAGE.name]
      enter_auto_complete(person_term_source_name_input(index), person_term_source_name_options(index), test_term[CorePersonData::TERM_SOURCE.name], 'Local Citations')
      wait_for_element_and_type(person_term_source_detail_input(index), test_term[CorePersonData::TERM_SOURCE_DETAIL.name])
      wait_for_element_and_type(person_term_source_id_input(index), test_term[CorePersonData::TERM_SOURCE_ID.name])
      wait_for_element_and_type(person_term_source_note_input(index), test_term[CorePersonData::TERM_SOURCE_NOTE.name])
    end
  end

  #NATIONALITY
  def enter_nationality(data)
    hide_notifications_bar
    nationalities = data[CorePersonData::NATIONALITY.name]
    prep_fieldsets_for_test_data([fieldset(CorePersonData::NATIONALITY.name)], nationalities)
    nationalities && nationalities.each_with_index do |nationality, index|
      logger.info "Entering nationality '#{nationality[CorePersonData::NATIONALITY.name]}'"
      wait_for_element_and_type(nationality_input(index), nationality[CorePersonData::NATIONALITY.name])
    end
  end

end
