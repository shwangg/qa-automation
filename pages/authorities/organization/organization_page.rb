class OrganizationPage < AuthorityPage

  include Logging
  include Page
  include CollectionSpacePages
  include CoreOrganizationInfoForm

  def org_display_name_input(index); input_locator([fieldset(CoreOrgData::ORG_TERM_GRP.name, index)], CoreOrgData::TERM_DISPLAY_NAME.name) end
  def org_display_name_add_btn; add_button_locator([fieldset(CoreOrgData::ORG_TERM_GRP.name, index)]) end

  # Enters a display name in the org info term fieldset at a given index
  # @param [String] name
  # @param [Integer] index
  def enter_org_display_name(name, index)
    logger.debug "Entering display name '#{name}'"
    wait_for_element_and_type(org_display_name_input(index), name)
  end

  # Verifies that the display name in the org info term fieldset at a given index matches a given value
  # @param [String] name
  # @param [Integer] index
  def verify_display_name(name, index)
    wait_until(Config.short_wait, "Expected display name '#{name}', but got '#{element_value(org_display_name_input index)}'") do
      text_values_match?(name, element_value(org_display_name_input index))
    end
  end

  def enter_number_and_text(data)
    enter_org_display_name(data[CoreOrgData::TERM_DISPLAY_NAME.name], 0)
  end

  def enter_number(data)
    enter_org_display_name(data[CoreOrgData::TERM_DISPLAY_NAME.name], 0)
  end

end
