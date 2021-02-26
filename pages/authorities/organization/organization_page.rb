class OrganizationPage < AuthorityPage

  include Logging
  include Page
  include CollectionSpacePages
  include CoreOrganizationInfoForm

  def display_name_input(index); input_locator([fieldset(CoreOrgData::ORG_TERM_GRP.name, index)], CoreOrgData::TERM_DISPLAY_NAME.name) end
  def display_name_add_btn; add_button_locator([fieldset(CoreOrgData::ORG_TERM_GRP.name, index)]) end

  # Enters a display name in the org info term fieldset at a given index
  # @param [String] name
  # @param [Integer] index
  def enter_display_name(name, index)
    logger.debug "Entering display name '#{name}'"
    wait_for_element_and_type(display_name_input(index), name)
  end

  # def enter_term_name(name, index)
  #   logger.debug "Entering term name '#{name}'"
  #   wait_for_element_and_type(term_name_input([fieldset(CoreOrgData::ORG_TERM_GRP.name, index)]), name)
  # end

  # Verifies that the display name in the org info term fieldset at a given index matches a given value
  # @param [String] name
  # @param [Integer] index
  def verify_display_name(name, index)
    wait_until(Config.short_wait, "Expected display name '#{name}', but got '#{element_value(display_name_input index)}'") do
      text_values_match?(name, element_value(display_name_input index))
    end
  end

  def enter_number_and_text(data)
    enter_display_name(data[CoreOrgData::TERM_DISPLAY_NAME.name], 0)
    enter_
  end

  def enter_number(data)
    enter_display_name(data[CoreOrgData::TERM_DISPLAY_NAME.name], 0)
  end

end
