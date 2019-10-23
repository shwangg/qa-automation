require_relative '../../../spec_helper'

module CoreUseOfCollectionsInfoForm

  include Logging
  include Page
  include CollectionSpacePages

  def reference_nbr_input; input_locator([], CoreUseOfCollectionsData::REFERENCE_NBR.name) end
  def reference_nbr_options; input_options_locator([], CoreUseOfCollectionsData::REFERENCE_NBR.name) end

  def project_id_input; input_locator([], CoreUseOfCollectionsData::PROJECT_ID.name) end
  def project_id_options; input_options_locator([], CoreUseOfCollectionsData::PROJECT_ID.name) end

  def method_input(index); input_locator([fieldset(CoreUseOfCollectionsData::METHOD.name, index)]) end
  def method_options(index); input_options_locator([fieldset(CoreUseOfCollectionsData::METHOD.name, index)]) end

  def collection_type_input(index); input_locator([fieldset(CoreUseOfCollectionsData::COLLECTION_TYPE_LIST.name, index)]) end
  def collection_type_options(index); input_options_locator([fieldset(CoreUseOfCollectionsData::COLLECTION_TYPE_LIST.name, index)]) end

  def material_type_input(index); input_locator([fieldset(CoreUseOfCollectionsData::MATERIAL_TYPE_LIST.name, index)]) end
  def material_type_options(index); input_options_locator([fieldset(CoreUseOfCollectionsData::MATERIAL_TYPE_LIST.name, index)]) end

  def user_name_input(index); input_locator([fieldset(CoreUseOfCollectionsData::USER_GRP.name, index)], CoreUseOfCollectionsData::USER.name) end
  def user_name_options(index); input_options_locator([fieldset(CoreUseOfCollectionsData::USER_GRP.name, index)], CoreUseOfCollectionsData::USER.name) end
  def user_type_input(index); input_locator([fieldset(CoreUseOfCollectionsData::USER_GRP.name, index)], CoreUseOfCollectionsData::USER_INSTITUTION_ROLE.name) end
  def user_type_options(index); input_options_locator([fieldset(CoreUseOfCollectionsData::USER_GRP.name, index)], CoreUseOfCollectionsData::USER_INSTITUTION_ROLE.name) end
  def user_role_input(index); input_locator([fieldset(CoreUseOfCollectionsData::USER_GRP.name, index)], CoreUseOfCollectionsData::USER_UOC_ROLE.name) end
  def user_role_options(index); input_options_locator([fieldset(CoreUseOfCollectionsData::USER_GRP.name, index)], CoreUseOfCollectionsData::USER_UOC_ROLE.name) end
  def user_institution_input(index); input_locator([fieldset(CoreUseOfCollectionsData::USER_GRP.name, index)], CoreUseOfCollectionsData::USER_INSTITUTION.name) end
  def user_institution_options(index); input_options_locator([fieldset(CoreUseOfCollectionsData::USER_GRP.name, index)], CoreUseOfCollectionsData::USER_INSTITUTION.name) end

  def title_input; input_locator([], CoreUseOfCollectionsData::TITLE.name) end

  def date_requested_input; input_locator([], CoreUseOfCollectionsData::DATE_REQUESTED.name) end
  def date_completed_input; input_locator([], CoreUseOfCollectionsData::DATE_COMPLETED.name) end

  def occasion_input(index); input_locator([fieldset(CoreUseOfCollectionsData::OCCASION.name, index)]) end
  def occasion_options(index); input_options_locator([fieldset(CoreUseOfCollectionsData::OCCASION.name, index)]) end

  def project_desc_text_area; text_area_locator([], CoreUseOfCollectionsData::PROJECT_DESC.name) end

  def authorized_by_input(index); input_locator([fieldset(CoreUseOfCollectionsData::AUTHORIZATION_GRP.name, index)], CoreUseOfCollectionsData::AUTHORIZED_BY.name) end
  def authorized_by_options(index); input_options_locator([fieldset(CoreUseOfCollectionsData::AUTHORIZATION_GRP.name, index)], CoreUseOfCollectionsData::AUTHORIZED_BY.name) end
  def authorization_date_input(index); input_locator([fieldset(CoreUseOfCollectionsData::AUTHORIZATION_GRP.name, index)], CoreUseOfCollectionsData::AUTHORIZATION_DATE.name) end
  def authorization_note_input(index); input_locator([fieldset(CoreUseOfCollectionsData::AUTHORIZATION_GRP.name, index)], CoreUseOfCollectionsData::AUTHORIZATION_NOTE.name) end
  def authorization_status_input(index); input_locator([fieldset(CoreUseOfCollectionsData::AUTHORIZATION_GRP.name, index)], CoreUseOfCollectionsData::AUTHORIZATION_STATUS.name) end
  def authorization_status_options(index); input_options_locator([fieldset(CoreUseOfCollectionsData::AUTHORIZATION_GRP.name, index)], CoreUseOfCollectionsData::AUTHORIZATION_STATUS.name) end

  def use_date_input(index); input_locator([fieldset(CoreUseOfCollectionsData::USE_DATE_GRP.name, index)], CoreUseOfCollectionsData::USE_DATE.name) end
  def use_date_time_note(index); input_locator([fieldset(CoreUseOfCollectionsData::USE_DATE_GRP.name, index)], CoreUseOfCollectionsData::USE_DATE_TIME_NOTE.name) end
  def use_num_visitors_input(index); input_locator([fieldset(CoreUseOfCollectionsData::USE_DATE_GRP.name, index)], CoreUseOfCollectionsData::USE_DATE_NUM_VISITORS.name) end
  def use_hours_spent_input(index); input_locator([fieldset(CoreUseOfCollectionsData::USE_DATE_GRP.name, index)], CoreUseOfCollectionsData::USE_DATE_HOURS_SPENT.name) end
  def use_note_input(index); input_locator([fieldset(CoreUseOfCollectionsData::USE_DATE_GRP.name, index)], CoreUseOfCollectionsData::USE_DATE_VISITOR_NOTE.name) end

  def end_date_input; input_locator([], CoreUseOfCollectionsData::END_DATE.name) end

  def staff_name_input(index); input_locator([fieldset(CoreUseOfCollectionsData::STAFF_GRP.name, index)], CoreUseOfCollectionsData::STAFF_NAME.name) end
  def staff_name_options(index); input_options_locator([fieldset(CoreUseOfCollectionsData::STAFF_GRP.name, index)], CoreUseOfCollectionsData::STAFF_NAME.name) end
  def staff_role_input(index); input_locator([fieldset(CoreUseOfCollectionsData::STAFF_GRP.name, index)], CoreUseOfCollectionsData::STAFF_ROLE.name) end
  def staff_role_options(index); input_options_locator([fieldset(CoreUseOfCollectionsData::STAFF_GRP.name, index)], CoreUseOfCollectionsData::STAFF_ROLE.name) end
  def staff_hours_spent_input(index); input_locator([fieldset(CoreUseOfCollectionsData::STAFF_GRP.name, index)], CoreUseOfCollectionsData::STAFF_HOURS_SPENT.name) end
  def staff_note_input(index); input_locator([fieldset(CoreUseOfCollectionsData::STAFF_GRP.name, index)], CoreUseOfCollectionsData::STAFF_NOTE.name) end

  def location_input(index); input_locator([fieldset(CoreUseOfCollectionsData::LOCATION_LIST.name, index)]) end
  def location_options(index); input_options_locator([fieldset(CoreUseOfCollectionsData::LOCATION_LIST.name, index)]) end

  def fee_value_input(index); input_locator([fieldset(CoreUseOfCollectionsData::FEE_GRP.name, index)], CoreUseOfCollectionsData::FEE_VALUE.name) end
  def fee_currency_input(index); input_locator([fieldset(CoreUseOfCollectionsData::FEE_GRP.name, index)], CoreUseOfCollectionsData::FEE_CURRENCY.name) end
  def fee_currency_options(index); input_options_locator([fieldset(CoreUseOfCollectionsData::FEE_GRP.name, index)], CoreUseOfCollectionsData::FEE_CURRENCY.name) end
  def fee_note_input(index); input_locator([fieldset(CoreUseOfCollectionsData::FEE_GRP.name, index)], CoreUseOfCollectionsData::FEE_NOTE.name) end
  def fee_paid_input(index); input_locator([fieldset(CoreUseOfCollectionsData::FEE_GRP.name, index)], CoreUseOfCollectionsData::FEE_PAID.name) end

  def note_text_area; text_area_locator([], CoreUseOfCollectionsData::NOTE.name) end
  def provisos_text_area; text_area_locator([], CoreUseOfCollectionsData::PROVISOS.name) end
  def result_text_area; text_area_locator([], CoreUseOfCollectionsData::RESULT.name) end

  def obligations_input; input_locator([], CoreUseOfCollectionsData::OBLIGATIONS.name) end

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

  # PROJECT ID

  # Selects the auto-generated project ID and returns it. If a test data set is given, inserts the ID.
  # @param [Hash] test_data
  # @return [String]
  def select_auto_project_id(test_data=nil)
    hide_notifications_bar
    id = select_id_generator_option(project_id_input, project_id_options)
    logger.info "Selected auto-generated project ID '#{id}'"
    test_data.merge!({CoreUseOfCollectionsData::PROJECT_ID.name => id}) if test_data
    id
  end

  # Enters a project ID per a given set of test data
  # @param [Hash] test_data
  def select_project_id(test_data)
    hide_notifications_bar
    logger.info "Entering project ID '#{test_data[CoreUseOfCollectionsData::PROJECT_ID.name]}'"
    wait_for_options_and_select(project_id_input, project_id_options, test_data[CoreUseOfCollectionsData::PROJECT_ID.name])
  end

  # Verifies a project ID matches test data
  # @param [Hash] test_data
  def verify_project_id(test_data)
    verify_values_match(test_data[CoreUseOfCollectionsData::PROJECT_ID.name], element_value(project_id_input))
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

  # COLLECTION TYPE

  # Selects collection types per a given set of test data
  # @param [Hash] test_data
  def select_collection_types(test_data)
    types = test_data[CoreUseOfCollectionsData::COLLECTION_TYPE_LIST.name] || [{CoreUseOfCollectionsData::COLLECTION_TYPE.name => ''}]
    hide_notifications_bar
    prep_fieldsets_for_test_data([fieldset(CoreUseOfCollectionsData::COLLECTION_TYPE_LIST.name)], types)

    types.each_with_index do |type, index|
      logger.info "Entering collection type data set at index #{index}: #{type}"
      logger.debug "Hitting input at '#{collection_type_input(index)}'"
      wait_for_options_and_select(collection_type_input(index), collection_type_options(index), type[CoreUseOfCollectionsData::COLLECTION_TYPE.name])
    end
  end

  # Verifies collection types match test data
  # @param [Hash] test_data
  def verify_collection_types(test_data)
    types = test_data[CoreUseOfCollectionsData::COLLECTION_TYPE_LIST.name] || [{CoreUseOfCollectionsData::COLLECTION_TYPE.name => ''}]
    types.each_with_index { |type, index| verify_values_match(type[CoreUseOfCollectionsData::COLLECTION_TYPE.name], element_value(collection_type_input index)) }
  end

  # MATERIAL TYPE

  # Selects material types per a given set of test data
  # @param [Hash] test_data
  def select_material_types(test_data)
    types = test_data[CoreUseOfCollectionsData::MATERIAL_TYPE_LIST.name] || [{CoreUseOfCollectionsData::MATERIAL_TYPE.name => ''}]
    hide_notifications_bar
    prep_fieldsets_for_test_data([fieldset(CoreUseOfCollectionsData::MATERIAL_TYPE_LIST.name)], types)

    types.each_with_index do |type, index|
      logger.info "Entering material type data set at index #{index}: #{type}"
      wait_for_options_and_select(material_type_input(index), material_type_options(index), type[CoreUseOfCollectionsData::MATERIAL_TYPE.name])
    end
  end

  # Verifies material types match test data
  # @param [Hash] test_data
  def verify_material_types(test_data)
    types = test_data[CoreUseOfCollectionsData::MATERIAL_TYPE_LIST.name] || [{CoreUseOfCollectionsData::MATERIAL_TYPE.name => ''}]
    types.each_with_index { |type, index| verify_values_match(type[CoreUseOfCollectionsData::MATERIAL_TYPE.name], element_value(material_type_input index)) }
  end

  # USERS

  # Enters users data per a given set of test data
  # @param [Hash] test_data
  def enter_users(test_data)
    users = test_data[CoreUseOfCollectionsData::USER_GRP.name] || [CoreUseOfCollectionsData.empty_user]
    hide_notifications_bar
    prep_fieldsets_for_test_data([fieldset(CoreUseOfCollectionsData::USER_GRP.name)], users)

    users.each_with_index do |user, index|
      logger.info "Entering user data set at index #{index}: #{user}"
      enter_auto_complete(user_name_input(index), user_name_options(index), user[CoreUseOfCollectionsData::USER.name], 'Local Persons')
      wait_for_options_and_select(user_type_input(index), user_type_options(index), user[CoreUseOfCollectionsData::USER_INSTITUTION_ROLE.name])
      wait_for_options_and_select(user_role_input(index), user_role_options(index), user[CoreUseOfCollectionsData::USER_UOC_ROLE.name])
      enter_auto_complete(user_institution_input(index), user_institution_options(index), user[CoreUseOfCollectionsData::USER_INSTITUTION.name], 'Local Organizations')
    end
  end

  # Verifies that the users data matches test data
  # @param [Hash] test_data
  def verify_users(test_data)
    users = test_data[CoreUseOfCollectionsData::USER_GRP.name] || [CoreUseOfCollectionsData.empty_user]
    users.each_with_index do |user, index|
      verify_values_match(user[CoreUseOfCollectionsData::USER.name], element_value(user_name_input index))
      verify_values_match(user[CoreUseOfCollectionsData::USER_INSTITUTION_ROLE.name], element_value(user_type_input index))
      verify_values_match(user[CoreUseOfCollectionsData::USER_UOC_ROLE.name], element_value(user_role_input index))
      verify_values_match(user[CoreUseOfCollectionsData::USER_INSTITUTION.name], element_value(user_institution_input index))
    end
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

  # DATE REQUESTED

  # Enters date requested per a given set of test data
  # @param [Hash] test_data
  def enter_date_requested(test_data)
    hide_notifications_bar
    logger.info "Entering date requested '#{test_data[CoreUseOfCollectionsData::DATE_REQUESTED.name]}'"
    wait_for_element_and_type(date_requested_input, test_data[CoreUseOfCollectionsData::DATE_REQUESTED.name])
    hit_enter
  end

  # Verifies date requested matches test data
  # @param [Hash] test_data
  def verify_date_requested(test_data)
    verify_values_match(test_data[CoreUseOfCollectionsData::DATE_REQUESTED.name], element_value(date_requested_input))
  end

  # DATE COMPLETED

  # Enters date completed per a given set of test data
  # @param [Hash] test_data
  def enter_date_completed(test_data)
    hide_notifications_bar
    logger.info "Entering date completed '#{test_data[CoreUseOfCollectionsData::DATE_COMPLETED.name]}'"
    wait_for_element_and_type(date_completed_input, test_data[CoreUseOfCollectionsData::DATE_COMPLETED.name])
    hit_enter
  end

  # Verifies date completed matches test data
  # @param [Hash] test_data
  def verify_date_completed(test_data)
    verify_values_match(test_data[CoreUseOfCollectionsData::DATE_COMPLETED.name], element_value(date_completed_input))
  end

  # OCCASIONS

  # Enters occasions per a given set of test data
  # @param [Hash] test_data
  def enter_occasions(test_data)
    occasions = test_data[CoreUseOfCollectionsData::OCCASION_LIST.name] || [{CoreUseOfCollectionsData::OCCASION.name => ''}]
    hide_notifications_bar
    prep_fieldsets_for_test_data([fieldset(CoreUseOfCollectionsData::OCCASION_LIST.name)], occasions)
    occasions.each_with_index do |occasion, index|
      logger.info "Entering occasion data set at index #{index}: #{occasion}"
      enter_auto_complete(occasion_input(index), occasion_options(index), occasion[CoreUseOfCollectionsData::OCCASION.name], 'Occasion Concepts')
    end
  end

  # Verifies occasions match test data
  # @param [Hash] test_data
  def verify_occasions(test_data)
    occasions = test_data[CoreUseOfCollectionsData::OCCASION_LIST.name] || [{CoreUseOfCollectionsData::OCCASION.name => ''}]
    occasions.each_with_index { |occasion, index| verify_values_match(occasion[CoreUseOfCollectionsData::OCCASION.name], element_value(occasion_input index)) }
  end

  # PROJECT DESCRIPTION

  # Enters project description per a given set of test data
  # @param [Hash] test_data
  def enter_project_desc(test_data)
    hide_notifications_bar
    logger.info "Entering project description '#{test_data[CoreUseOfCollectionsData::PROJECT_DESC.name]}'"
    wait_for_element_and_type(project_desc_text_area, test_data[CoreUseOfCollectionsData::PROJECT_DESC.name])
  end

  # Verifies project description matches test data
  # @param [Hash] test_data
  def verify_project_desc(test_data)
    verify_values_match(test_data[CoreUseOfCollectionsData::PROJECT_DESC.name], element_value(project_desc_text_area))
  end

  # AUTHORIZATIONS

  # Enters authorizations per a given set of test data
  # @param [Hash] test_data
  def enter_authorizations(test_data)
    authorizations = test_data[CoreUseOfCollectionsData::AUTHORIZATION_GRP.name] || [CoreUseOfCollectionsData.empty_authorization]
    hide_notifications_bar
    prep_fieldsets_for_test_data([fieldset(CoreUseOfCollectionsData::AUTHORIZATION_GRP.name)], authorizations)
    authorizations.each_with_index do |auth, index|
      logger.info "Entering authorization data set at index #{index}: #{auth}"
      enter_auto_complete(authorized_by_input(index), authorized_by_options(index), auth[CoreUseOfCollectionsData::AUTHORIZED_BY.name], 'Local Persons')
      wait_for_element_and_type(authorization_date_input(index), auth[CoreUseOfCollectionsData::AUTHORIZATION_DATE.name])
      hit_enter
      wait_for_element_and_type(authorization_note_input(index), auth[CoreUseOfCollectionsData::AUTHORIZATION_NOTE.name])
      wait_for_options_and_select(authorization_status_input(index), authorization_status_options(index), auth[CoreUseOfCollectionsData::AUTHORIZATION_STATUS.name])
    end
  end

  # Verifies authorizations match test data
  # @param [Hash] test_data
  def verify_authorizations(test_data)
    authorizations = test_data[CoreUseOfCollectionsData::AUTHORIZATION_GRP.name] || [CoreUseOfCollectionsData.empty_authorization]
    authorizations.each_with_index do |auth, index|
      verify_values_match(auth[CoreUseOfCollectionsData::AUTHORIZED_BY.name], element_value(authorized_by_input index))
      verify_values_match(auth[CoreUseOfCollectionsData::AUTHORIZATION_DATE.name], element_value(authorization_date_input index))
      verify_values_match(auth[CoreUseOfCollectionsData::AUTHORIZATION_NOTE.name], element_value(authorization_note_input index))
      verify_values_match(auth[CoreUseOfCollectionsData::AUTHORIZATION_STATUS.name], element_value(authorization_status_input index))
    end
  end

  # USE DATES

  # Enters use dates per a given set of test data
  # @param [Hash] test_data
  def enter_use_dates(test_data)
    dates = test_data[CoreUseOfCollectionsData::USE_DATE_GRP.name] || [CoreUseOfCollectionsData.empty_use_date]
    hide_notifications_bar
    prep_fieldsets_for_test_data([fieldset(CoreUseOfCollectionsData::USE_DATE_GRP.name)], dates)
    dates.each_with_index do |date, index|
      logger.info "Entering use date data set at index #{index}: #{date}"
      wait_for_element_and_type(use_date_input(index), date[CoreUseOfCollectionsData::USE_DATE.name])
      hit_enter
      wait_for_element_and_type(use_date_time_note(index), date[CoreUseOfCollectionsData::USE_DATE_TIME_NOTE.name])
      wait_for_element_and_type(use_num_visitors_input(index), date[CoreUseOfCollectionsData::USE_DATE_NUM_VISITORS.name])
      wait_for_element_and_type(use_hours_spent_input(index), date[CoreUseOfCollectionsData::USE_DATE_HOURS_SPENT.name])
      wait_for_element_and_type(use_note_input(index), date[CoreUseOfCollectionsData::USE_DATE_VISITOR_NOTE.name])
    end
  end

  # Verifies use dates match test data
  # @param [Hash] test_data
  def verify_use_dates(test_data)
    dates = test_data[CoreUseOfCollectionsData::USE_DATE_GRP.name] || [CoreUseOfCollectionsData.empty_use_date]
    dates.each_with_index do |date, index|
      verify_values_match(date[CoreUseOfCollectionsData::USE_DATE.name], element_value(use_date_input index))
      verify_values_match(date[CoreUseOfCollectionsData::USE_DATE_TIME_NOTE.name], element_value(use_date_time_note(index)))
      verify_values_match(date[CoreUseOfCollectionsData::USE_DATE_NUM_VISITORS.name], element_value(use_num_visitors_input index))
      verify_values_match(date[CoreUseOfCollectionsData::USE_DATE_HOURS_SPENT.name], element_value(use_hours_spent_input index))
      verify_values_match(date[CoreUseOfCollectionsData::USE_DATE_VISITOR_NOTE.name], element_value(use_note_input index))
    end
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

  # STAFF

  # Enters staff per a given set of test data
  # @param [Hash] test_data
  def enter_staff(test_data)
    staff = test_data[CoreUseOfCollectionsData::STAFF_GRP.name] || [CoreUseOfCollectionsData.empty_staff]
    hide_notifications_bar
    prep_fieldsets_for_test_data([fieldset(CoreUseOfCollectionsData::STAFF_GRP.name)], staff)
    staff.each_with_index do |staf, index|
      logger.info "Entering staff data set at index #{index}: #{staf}"
      enter_auto_complete(staff_name_input(index), staff_name_options(index), staf[CoreUseOfCollectionsData::STAFF_NAME.name], 'Local Persons')
      wait_for_options_and_select(staff_role_input(index), staff_role_options(index), staf[CoreUseOfCollectionsData::STAFF_ROLE.name])
      wait_for_element_and_type(staff_hours_spent_input(index), staf[CoreUseOfCollectionsData::STAFF_HOURS_SPENT.name])
      wait_for_element_and_type(staff_note_input(index), staf[CoreUseOfCollectionsData::STAFF_NOTE.name])
    end
  end

  # Verifies staff match test data
  # @param [Hash] test_data
  def verify_staff(test_data)
    staff = test_data[CoreUseOfCollectionsData::STAFF_GRP.name] || [CoreUseOfCollectionsData.empty_staff]
    staff.each_with_index do |staf, index|
      verify_values_match(staf[CoreUseOfCollectionsData::STAFF_NAME.name], element_value(staff_name_input index))
      verify_values_match(staf[CoreUseOfCollectionsData::STAFF_ROLE.name], element_value(staff_role_input index))
      verify_values_match(staf[CoreUseOfCollectionsData::STAFF_HOURS_SPENT.name], element_value(staff_hours_spent_input index))
      verify_values_match(staf[CoreUseOfCollectionsData::STAFF_NOTE.name], element_value(staff_note_input index))
    end
  end

  # LOCATIONS

  # Enters locations per a given set of test data
  # @param [Hash] test_data
  def enter_locations(test_data)
    locations = test_data[CoreUseOfCollectionsData::LOCATION_LIST.name] || [{CoreUseOfCollectionsData::LOCATION.name => ''}]
    hide_notifications_bar
    prep_fieldsets_for_test_data([fieldset(CoreUseOfCollectionsData::LOCATION_LIST.name)], locations)
    locations.each_with_index do |location, index|
      logger.info "Entering location data set at index #{index}: #{location}"
      enter_auto_complete(location_input(index), location_options(index), location[CoreUseOfCollectionsData::LOCATION.name], 'Local Places')
    end
  end

  # Verifies locations match a given set of test data
  # @param [Hash] test_data
  def verify_locations(test_data)
    locations = test_data[CoreUseOfCollectionsData::LOCATION_LIST.name] || [{CoreUseOfCollectionsData::LOCATION.name => ''}]
    locations.each_with_index { |location, index| verify_values_match(location[CoreUseOfCollectionsData::LOCATION.name], element_value(location_input index)) }
  end

  # FEE

  # Enters fees per a given set of test data
  # @param [Hash] test_data
  def enter_fees(test_data)
    fees = test_data[CoreUseOfCollectionsData::FEE_GRP.name] || [CoreUseOfCollectionsData.empty_fee]
    hide_notifications_bar
    prep_fieldsets_for_test_data([fieldset(CoreUseOfCollectionsData::FEE_GRP.name)], fees)
    fees.each_with_index do |fee, index|
      logger.info "Entering fee data set at index #{index}: #{fee}"
      wait_for_options_and_select(fee_currency_input(index), fee_currency_options(index), fee[CoreUseOfCollectionsData::FEE_CURRENCY.name])
      wait_for_element_and_type(fee_value_input(index), fee[CoreUseOfCollectionsData::FEE_VALUE.name])
      wait_for_element_and_type(fee_note_input(index), fee[CoreUseOfCollectionsData::FEE_NOTE.name])
      wait_for_element_and_click(fee_paid_input(index)) if fee[CoreUseOfCollectionsData::FEE_PAID.name]
    end
  end

  # Verifies fees match test data
  # @param [Hash] test_data
  def verify_fees(test_data)
    fees = test_data[CoreUseOfCollectionsData::FEE_GRP.name] || [CoreUseOfCollectionsData.empty_fee]
    fees.each_with_index do |fee, index|
      verify_values_match(fee[CoreUseOfCollectionsData::FEE_CURRENCY.name], element_value(fee_currency_input index))
      verify_values_match(fee[CoreUseOfCollectionsData::FEE_VALUE.name], element_value(fee_value_input index))
      verify_values_match(fee[CoreUseOfCollectionsData::FEE_NOTE.name], element_value(fee_note_input index))
    end
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

  # OBLIGATIONS

  # Clicks the obligations fulfilled checkbox, though it knows nothing about whether it is checking or un-checking
  def click_obligations_fulfilled
    wait_for_element_and_click obligations_input
  end

end
