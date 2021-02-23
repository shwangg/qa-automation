module CoreSearchOrganizationsForm

  include Logging
  include Page
  include CollectionSpacePages

  def display_name_input(index); input_locator([fieldset(CoreAuthorityData::TERM_DISPLAY_NAME.name, index)]) end
  def display_name_add_btn; add_button_locator([fieldset(CoreAuthorityData::TERM_DISPLAY_NAME.name)]) end

  def enter_display_names(names)
    names.each_with_index do |name, index|
      logger.debug "Entering display name '#{name}' at index #{index}"
      wait_for_element_and_click display_name_add_btn unless index.zero?
      wait_for_element_and_type(display_name_input(index), name)
    end
  end

end
