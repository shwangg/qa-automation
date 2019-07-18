require_relative '../../../spec_helper'

module CoreUseOfCollectionsInfoForm

  include Logging
  include Page
  include CollectionSpacePages

  def reference_nbr_input; input_locator([], CoreUseOfCollectionsData::REFERENCE_NBR.name) end
  def reference_nbr_options; input_options_locator([], CoreUseOfCollectionsData::REFERENCE_NBR.name) end
  def method_input(index); input_locator([fieldset(CoreUseOfCollectionsData::METHOD.name, index)]) end
  def method_options(index); input_options_locator([fieldset(CoreUseOfCollectionsData::METHOD.name, index)]) end
  def method_add_btn; add_button_locator([fieldset(CoreUseOfCollectionsData::METHOD.name)]) end
  def title_input; input_locator([], CoreUseOfCollectionsData::TITLE.name) end
  def authorized_by_input; input_locator([], CoreUseOfCollectionsData::AUTHORIZED_BY.name) end
  def authorized_by_options; input_options_locator([], CoreUseOfCollectionsData::AUTHORIZED_BY.name) end
  def authorization_date_input; input_locator([], CoreUseOfCollectionsData::AUTHORIZATION_DATE.name) end
  def authorization_note_input; input_locator([], CoreUseOfCollectionsData::AUTHORIZATION_NOTE.name) end
  def start_single_date_input; input_locator([], CoreUseOfCollectionsData::START_SINGLE_DATE.name) end
  def end_date_input; input_locator([], CoreUseOfCollectionsData::END_DATE.name) end
  def user_name_input(index); input_locator([fieldset(CoreUseOfCollectionsData::USER_GRP.name, index)], CoreUseOfCollectionsData::USER.name) end
  def user_name_options(index); input_options_locator([fieldset(CoreUseOfCollectionsData::USER_GRP.name, index)], CoreUseOfCollectionsData::USER.name) end
  def user_type_input(index); input_locator([fieldset(CoreUseOfCollectionsData::USER_GRP.name, index)], CoreUseOfCollectionsData::USER_TYPE.name) end
  def user_type_options(index); input_options_locator([fieldset(CoreUseOfCollectionsData::USER_GRP.name, index)], CoreUseOfCollectionsData::USER_TYPE.name) end
  def user_add_btn; add_button_locator([fieldset(CoreUseOfCollectionsData::USER_GRP.name)]) end
  def location_input; input_locator([], CoreUseOfCollectionsData::LOCATION.name) end
  def location_options; input_options_locator([], CoreUseOfCollectionsData::LOCATION.name) end
  def note_text_area; text_area_locator([], CoreUseOfCollectionsData::NOTE.name) end
  def provisos_text_area; text_area_locator([], CoreUseOfCollectionsData::PROVISOS.name) end
  def result_text_area; text_area_locator([], CoreUseOfCollectionsData::RESULT.name) end

  # SHOW / HIDE FORM

  # Hides the Use of Collections Information form
  def hide_uoc_info_form
    logger.info 'Hiding the Use of Collections Info form'
    wait_for_element_and_click form_show_hide_button('Use of Collections Information')
  end

  # Un-hides the Use of Collections Information form
  def show_uoc_info_form
    logger.info 'Showing the Use of Collections Info form'
    wait_for_element_and_click form_show_hide_button('Use of Collections Information')
  end

  # REFERENCE NUMBER

  # Selects the next auto-generated reference number and inserts it into the test data set
  # @param [Hash] test_data
  # @return [Hash]
  def select_auto_reference_nbr(test_data)
    hide_notifications_bar
    ref_nbr = select_id_generator_option(reference_nbr_input, reference_nbr_options)
    logger.info "Selected auto-generated reference number '#{ref_nbr}'"
    test_data.merge!({CoreUseOfCollectionsData::REFERENCE_NBR.name => ref_nbr})
  end

  # Adds or removes a custom reference number per a given set of test data
  # @param [Hash] test_data
  def enter_reference_nbr(test_data)
    hide_notifications_bar
    logger.info "Entering reference number '#{test_data[CoreUseOfCollectionsData::REFERENCE_NBR.name]}'"
    wait_for_options_and_type(reference_nbr_input, reference_nbr_options, test_data[CoreUseOfCollectionsData::REFERENCE_NBR.name])
  end

  # Verifies that the reference number matches test data
  # @param [Hash] test_data
  # @return [Array<String>]
  def verify_reference_nbr(test_data)
    verify_values_match(test_data[CoreUseOfCollectionsData::REFERENCE_NBR.name], element_value(reference_nbr_input))
  end

  # METHODS

  # Selects or removes UoC methods per a given set of test data
  # @param [Hash] test_data
  def select_methods(test_data)
    test_methods = test_data[CoreUseOfCollectionsData::METHOD_LIST.name]
    hide_notifications_bar
    test_methods = [{CoreUseOfCollectionsData::METHOD.name => ''}] unless test_methods
    prep_fieldsets_for_test_data([fieldset(CoreUseOfCollectionsData::METHOD_LIST.name)], test_methods)

    test_methods.each_with_index do |method, index|
      logger.info "Entering method data set at index #{index}: #{method}"
      wait_for_options_and_select(method_input(index), method_options(index), method[CoreUseOfCollectionsData::METHOD.name])
    end
  end

  # Verifies that the methods match test data
  # @param [Hash] test_data
  def verify_methods(test_data)
    test_methods = test_data[CoreUseOfCollectionsData::METHOD_LIST.name]
    test_methods = [{CoreUseOfCollectionsData::METHOD.name => ''}] unless test_methods
    test_methods.each_with_index { |test_method, index| verify_values_match(test_method[CoreUseOfCollectionsData::METHOD.name], element_value(method_input index)) }
  end

  # TITLE

  # Enters or removes a title per a given set of test data
  # @param [Hash] test_data
  def enter_title(test_data)
    hide_notifications_bar
    logger.info "Entering title '#{test_data[CoreUseOfCollectionsData::TITLE.name]}'"
    wait_for_element_and_type(title_input, test_data[CoreUseOfCollectionsData::TITLE.name])
  end

  # Verifies that the title matches test data
  # @param [Hash] test_data
  def verify_title(test_data)
    verify_values_match(test_data[CoreUseOfCollectionsData::TITLE.name], element_value(title_input))
  end

  # AUTHORIZATION

  # Enters or removes an authorized-by per a given set of test data
  # @param [Hash] test_data
  def enter_authorized_by(test_data)
    hide_notifications_bar
    logger.info "Entering authorized by '#{test_data[CoreUseOfCollectionsData::AUTHORIZED_BY.name]}'"
    enter_auto_complete(authorized_by_input, authorized_by_options, test_data[CoreUseOfCollectionsData::AUTHORIZED_BY.name], 'Local Persons')
  end

  # Enters or removes an authorization date per a given set of test data
  # @param [Hash] test_data
  def enter_authorization_date(test_data)
    hide_notifications_bar
    logger.info "Entering authorization date '#{test_data[CoreUseOfCollectionsData::AUTHORIZATION_DATE.name]}'"
    wait_for_element_and_type(authorization_date_input, test_data[CoreUseOfCollectionsData::AUTHORIZATION_DATE.name])
    hit_enter
  end

  # Enters or removes an authorization note per a given set of test data
  # @param [Hash] test_data
  def enter_authorization_note(test_data)
    hide_notifications_bar
    logger.info "Entering authorization note '#{test_data[CoreUseOfCollectionsData::AUTHORIZATION_NOTE.name]}'"
    wait_for_element_and_type(authorization_note_input, test_data[CoreUseOfCollectionsData::AUTHORIZATION_NOTE.name])
  end

  # Verifies that an authorized-by matches test data
  # @param [Hash] test_data
  def verify_authorized_by(test_data)
    verify_values_match(test_data[CoreUseOfCollectionsData::AUTHORIZED_BY.name], element_value(authorized_by_input))
  end

  # Verifies that an authorization date matches test data
  # @param [Hash] test_data
  def verify_authorization_date(test_data)
    verify_values_match(test_data[CoreUseOfCollectionsData::AUTHORIZATION_DATE.name], element_value(authorization_date_input))
  end

  # Verifies that an authorization note matches test data
  # @param [Hash] test_data
  def verify_authorization_note(test_data)
    verify_values_match(test_data[CoreUseOfCollectionsData::AUTHORIZATION_NOTE.name], element_value(authorization_note_input))
  end

  # START / SINGLE DATE

  # Enters a start single date per a given set of test data
  # @param [Hash] test_data
  def enter_start_single_date(test_data)
    hide_notifications_bar
    logger.info "Entering start / single date '#{test_data[CoreUseOfCollectionsData::START_SINGLE_DATE.name]}'"
    wait_for_element_and_type(start_single_date_input, test_data[CoreUseOfCollectionsData::START_SINGLE_DATE.name])
    hit_enter
  end

  # Verifies that the start single date matches test data
  # @param [Hash] test_data
  def verify_start_single_date(test_data)
    verify_values_match(test_data[CoreUseOfCollectionsData::START_SINGLE_DATE.name], element_value(start_single_date_input))
  end

  # END DATE

  # Enters or removes a UoC end date per a given set of test data
  # @param [Hash] test_data
  def enter_end_date(test_data)
    hide_notifications_bar
    logger.info "Entering end date '#{test_data[CoreUseOfCollectionsData::END_DATE.name]}'"
    wait_for_element_and_type(end_date_input, test_data[CoreUseOfCollectionsData::END_DATE.name])
    hit_enter
  end

  # Verifies that the end date matches test data
  # @param [Hash] test_data
  def verify_end_date(test_data)
    verify_values_match(test_data[CoreUseOfCollectionsData::END_DATE.name], element_value(end_date_input))
  end

  # USERS

  # Enters users data per a given set of test data
  # @param [Hash] test_data
  def enter_users(test_data)
    test_users = test_data[CoreUseOfCollectionsData::USER_GRP.name]
    hide_notifications_bar
    test_users = [{CoreUseOfCollectionsData::USER.name => '', CoreUseOfCollectionsData::USER_TYPE.name => ''}] unless test_users
    prep_fieldsets_for_test_data([fieldset(CoreUseOfCollectionsData::USER_GRP.name)], test_users)

    test_users.each_with_index do |user, index|
      logger.info "Entering user data set at index #{index}: #{user}"
      enter_auto_complete(user_name_input(index), user_name_options(index), user[CoreUseOfCollectionsData::USER.name], 'Local Persons')
      wait_for_options_and_select(user_type_input(index), user_type_options(index), user[CoreUseOfCollectionsData::USER_TYPE.name])
    end
  end

  # Verifies that the users data matches test data
  # @param [Hash] test_data
  def verify_users(test_data)
    test_users = test_data[CoreUseOfCollectionsData::USER_GRP.name]
    test_users = [{CoreUseOfCollectionsData::USER.name => '', CoreUseOfCollectionsData::USER_TYPE.name => ''}] unless test_users
    test_users.each_with_index do |user, index|
      verify_values_match(user[CoreUseOfCollectionsData::USER.name], element_value(user_name_input index))
      verify_values_match(user[CoreUseOfCollectionsData::USER_TYPE.name], element_value(user_type_input index))
    end
  end

  # LOCATION

  # Enters or removes a UoC location per a given set of test data
  # @param [Hash] test_data
  def enter_location(test_data)
    hide_notifications_bar
    logger.info "Entering location '#{test_data[CoreUseOfCollectionsData::LOCATION.name]}'"
    enter_auto_complete(location_input, location_options, test_data[CoreUseOfCollectionsData::LOCATION.name], 'Local Places')
  end

  # Verifies that the location matches test data
  # @param [Hash] test_data
  def verify_location(test_data)
    verify_values_match(test_data[CoreUseOfCollectionsData::LOCATION.name], element_value(location_input))
  end

  # NOTE

  # Enters or removes a UoC note per a given set of test data
  # @param [Hash] test_data
  def enter_note(test_data)
    hide_notifications_bar
    logger.info "Entering note '#{test_data[CoreUseOfCollectionsData::NOTE.name]}'"
    wait_for_element_and_type(note_text_area, test_data[CoreUseOfCollectionsData::NOTE.name])
  end

  # Verifies that the note matches test data
  # @param [Hash] test_data
  def verify_note(test_data)
    verify_values_match(test_data[CoreUseOfCollectionsData::NOTE.name], element_value(note_text_area))
  end

  # PROVISOS

  # Enters or removes provisos per a given set of test data
  # @param [Hash] test_data
  def enter_provisos(test_data)
    hide_notifications_bar
    logger.info "Entering provisos '#{test_data[CoreUseOfCollectionsData::PROVISOS.name]}'"
    wait_for_element_and_type(provisos_text_area, test_data[CoreUseOfCollectionsData::PROVISOS.name])
  end

  # Verifies that the provisos match test data
  # @param [Hash] test_data
  def verify_provisos(test_data)
    verify_values_match(test_data[CoreUseOfCollectionsData::PROVISOS.name], element_value(provisos_text_area))
  end

  # RESULT

  # Enters or removes a result per a given set of test data
  # @param [Hash] test_data
  def enter_result(test_data)
    hide_notifications_bar
    logger.info "Entering result '#{test_data[CoreUseOfCollectionsData::RESULT.name]}'"
    wait_for_element_and_type(result_text_area, test_data[CoreUseOfCollectionsData::RESULT.name])
  end

  # Verifies that the result matches test data
  # @param [Hash] test_data
  def verify_result(test_data)
    verify_values_match(test_data[CoreUseOfCollectionsData::RESULT.name], element_value(result_text_area))
  end

end
