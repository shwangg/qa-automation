require_relative '../../../spec_helper'

module UCJEPSUseOfCollectionsInfoForm

  include Logging
  include Page
  include CollectionSpacePages

  @data = UCJEPSUseOfCollectionsData.new

  def project_id_input; input_locator([], @data::PROJECT_ID.name) end
  def project_id_options; input_options_locator([], @data::PROJECT_ID.name) end

  def collection_type_input(index); input_locator([fieldset(@data::COLLECTION_TYPE_LIST.name, index)], @data::COLLECTION_TYPE.name) end
  def collection_type_options(index); input_options_locator([fieldset(@data::COLLECTION_TYPE_LIST.name, index)], @data::COLLECTION_TYPE.name) end

  def material_type_input(index); input_locator([fieldset(@data::MATERIAL_TYPE_LIST.name, index)], @data::MATERIAL_TYPE.name) end
  def material_type_options(index); input_options_locator([fieldset(@data::MATERIAL_TYPE_LIST.name, index)], @data::MATERIAL_TYPE.name) end

  def user_role_input(index); input_locator([fieldset(@data::USER_GRP.name, index)], @data::USER_ROLE.name) end
  def user_role_options(index); input_options_locator([fieldset(@data::USER_GRP.name, index)], @data::USER_ROLE.name) end
  def user_institution_input(index); input_locator([fieldset(@data::USER_GRP.name, index)], @data::USER_INSTITUTION.name) end
  def user_institution_options(index); input_options_locator([fieldset(@data::USER_GRP.name, index)], @data::USER_INSTITUTION.name) end

  def date_requested_input; input_locator([], @data::DATE_REQUESTED.name) end
  def date_completed_input; input_locator([], @data::DATE_COMPLETED.name) end

  def occasion_input(index); input_locator([fieldset(@data::OCCASION_LIST.name, index)], @data::OCCASION.name) end

  def project_desc_text_area; text_area_locator([], @data::PROJECT_DESC.name) end

  def link_to_contract_input; input_locator([], @data::LINK_TO_CONTRACT.name) end

  def authorized_by_input(index); input_locator([fieldset(@data::AUTHORIZATION_GRP.name, index)], @data::AUTHORIZED_BY.name) end
  def authorized_by_options(index); input_options_locator([fieldset(@data::AUTHORIZATION_GRP.name, index)], @data::AUTHORIZED_BY.name) end
  def authorization_date_input(index); input_locator([fieldset(@data::AUTHORIZATION_GRP.name, index)], @data::AUTHORIZATION_DATE.name) end
  def authorization_note_input(index); input_locator([fieldset(@data::AUTHORIZATION_GRP.name, index)], @data::AUTHORIZATION_NOTE.name) end
  def authorization_status_input(index); input_locator([fieldset(@data::AUTHORIZATION_GRP.name, index)], @data::AUTHORIZATION_STATUS.name) end
  def authorization_status_options(index); input_options_locator([fieldset(@data::AUTHORIZATION_GRP.name, index)], @data::AUTHORIZATION_STATUS.name) end

  def use_date_input(index); input_locator([fieldset(@data::USE_DATE_GRP.name, index)], @data::USE_DATE.name) end
  def use_num_visitors_input(index); input_locator([fieldset(@data::USE_DATE_GRP.name, index)], @data::USE_DATE_NUM_VISITORS.name) end
  def use_hours_spent_input(index); input_locator([fieldset(@data::USE_DATE_GRP.name, index)], @data::USE_DATE_HOURS_SPENT.name) end
  def use_note_input(index); input_locator([fieldset(@data::USE_DATE_GRP.name, index)], @data::USE_DATE_VISITOR_NOTE.name) end

  def staff_name_input(index); input_locator([fieldset(@data::STAFF_GRP.name, index)], @data::STAFF_NAME.name) end
  def staff_name_options(index); input_options_locator([fieldset(@data::STAFF_GRP.name, index)], @data::STAFF_NAME.name) end
  def staff_role_input(index); input_locator([fieldset(@data::STAFF_GRP.name, index)], @data::STAFF_ROLE.name) end
  def staff_role_options(index); input_options_locator([fieldset(@data::STAFF_GRP.name, index)], @data::STAFF_ROLE.name) end
  def staff_hours_spent_input(index); input_locator([fieldset(@data::STAFF_GRP.name, index)], @data::STAFF_HOURS_SPENT.name) end
  def staff_note_input(index); input_locator([fieldset(@data::STAFF_GRP.name, index)], @data::STAFF_NOTE.name) end

  def obligations_input; input_locator([], @data::OBLIGATIONS.name) end

  def location_input(index); input_locator([fieldset(@data::LOCATION_LIST.name, index)], @data::LOCATION.name) end
  def location_options(index); input_options_locator([fieldset(@data::LOCATION_LIST.name, index)], @data::LOCATION.name) end

  def fee_amount_input; input_locator([], @data::FEE_AMOUNT.name) end
  def fee_note_input; input_locator([], @data::FEE_NOTE.name) end
  def fee_paid_input; input_locator([], @data::FEE_PAID.name) end

  # PROJECT ID

  def select_auto_project_id(test_data)
    hide_notifications_bar
    id = select_id_generator_option(project_id_input, project_id_options)
    logger.info "Selected auto-generated project ID '#{id}'"
    test_data.merge!({@data::PROJECT_ID.name => id})
  end

  def enter_project_id(test_data)
    hide_notifications_bar
    logger.info "Entering project ID '#{test_data[@data::PROJECT_ID.name]}'"
    wait_for_options_and_type(project_id_input, project_id_options, test_data[@data::PROJECT_ID.name])
  end

  def verify_project_id(test_data)
    verify_values_match(test_data[@data::PROJECT_ID.name], element_value(project_id_input))
  end

  # COLLECTION TYPE

  def enter_collection_types(test_data)
    types = test_data[@data::COLLECTION_TYPE_LIST.name] || [{@data::COLLECTION_TYPE.name => ''}]
    hide_notifications_bar
    prep_fieldsets_for_test_data([fieldset(@data::COLLECTION_TYPE_LIST.name)], types)

    types.each_with_index do |type, index|
      logger.info "Entering collection type data set at index #{index}: #{type}"
      wait_for_options_and_select(collection_type_input(index), collection_type_options(index), type)
    end
  end

  def verify_collection_types(test_data)
    types = test_data[@data::COLLECTION_TYPE_LIST.name] || [{@data::COLLECTION_TYPE.name => ''}]
    types.each_with_index { |type, index| verify_values_match(type[@data::COLLECTION_TYPE.name], element_value(collection_type_input index)) }
  end

  # MATERIAL TYPE

  def enter_material_types(test_data)
    types = test_data[@data::MATERIAL_TYPE_LIST.name] || [{@data::MATERIAL_TYPE.name => ''}]
    hide_notifications_bar
    prep_fieldsets_for_test_data([fieldset(@data::MATERIAL_TYPE_LIST.name)], types)

    types.each_with_index do |type, index|
      logger.info "Entering material type data set at index #{index}: #{type}"
      wait_for_options_and_select(material_type_input(index), material_type_options(index), type)
    end
  end

  def verify_material_types(test_data)
    types = test_data[@data::MATERIAL_TYPE_LIST.name] || [{@data::MATERIAL_TYPE.name => ''}]
    types.each_with_index { |type, index| verify_values_match(type[@data::MATERIAL_TYPE.name], element_value(material_type_input index)) }
  end

  # USERS

  # Enters users data per a given set of test data
  # @param [Hash] test_data
  def enter_users(test_data)
    users = test_data[@data::USER_GRP.name] || [@data.empty_user]
    hide_notifications_bar
    prep_fieldsets_for_test_data([fieldset(@data::USER_GRP.name)], users)

    users.each_with_index do |user, index|
      logger.info "Entering user data set at index #{index}: #{user}"
      enter_auto_complete(user_name_input(index), user_name_options(index), user[@data::USER.name], 'Local Persons')
      wait_for_options_and_select(user_type_input(index), user_type_options(index), user[@data::USER_TYPE.name])
      wait_for_options_and_select(user_role_input(index), user_role_options(index), user[@data::USER_ROLE.name])
      enter_auto_complete(user_institution_input(index), user_institution_options(index), user[@data::USER_INSTITUTION.name], 'All Organizations')
    end
  end

  # Verifies that the users data matches test data
  # @param [Hash] test_data
  def verify_users(test_data)
    users = test_data[@data::USER_GRP.name] || [@data.empty_user]
    users.each_with_index do |user, index|
      verify_values_match(user[@data::USER.name], element_value(user_name_input index))
      verify_values_match(user[@data::USER_TYPE.name], element_value(user_type_input index))
      verify_values_match(user[@data::USER_ROLE.name], element_value(user_role_input index))
      verify_values_match(user[@data::USER_INSTITUTION.name], element_value(user_institution_input index))
    end
  end

  # DATE REQUESTED

  def enter_date_requested(test_data)
    hide_notifications_bar
    logger.info "Entering date requested '#{test_data[@data::DATE_REQUESTED.name]}'"
    wait_for_element_and_type(date_requested_input, test_data[@data::DATE_REQUESTED.name])
    hit_enter
  end

  def verify_date_requested(test_data)
    verify_values_match(test_data[@data::DATE_REQUESTED.name], element_value(date_requested_input))
  end

  # DATE COMPLETED

  def enter_date_completed(test_data)
    hide_notifications_bar
    logger.info "Entering date completed '#{test_data[@data::DATE_COMPLETED.name]}'"
    wait_for_element_and_type(date_completed_input, test_data[@data::DATE_COMPLETED.name])
    hit_enter
  end

  def verify_date_completed(test_data)
    verify_values_match(test_data[@data::DATE_COMPLETED.name], element_value(date_completed_input))
  end

  # OCCASIONS

  def enter_occasions(test_data)
    occasions = test_data[@data::OCCASION_LIST.name] || [{@data::OCCASION.name => ''}]
    hide_notifications_bar
    prep_fieldsets_for_test_data([fieldset(@data::OCCASION_LIST.name)], occasions)
    occasions.each_with_index do |occasion, index|
      logger.info "Entering occasion data set at index #{index}: #{occasion}"
      wait_for_element_and_type(occasion_input(index), occasion[@data::OCCASION.name])
    end
  end

  def verify_occasions(test_data)
    occasions = test_data[@data::OCCASION_LIST.name] || [{@data::OCCASION.name => ''}]
    occasions.each_with_index { |occasion, index| verify_values_match(occasion[@data::OCCASION.name], element_value(occasion_input index)) }
  end

  # PROJECT DESCRIPTION

  def enter_project_desc(test_data)
    hide_notifications_bar
    logger.info "Entering project description '#{test_data[@data::PROJECT_DESC.name]}'"
    wait_for_element_and_type(project_desc_text_area, test_data[@data::PROJECT_DESC.name])
  end

  def verify_project_desc(test_data)
    verify_values_match(test_data[@data::PROJECT_DESC.name], element_value(project_desc_text_area))
  end

  # LINK TO CONTRACT

  def enter_link_to_contract(test_data)
    hide_notifications_bar
    logger.info "Entering link to contract '#{test_data[@data::LINK_TO_CONTRACT.name]}'"
    wait_for_element_and_type(link_to_contract_input, test_data[@data::LINK_TO_CONTRACT.name])
  end

  def verify_link_to_contract(test_data)
    verify_values_match(test_data[@data::LINK_TO_CONTRACT.name], element_value(link_to_contract_input))
  end

  # AUTHORIZATIONS

  def enter_authorizations(test_data)
    authorizations = test_data[@data::AUTHORIZATION_GRP.name] || @data.empty_authorization
    hide_notifications_bar
    prep_fieldsets_for_test_data([fieldset(@data::AUTHORIZATION_GRP.name)], authorizations)
    authorizations.each_with_index do |auth, index|
      logger.info "Entering authorization data set at index #{index}: #{auth}"
      enter_auto_complete(authorized_by_input(index), authorized_by_options(index), auth[@data::AUTHORIZED_BY.name], 'Default Persons')
      wait_for_element_and_type(authorization_date_input(index), auth[@data::AUTHORIZATION_DATE.name])
      hit_enter
      wait_for_element_and_type(authorization_note_input(index), auth[@data::AUTHORIZATION_NOTE.name])
      wait_for_options_and_select(authorization_status_input(index), authorization_status_options(index), auth[@data::AUTHORIZATION_STATUS.name])
    end
  end

  def verify_authorizations(test_data)
    authorizations = test_data[@data::AUTHORIZATION_GRP.name] || @data.empty_authorization
    authorizations.each_with_index do |auth, index|
      verify_values_match(auth[@data::AUTHORIZED_BY.name], authorized_by_input(index))
      verify_values_match(auth[@data::AUTHORIZATION_DATE.name], authorization_date_input(index))
      verify_values_match(auth[@data::AUTHORIZATION_NOTE.name], authorization_note_input(index))
      verify_values_match(auth[@data::AUTHORIZATION_STATUS.name], authorization_status_input(index))
    end
  end

  # STAFF

  def enter_staff(test_data)
    staff = test_data[@data::STAFF_GRP.name] || @data.empty_staff
    hide_notifications_bar
    prep_fieldsets_for_test_data([fieldset(@data::STAFF_GRP.name)], staff)
    staff.each_with_index do |staf, index|
      logger.info "Entering staff data set at index #{index}: #{staf}"
      enter_auto_complete(staff_name_input(index), staff_name_options(index), staf[@data::STAFF_NAME.name], 'Default Persons')
      wait_for_options_and_select(staff_role_input(index), staff_role_options(index), staf[@data::STAFF_ROLE.name])
      wait_for_element_and_type(staff_hours_spent_input(index), staf[@data::STAFF_HOURS_SPENT.name])
      wait_for_element_and_type(staff_note_input(index), staf[@data::STAFF_NOTE.name])
    end
  end

  def verify_staff(test_data)
    staff = test_data[@data::STAFF_GRP.name] || @data.empty_staff
    staff.each_with_index do |staf, index|
      verify_values_match(staf[@data::STAFF_NAME.name], element_value(staff_name_input index))
      verify_values_match(staf[@data::STAFF_ROLE.name], element_value(staff_role_input index))
      verify_values_match(staf[@data::STAFF_HOURS_SPENT.name], element_value(staff_hours_spent_input index))
      verify_values_match(staf[@data::STAFF_NOTE.name], element_value(staff_note_input index))
    end
  end

  # LOCATIONS

  def enter_locations(test_data)
    locations = test_data[@data::LOCATION_LIST.name] || [{@data::LOCATION.name => ''}]
    hide_notifications_bar
    prep_fieldsets_for_test_data([fieldset(@data::LOCATION_LIST.name)], locations)
    locations.each_with_index do |location, index|
      logger.info "Entering location data set at index #{index}: #{location}"
      enter_auto_complete(location_input(index), location_options(index), location[@data::LOCATION.name], 'Default Places')
    end
  end

  def verify_locations(test_data)
    locations = test_data[@data::LOCATION_LIST.name] || [{@data::LOCATION.name => ''}]
    locations.each_with_index { |location, index| verify_values_match(location[@data::LOCATION.name], element_value(location_input index)) }
  end

  # OBLIGATIONS

  def click_obligation_fulfilled
    wait_for_element_and_click obligations_input
  end

  # FEE

  def enter_fee_amount(test_data)
    logger.info "Entering fee charged '#{test_data[@data::FEE_AMOUNT.name]}'"
    wait_for_element_and_type(fee_amount_input, test_data[@data::FEE_AMOUNT.name])
  end

  def enter_fee_note(test_data)
    logger.info "Entering fee note '#{test_data[@data::FEE_NOTE.name]}'"
    wait_for_element_and_type(fee_note_input, test_data[@data::FEE_NOTE.name])
  end

  def verify_fee_amount(test_data)
    verify_values_match(test_data[@data::FEE_AMOUNT.name], element_value(fee_amount_input))
  end

  def verify_fee_note(test_data)
    verify_values_match(test_data[@data::FEE_NOTE.name], element_value(fee_note_input))
  end

  def click_fee_paid
    wait_for_element_and_click fee_paid_input
  end

end
