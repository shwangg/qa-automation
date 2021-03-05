class CitationPage < AuthorityPage

  include Logging
  include Page
  include CollectionSpacePages

  def citation_display_name_input(index); input_locator([fieldset(CoreCitationData::CITATION_TERMS.name, index)], CoreCitationData::TERM_DISPLAY_NAME.name) end
  def citation_display_name_add_btn; add_button_locator([fieldset(CoreCitationData::CITATION_TERMS.name)]) end

  def enter_citation_display_name(name, index)
    logger.debug "Entering display name '#{name}'"
    wait_for_element_and_type(citation_display_name_input(index), name)
  end

  def verify_citation_display_name(name, index)
    wait_until(Config.short_wait, "Expected display name '#{name}', but got '#{element_value(citation_display_name_input index)}'") do
      text_values_match?(name, element_value(citation_display_name_input index))
    end
  end

end
