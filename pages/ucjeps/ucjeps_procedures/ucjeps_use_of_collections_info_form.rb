require_relative '../../../spec_helper'

module UCJEPSUseOfCollectionsInfoForm

  include Logging
  include Page
  include CollectionSpacePages

  @data = UCJEPSUseOfCollectionsData

  def project_id_input; input_locator([], UCJEPSUseOfCollectionsData::PROJECT_ID.name) end
  def project_id_options; input_options_locator([], UCJEPSUseOfCollectionsData::PROJECT_ID.name) end

  def collection_type_input(index); input_locator([fieldset(UCJEPSUseOfCollectionsData::COLLECTION_TYPE_LIST.name, index)]) end
  def collection_type_options(index); input_options_locator([fieldset(UCJEPSUseOfCollectionsData::COLLECTION_TYPE_LIST.name, index)]) end

  def material_type_input(index); input_locator([fieldset(UCJEPSUseOfCollectionsData::MATERIAL_TYPE_LIST.name, index)]) end
  def material_type_options(index); input_options_locator([fieldset(UCJEPSUseOfCollectionsData::MATERIAL_TYPE_LIST.name, index)]) end

  def user_role_input(index); input_locator([fieldset(UCJEPSUseOfCollectionsData::USER_GRP.name, index)], UCJEPSUseOfCollectionsData::USER_ROLE.name) end
  def user_role_options(index); input_options_locator([fieldset(UCJEPSUseOfCollectionsData::USER_GRP.name, index)], UCJEPSUseOfCollectionsData::USER_ROLE.name) end
  def user_institution_input(index); input_locator([fieldset(UCJEPSUseOfCollectionsData::USER_GRP.name, index)], UCJEPSUseOfCollectionsData::USER_INSTITUTION.name) end
  def user_institution_options(index); input_options_locator([fieldset(UCJEPSUseOfCollectionsData::USER_GRP.name, index)], UCJEPSUseOfCollectionsData::USER_INSTITUTION.name) end

  def date_requested_input; input_locator([], UCJEPSUseOfCollectionsData::DATE_REQUESTED.name) end
  def date_completed_input; input_locator([], UCJEPSUseOfCollectionsData::DATE_COMPLETED.name) end

  def occasion_input(index); input_locator([fieldset(UCJEPSUseOfCollectionsData::OCCASION.name, index)]) end
  def occasion_options(index); input_options_locator([fieldset(UCJEPSUseOfCollectionsData::OCCASION.name, index)]) end

  def project_desc_text_area; text_area_locator([], UCJEPSUseOfCollectionsData::PROJECT_DESC.name) end

  def authorized_by_input(index); input_locator([fieldset(UCJEPSUseOfCollectionsData::AUTHORIZATION_GRP.name, index)], UCJEPSUseOfCollectionsData::AUTHORIZED_BY.name) end
  def authorized_by_options(index); input_options_locator([fieldset(UCJEPSUseOfCollectionsData::AUTHORIZATION_GRP.name, index)], UCJEPSUseOfCollectionsData::AUTHORIZED_BY.name) end
  def authorization_date_input(index); input_locator([fieldset(UCJEPSUseOfCollectionsData::AUTHORIZATION_GRP.name, index)], UCJEPSUseOfCollectionsData::AUTHORIZATION_DATE.name) end
  def authorization_note_input(index); input_locator([fieldset(UCJEPSUseOfCollectionsData::AUTHORIZATION_GRP.name, index)], UCJEPSUseOfCollectionsData::AUTHORIZATION_NOTE.name) end
  def authorization_status_input(index); input_locator([fieldset(UCJEPSUseOfCollectionsData::AUTHORIZATION_GRP.name, index)], UCJEPSUseOfCollectionsData::AUTHORIZATION_STATUS.name) end
  def authorization_status_options(index); input_options_locator([fieldset(UCJEPSUseOfCollectionsData::AUTHORIZATION_GRP.name, index)], UCJEPSUseOfCollectionsData::AUTHORIZATION_STATUS.name) end

  def use_date_input(index); input_locator([fieldset(UCJEPSUseOfCollectionsData::USE_DATE_GRP.name, index)], UCJEPSUseOfCollectionsData::USE_DATE.name) end
  def use_num_visitors_input(index); input_locator([fieldset(UCJEPSUseOfCollectionsData::USE_DATE_GRP.name, index)], UCJEPSUseOfCollectionsData::USE_DATE_NUM_VISITORS.name) end
  def use_hours_spent_input(index); input_locator([fieldset(UCJEPSUseOfCollectionsData::USE_DATE_GRP.name, index)], UCJEPSUseOfCollectionsData::USE_DATE_HOURS_SPENT.name) end
  def use_note_input(index); input_locator([fieldset(UCJEPSUseOfCollectionsData::USE_DATE_GRP.name, index)], UCJEPSUseOfCollectionsData::USE_DATE_VISITOR_NOTE.name) end

  def staff_name_input(index); input_locator([fieldset(UCJEPSUseOfCollectionsData::STAFF_GRP.name, index)], UCJEPSUseOfCollectionsData::STAFF_NAME.name) end
  def staff_name_options(index); input_options_locator([fieldset(UCJEPSUseOfCollectionsData::STAFF_GRP.name, index)], UCJEPSUseOfCollectionsData::STAFF_NAME.name) end
  def staff_role_input(index); input_locator([fieldset(UCJEPSUseOfCollectionsData::STAFF_GRP.name, index)], UCJEPSUseOfCollectionsData::STAFF_ROLE.name) end
  def staff_role_options(index); input_options_locator([fieldset(UCJEPSUseOfCollectionsData::STAFF_GRP.name, index)], UCJEPSUseOfCollectionsData::STAFF_ROLE.name) end
  def staff_hours_spent_input(index); input_locator([fieldset(UCJEPSUseOfCollectionsData::STAFF_GRP.name, index)], UCJEPSUseOfCollectionsData::STAFF_HOURS_SPENT.name) end
  def staff_note_input(index); input_locator([fieldset(UCJEPSUseOfCollectionsData::STAFF_GRP.name, index)], UCJEPSUseOfCollectionsData::STAFF_NOTE.name) end

  def obligations_input; input_locator([], UCJEPSUseOfCollectionsData::OBLIGATIONS.name) end

  def location_input(index); input_locator([fieldset(UCJEPSUseOfCollectionsData::LOCATION_LIST.name, index)]) end
  def location_options(index); input_options_locator([fieldset(UCJEPSUseOfCollectionsData::LOCATION_LIST.name, index)]) end

  def fee_value_input(index); input_locator([fieldset(UCJEPSUseOfCollectionsData::FEE_GRP.name, index)], UCJEPSUseOfCollectionsData::FEE_VALUE.name) end
  def fee_currency_input(index); input_locator([fieldset(UCJEPSUseOfCollectionsData::FEE_GRP.name, index)], UCJEPSUseOfCollectionsData::FEE_CURRENCY.name) end
  def fee_currency_options(index); input_options_locator([fieldset(UCJEPSUseOfCollectionsData::FEE_GRP.name, index)], UCJEPSUseOfCollectionsData::FEE_CURRENCY.name) end
  def fee_note_input(index); input_locator([fieldset(UCJEPSUseOfCollectionsData::FEE_GRP.name, index)], UCJEPSUseOfCollectionsData::FEE_NOTE.name) end
  def fee_paid_input(index); input_locator([fieldset(UCJEPSUseOfCollectionsData::FEE_GRP.name, index)], UCJEPSUseOfCollectionsData::FEE_PAID.name) end

  # PROJECT ID

  # Selects the auto-generated project ID and returns it. If a test data set is given, inserts the ID.
  # @param [Hash] test_data
  # @return [String]
  def select_auto_project_id(test_data=nil)
    hide_notifications_bar
    id = select_id_generator_option(project_id_input, project_id_options)
    logger.info "Selected auto-generated project ID '#{id}'"
    test_data.merge!({UCJEPSUseOfCollectionsData::PROJECT_ID.name => id}) if test_data
    id
  end

  # Enters a project ID per a given set of test data
  # @param [Hash] test_data
  def enter_project_id(test_data)
    hide_notifications_bar
    logger.info "Entering project ID '#{test_data[UCJEPSUseOfCollectionsData::PROJECT_ID.name]}'"
    wait_for_options_and_type(project_id_input, project_id_options, test_data[UCJEPSUseOfCollectionsData::PROJECT_ID.name])
  end

  # Verifies a project ID matches test data
  # @param [Hash] test_data
  def verify_project_id(test_data)
    verify_values_match(test_data[UCJEPSUseOfCollectionsData::PROJECT_ID.name], element_value(project_id_input))
  end

  # COLLECTION TYPE

  # Selects collection types per a given set of test data
  # @param [Hash] test_data
  def select_collection_types(test_data)
    types = test_data[UCJEPSUseOfCollectionsData::COLLECTION_TYPE_LIST.name] || [{UCJEPSUseOfCollectionsData::COLLECTION_TYPE.name => ''}]
    hide_notifications_bar
    prep_fieldsets_for_test_data([fieldset(UCJEPSUseOfCollectionsData::COLLECTION_TYPE_LIST.name)], types)

    types.each_with_index do |type, index|
      logger.info "Entering collection type data set at index #{index}: #{type}"
      logger.debug "Hitting input at '#{collection_type_input(index)}'"
      wait_for_options_and_select(collection_type_input(index), collection_type_options(index), type[UCJEPSUseOfCollectionsData::COLLECTION_TYPE.name])
    end
  end

  # Verifies collection types match test data
  # @param [Hash] test_data
  def verify_collection_types(test_data)
    types = test_data[UCJEPSUseOfCollectionsData::COLLECTION_TYPE_LIST.name] || [{UCJEPSUseOfCollectionsData::COLLECTION_TYPE.name => ''}]
    types.each_with_index { |type, index| verify_values_match(type[UCJEPSUseOfCollectionsData::COLLECTION_TYPE.name], element_value(collection_type_input index)) }
  end

  # MATERIAL TYPE

  # Selects material types per a given set of test data
  # @param [Hash] test_data
  def select_material_types(test_data)
    types = test_data[UCJEPSUseOfCollectionsData::MATERIAL_TYPE_LIST.name] || [{UCJEPSUseOfCollectionsData::MATERIAL_TYPE.name => ''}]
    hide_notifications_bar
    prep_fieldsets_for_test_data([fieldset(UCJEPSUseOfCollectionsData::MATERIAL_TYPE_LIST.name)], types)

    types.each_with_index do |type, index|
      logger.info "Entering material type data set at index #{index}: #{type}"
      wait_for_options_and_select(material_type_input(index), material_type_options(index), type[UCJEPSUseOfCollectionsData::MATERIAL_TYPE.name])
    end
  end

  # Verifies material types match test data
  # @param [Hash] test_data
  def verify_material_types(test_data)
    types = test_data[UCJEPSUseOfCollectionsData::MATERIAL_TYPE_LIST.name] || [{UCJEPSUseOfCollectionsData::MATERIAL_TYPE.name => ''}]
    types.each_with_index { |type, index| verify_values_match(type[UCJEPSUseOfCollectionsData::MATERIAL_TYPE.name], element_value(material_type_input index)) }
  end

  # USERS

  # Enters users data per a given set of test data
  # @param [Hash] test_data
  def enter_users(test_data)
    users = test_data[UCJEPSUseOfCollectionsData::USER_GRP.name] || [UCJEPSUseOfCollectionsData.empty_user]
    hide_notifications_bar
    prep_fieldsets_for_test_data([fieldset(UCJEPSUseOfCollectionsData::USER_GRP.name)], users)

    users.each_with_index do |user, index|
      logger.info "Entering user data set at index #{index}: #{user}"
      enter_auto_complete(user_name_input(index), user_name_options(index), user[UCJEPSUseOfCollectionsData::USER.name], 'Default Persons')
      wait_for_options_and_select(user_type_input(index), user_type_options(index), user[UCJEPSUseOfCollectionsData::USER_TYPE.name])
      wait_for_options_and_select(user_role_input(index), user_role_options(index), user[UCJEPSUseOfCollectionsData::USER_ROLE.name])
      enter_auto_complete(user_institution_input(index), user_institution_options(index), user[UCJEPSUseOfCollectionsData::USER_INSTITUTION.name], 'Institution Organizations')
    end
  end

  # Verifies that the users data matches test data
  # @param [Hash] test_data
  def verify_users(test_data)
    users = test_data[UCJEPSUseOfCollectionsData::USER_GRP.name] || [UCJEPSUseOfCollectionsData.empty_user]
    users.each_with_index do |user, index|
      verify_values_match(user[UCJEPSUseOfCollectionsData::USER.name], element_value(user_name_input index))
      verify_values_match(user[UCJEPSUseOfCollectionsData::USER_TYPE.name], element_value(user_type_input index))
      verify_values_match(user[UCJEPSUseOfCollectionsData::USER_ROLE.name], element_value(user_role_input index))
      verify_values_match(user[UCJEPSUseOfCollectionsData::USER_INSTITUTION.name], element_value(user_institution_input index))
    end
  end

  # DATE REQUESTED

  # Enters date requested per a given set of test data
  # @param [Hash] test_data
  def enter_date_requested(test_data)
    hide_notifications_bar
    logger.info "Entering date requested '#{test_data[UCJEPSUseOfCollectionsData::DATE_REQUESTED.name]}'"
    wait_for_element_and_type(date_requested_input, test_data[UCJEPSUseOfCollectionsData::DATE_REQUESTED.name])
    hit_enter
  end

  # Verifies date requested matches test data
  # @param [Hash] test_data
  def verify_date_requested(test_data)
    verify_values_match(test_data[UCJEPSUseOfCollectionsData::DATE_REQUESTED.name], element_value(date_requested_input))
  end

  # DATE COMPLETED

  # Enters date completed per a given set of test data
  # @param [Hash] test_data
  def enter_date_completed(test_data)
    hide_notifications_bar
    logger.info "Entering date completed '#{test_data[UCJEPSUseOfCollectionsData::DATE_COMPLETED.name]}'"
    wait_for_element_and_type(date_completed_input, test_data[UCJEPSUseOfCollectionsData::DATE_COMPLETED.name])
    hit_enter
  end

  # Verifies date completed matches test data
  # @param [Hash] test_data
  def verify_date_completed(test_data)
    verify_values_match(test_data[UCJEPSUseOfCollectionsData::DATE_COMPLETED.name], element_value(date_completed_input))
  end

  # OCCASIONS

  # Enters occasions per a given set of test data
  # @param [Hash] test_data
  def enter_occasions(test_data)
    occasions = test_data[UCJEPSUseOfCollectionsData::OCCASION_LIST.name] || [{UCJEPSUseOfCollectionsData::OCCASION.name => ''}]
    hide_notifications_bar
    prep_fieldsets_for_test_data([fieldset(UCJEPSUseOfCollectionsData::OCCASION_LIST.name)], occasions)
    occasions.each_with_index do |occasion, index|
      logger.info "Entering occasion data set at index #{index}: #{occasion}"
      enter_auto_complete(occasion_input(index), occasion_options(index), occasion[UCJEPSUseOfCollectionsData::OCCASION.name], 'Label Texts')
    end
  end

  # Verifies occasions match test data
  # @param [Hash] test_data
  def verify_occasions(test_data)
    occasions = test_data[UCJEPSUseOfCollectionsData::OCCASION_LIST.name] || [{UCJEPSUseOfCollectionsData::OCCASION.name => ''}]
    occasions.each_with_index { |occasion, index| verify_values_match(occasion[UCJEPSUseOfCollectionsData::OCCASION.name], element_value(occasion_input index)) }
  end

  # PROJECT DESCRIPTION

  # Enters project description per a given set of test data
  # @param [Hash] test_data
  def enter_project_desc(test_data)
    hide_notifications_bar
    logger.info "Entering project description '#{test_data[UCJEPSUseOfCollectionsData::PROJECT_DESC.name]}'"
    wait_for_element_and_type(project_desc_text_area, test_data[UCJEPSUseOfCollectionsData::PROJECT_DESC.name])
  end

  # Verifies project description matches test data
  # @param [Hash] test_data
  def verify_project_desc(test_data)
    verify_values_match(test_data[UCJEPSUseOfCollectionsData::PROJECT_DESC.name], element_value(project_desc_text_area))
  end

  # AUTHORIZATIONS

  # Enters authorizations per a given set of test data
  # @param [Hash] test_data
  def enter_authorizations(test_data)
    authorizations = test_data[UCJEPSUseOfCollectionsData::AUTHORIZATION_GRP.name] || [UCJEPSUseOfCollectionsData.empty_authorization]
    hide_notifications_bar
    prep_fieldsets_for_test_data([fieldset(UCJEPSUseOfCollectionsData::AUTHORIZATION_GRP.name)], authorizations)
    authorizations.each_with_index do |auth, index|
      logger.info "Entering authorization data set at index #{index}: #{auth}"
      enter_auto_complete(authorized_by_input(index), authorized_by_options(index), auth[UCJEPSUseOfCollectionsData::AUTHORIZED_BY.name], 'Default Persons')
      wait_for_element_and_type(authorization_date_input(index), auth[UCJEPSUseOfCollectionsData::AUTHORIZATION_DATE.name])
      hit_enter
      wait_for_element_and_type(authorization_note_input(index), auth[UCJEPSUseOfCollectionsData::AUTHORIZATION_NOTE.name])
      wait_for_options_and_select(authorization_status_input(index), authorization_status_options(index), auth[UCJEPSUseOfCollectionsData::AUTHORIZATION_STATUS.name])
    end
  end

  # Verifies authorizations match test data
  # @param [Hash] test_data
  def verify_authorizations(test_data)
    authorizations = test_data[UCJEPSUseOfCollectionsData::AUTHORIZATION_GRP.name] || [UCJEPSUseOfCollectionsData.empty_authorization]
    authorizations.each_with_index do |auth, index|
      verify_values_match(auth[UCJEPSUseOfCollectionsData::AUTHORIZED_BY.name], element_value(authorized_by_input index))
      verify_values_match(auth[UCJEPSUseOfCollectionsData::AUTHORIZATION_DATE.name], element_value(authorization_date_input index))
      verify_values_match(auth[UCJEPSUseOfCollectionsData::AUTHORIZATION_NOTE.name], element_value(authorization_note_input index))
      verify_values_match(auth[UCJEPSUseOfCollectionsData::AUTHORIZATION_STATUS.name], element_value(authorization_status_input index))
    end
  end

  # USE DATES

  # Enters use dates per a given set of test data
  # @param [Hash] test_data
  def enter_use_dates(test_data)
    dates = test_data[UCJEPSUseOfCollectionsData::USE_DATE_GRP.name] || [UCJEPSUseOfCollectionsData.empty_use_date]
    hide_notifications_bar
    prep_fieldsets_for_test_data([fieldset(UCJEPSUseOfCollectionsData::USE_DATE_GRP.name)], dates)
    dates.each_with_index do |date, index|
      logger.info "Entering use date data set at index #{index}: #{date}"
      wait_for_element_and_type(use_date_input(index), date[UCJEPSUseOfCollectionsData::USE_DATE.name])
      hit_enter
      wait_for_element_and_type(use_num_visitors_input(index), date[UCJEPSUseOfCollectionsData::USE_DATE_NUM_VISITORS.name])
      wait_for_element_and_type(use_hours_spent_input(index), date[UCJEPSUseOfCollectionsData::USE_DATE_HOURS_SPENT.name])
      wait_for_element_and_type(use_note_input(index), date[UCJEPSUseOfCollectionsData::USE_DATE_VISITOR_NOTE.name])
    end
  end

  # Verifies use dates match test data
  # @param [Hash] test_data
  def verify_use_dates(test_data)
    dates = test_data[UCJEPSUseOfCollectionsData::USE_DATE_GRP.name] || [UCJEPSUseOfCollectionsData.empty_use_date]
    dates.each_with_index do |date, index|
      verify_values_match(date[UCJEPSUseOfCollectionsData::USE_DATE.name], element_value(use_date_input index))
      verify_values_match(date[UCJEPSUseOfCollectionsData::USE_DATE_NUM_VISITORS.name], element_value(use_num_visitors_input index))
      verify_values_match(date[UCJEPSUseOfCollectionsData::USE_DATE_HOURS_SPENT.name], element_value(use_hours_spent_input index))
      verify_values_match(date[UCJEPSUseOfCollectionsData::USE_DATE_VISITOR_NOTE.name], element_value(use_note_input index))
    end
  end

  # STAFF

  # Enters staff per a given set of test data
  # @param [Hash] test_data
  def enter_staff(test_data)
    staff = test_data[UCJEPSUseOfCollectionsData::STAFF_GRP.name] || [UCJEPSUseOfCollectionsData.empty_staff]
    hide_notifications_bar
    prep_fieldsets_for_test_data([fieldset(UCJEPSUseOfCollectionsData::STAFF_GRP.name)], staff)
    staff.each_with_index do |staf, index|
      logger.info "Entering staff data set at index #{index}: #{staf}"
      enter_auto_complete(staff_name_input(index), staff_name_options(index), staf[UCJEPSUseOfCollectionsData::STAFF_NAME.name], 'Default Persons')
      wait_for_options_and_select(staff_role_input(index), staff_role_options(index), staf[UCJEPSUseOfCollectionsData::STAFF_ROLE.name])
      wait_for_element_and_type(staff_hours_spent_input(index), staf[UCJEPSUseOfCollectionsData::STAFF_HOURS_SPENT.name])
      wait_for_element_and_type(staff_note_input(index), staf[UCJEPSUseOfCollectionsData::STAFF_NOTE.name])
    end
  end

  # Verifies staff match test data
  # @param [Hash] test_data
  def verify_staff(test_data)
    staff = test_data[UCJEPSUseOfCollectionsData::STAFF_GRP.name] || [UCJEPSUseOfCollectionsData.empty_staff]
    staff.each_with_index do |staf, index|
      verify_values_match(staf[UCJEPSUseOfCollectionsData::STAFF_NAME.name], element_value(staff_name_input index))
      verify_values_match(staf[UCJEPSUseOfCollectionsData::STAFF_ROLE.name], element_value(staff_role_input index))
      verify_values_match(staf[UCJEPSUseOfCollectionsData::STAFF_HOURS_SPENT.name], element_value(staff_hours_spent_input index))
      verify_values_match(staf[UCJEPSUseOfCollectionsData::STAFF_NOTE.name], element_value(staff_note_input index))
    end
  end

  # LOCATIONS

  # Enters locations per a given set of test data
  # @param [Hash] test_data
  def enter_locations(test_data)
    locations = test_data[UCJEPSUseOfCollectionsData::LOCATION_LIST.name] || [{UCJEPSUseOfCollectionsData::LOCATION.name => ''}]
    hide_notifications_bar
    prep_fieldsets_for_test_data([fieldset(UCJEPSUseOfCollectionsData::LOCATION_LIST.name)], locations)
    locations.each_with_index do |location, index|
      logger.info "Entering location data set at index #{index}: #{location}"
      enter_auto_complete(location_input(index), location_options(index), location[UCJEPSUseOfCollectionsData::LOCATION.name], 'Default Places')
    end
  end

  # Verifies locations match a given set of test data
  # @param [Hash] test_data
  def verify_locations(test_data)
    locations = test_data[UCJEPSUseOfCollectionsData::LOCATION_LIST.name] || [{UCJEPSUseOfCollectionsData::LOCATION.name => ''}]
    locations.each_with_index { |location, index| verify_values_match(location[UCJEPSUseOfCollectionsData::LOCATION.name], element_value(location_input index)) }
  end

  # OBLIGATIONS

  # Clicks the obligations fulfilled checkbox, though it knows nothing about whether it is checking or un-checking
  def click_obligations_fulfilled
    wait_for_element_and_click obligations_input
  end

  # FEE

  # Enters fees per a given set of test data
  # @param [Hash] test_data
  def enter_fees(test_data)
    fees = test_data[UCJEPSUseOfCollectionsData::FEE_GRP.name] || [UCJEPSUseOfCollectionsData.empty_fee]
    hide_notifications_bar
    prep_fieldsets_for_test_data([fieldset(UCJEPSUseOfCollectionsData::FEE_GRP.name)], fees)
    fees.each_with_index do |fee, index|
      logger.info "Entering fee data set at index #{index}: #{fee}"
      wait_for_options_and_select(fee_currency_input(index), fee_currency_options(index), fee[UCJEPSUseOfCollectionsData::FEE_CURRENCY.name])
      wait_for_element_and_type(fee_value_input(index), fee[UCJEPSUseOfCollectionsData::FEE_VALUE.name])
      wait_for_element_and_type(fee_note_input(index), fee[UCJEPSUseOfCollectionsData::FEE_NOTE.name])
      wait_for_element_and_click(fee_paid_input(index)) if fee[UCJEPSUseOfCollectionsData::FEE_PAID.name]
    end
  end

  # Verifies fees match test data
  # @param [Hash] test_data
  def verify_fees(test_data)
    fees = test_data[UCJEPSUseOfCollectionsData::FEE_GRP.name] || [UCJEPSUseOfCollectionsData.empty_fee]
    fees.each_with_index do |fee, index|
      verify_values_match(fee[UCJEPSUseOfCollectionsData::FEE_CURRENCY.name], element_value(fee_currency_input index))
      verify_values_match(fee[UCJEPSUseOfCollectionsData::FEE_VALUE.name], element_value(fee_value_input index))
      verify_values_match(fee[UCJEPSUseOfCollectionsData::FEE_NOTE.name], element_value(fee_note_input index))
    end
  end

end
