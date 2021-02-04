class PAHMAOrganizationPage < CoreUCBOrganizationPage

  include PAHMAOrganizationInfoForm

  DEPLOYMENT = Deployment::PAHMA

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
      enter_auto_complete(contact_name_input(index), contact_name_options(index), test_name[CoreOrgData::CONTACT_NAME.name], 'PAHMA Persons')
    end
  end

end
