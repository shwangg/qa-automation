class TaxonPage < CoreAuthorityPage

  include CollectionSpacePages

  def formatted_display_name; rich_text_input_locator_by_label(CollectionSpaceData::FORMATTED_DISPLAY_NAME.label) end

  def enter_formatted_display_name(string)
    logger.info "Entering formatted display name '#{string}'"
    wait_for_element_and_type(formatted_display_name, string)
  end

end
