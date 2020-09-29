module PAHMAUseOfCollectionsInfoForm

  include CoreUCBUseOfCollectionsInfoForm

  DEPLOYMENT = Deployment::PAHMA

  def enter_reference_nbr(test_data)
    hide_notifications_bar
    logger.info "Entering reference number '#{test_data[CoreUseOfCollectionsData::REFERENCE_NBR.name]}'"
    wait_for_element_and_type(reference_nbr_input, test_data[CoreUseOfCollectionsData::REFERENCE_NBR.name])
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
      enter_auto_complete(user_name_input(index), user_name_options(index), user[CoreUseOfCollectionsData::USER.name], 'PAHMA Persons')
      wait_for_options_and_select(user_type_input(index), user_type_options(index), user[CoreUseOfCollectionsData::USER_INSTITUTION_ROLE.name])
      wait_for_options_and_select(user_role_input(index), user_role_options(index), user[CoreUseOfCollectionsData::USER_UOC_ROLE.name])
      enter_auto_complete(user_institution_input(index), user_institution_options(index), user[CoreUseOfCollectionsData::USER_INSTITUTION.name], 'PAHMA Organizations')
    end
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

  # AUTHORIZATIONS

  # Enters authorizations per a given set of test data
  # @param [Hash] test_data
  def enter_authorizations(test_data)
    authorizations = test_data[CoreUseOfCollectionsData::AUTHORIZATION_GRP.name] || [CoreUseOfCollectionsData.empty_authorization]
    hide_notifications_bar
    prep_fieldsets_for_test_data([fieldset(CoreUseOfCollectionsData::AUTHORIZATION_GRP.name)], authorizations)
    authorizations.each_with_index do |auth, index|
      logger.info "Entering authorization data set at index #{index}: #{auth}"
      enter_auto_complete(authorized_by_input(index), authorized_by_options(index), auth[CoreUseOfCollectionsData::AUTHORIZED_BY.name], 'PAHMA Persons')
      wait_for_element_and_type(authorization_date_input(index), auth[CoreUseOfCollectionsData::AUTHORIZATION_DATE.name])
      hit_enter
      wait_for_element_and_type(authorization_note_input(index), auth[CoreUseOfCollectionsData::AUTHORIZATION_NOTE.name])
      wait_for_options_and_select(authorization_status_input(index), authorization_status_options(index), auth[CoreUseOfCollectionsData::AUTHORIZATION_STATUS.name])
    end
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
      enter_auto_complete(staff_name_input(index), staff_name_options(index), staf[CoreUseOfCollectionsData::STAFF_NAME.name], 'PAHMA Persons')
      wait_for_options_and_select(staff_role_input(index), staff_role_options(index), staf[CoreUseOfCollectionsData::STAFF_ROLE.name])
      wait_for_element_and_type(staff_hours_spent_input(index), staf[CoreUseOfCollectionsData::STAFF_HOURS_SPENT.name])
      wait_for_element_and_type(staff_note_input(index), staf[CoreUseOfCollectionsData::STAFF_NOTE.name])
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
      enter_auto_complete(location_input(index), location_options(index), location[CoreUseOfCollectionsData::LOCATION.name], 'PAHMA Places')
    end
  end

end
