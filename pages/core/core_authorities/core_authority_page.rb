require_relative '../../../spec_helper'

class CoreAuthorityPage

  include Logging
  include Page
  include CollectionSpacePages
  include CoreSidebar

  DEPLOYMENT = Deployment::CORE

  # TERM

  def term_display_name_input(fieldsets); input_locator(fieldsets, CoreAuthorityData::TERM_DISPLAY_NAME.name) end
  def term_name_input(fieldsets); input_locator(fieldsets, CoreAuthorityData::TERM_NAME.name) end
  def term_qualifier_input(fieldsets); input_locator(fieldsets, CoreAuthorityData::TERM_QUALIFIER.name) end
  def term_status_input(fieldsets); input_locator(fieldsets, CoreAuthorityData::TERM_STATUS.name) end
  def term_status_options(fieldsets); input_options_locator(fieldsets, CoreAuthorityData::TERM_STATUS.name) end
  def term_type_input(fieldsets); input_locator(fieldsets, CoreAuthorityData::TERM_TYPE.name) end
  def term_type_options(fieldsets); input_options_locator(fieldsets, CoreAuthorityData::TERM_TYPE.name) end
  def term_flag_input(fieldsets); input_locator(fieldsets, CoreAuthorityData::TERM_FLAG.name) end
  def term_flag_options(fieldsets); input_options_locator(fieldsets, CoreAuthorityData::TERM_FLAG.name) end
  def term_language_input(fieldsets); input_locator(fieldsets, CoreAuthorityData::TERM_LANGUAGE.name) end
  def term_language_options(fieldsets); input_options_locator(fieldsets, CoreAuthorityData::TERM_LANGUAGE.name) end
  def term_pref_for_lang_input(fieldsets); input_locator(fieldsets, CoreAuthorityData::TERM_PREF_FOR_LANGUAGE.name) end

  def term_source_name_input(fieldsets); input_locator(fieldsets, CoreAuthorityData::TERM_SOURCE.name) end
  def term_source_name_options(fieldsets); input_options_locator(fieldsets, CoreAuthorityData::TERM_SOURCE.name) end
  def term_source_detail_input(fieldsets); input_locator(fieldsets, CoreAuthorityData::TERM_SOURCE_DETAIL.name) end
  def term_source_id_input(fieldsets); input_locator(fieldsets, CoreAuthorityData::TERM_SOURCE_ID.name) end
  def term_source_note_input(fieldsets); input_locator(fieldsets, CoreAuthorityData::TERM_SOURCE_NOTE.name) end

  # HIERARCHY SECTION

  def hierarchy_section_button; {:xpath => '//button[contains(., "Hierarchy")]'} end

  # Expands the hierarchy section of the authority page unless it is already expanded
  def expand_hierarchy
    scroll_to_bottom
    wait_for_element_and_click hierarchy_section_button unless exists? broader_input
  end

  # BROADER

  def broader_input; input_locator_by_label('Broader') end
  def broader_input_options; input_options_locator_by_label('Broader') end

  # Creates a broader authority context
  # @param [String] authority
  def add_broader_auth(authority)
    logger.info "Broader context is '#{authority}'"
    close_notifications_bar
    enter_auto_complete(broader_input, broader_input_options, authority, 'Create new record')
  end

  # Removes the contents of the broader authority input
  def remove_broader_auth
    logger.info 'Removing broader context'
    close_notifications_bar
    wait_for_element_and_type(broader_input, '')
  end

  # NARROWER

  def narrower_input(index); input_locator([fieldset(CollectionSpaceData::REF_NAMES_CHILDREN.name, index)]) end
  def narrower_input_options(index); input_options_locator([fieldset(CollectionSpaceData::REF_NAMES_CHILDREN.name, index)]) end
  def narrower_delete_btn(index); delete_button_locator([fieldset(CollectionSpaceData::REF_NAMES_CHILDREN.name, index)]) end
  def narrower_add_btn; add_button_locator([fieldset(CollectionSpaceData::REF_NAMES_CHILDREN.name)]) end

  # Creates a set of narrower authority contexts
  # @param [Array<String>]
  def add_narrower_auths(authorities)
    close_notifications_bar
    authorities.each do |authority|
      index = authorities.index authority
      wait_for_element_and_click narrower_add_btn unless index.zero? && element_value(narrower_input(0)) == ''
      input_index = elements(input_locator([fieldset(CollectionSpaceData::REF_NAMES_CHILDREN.name)])).length - 1
      logger.debug "Narrower context is '#{authority}' at index #{input_index}"
      input_locator = input_locator([fieldset(CollectionSpaceData::REF_NAMES_CHILDREN.name, input_index)])
      input_options_locator = input_options_locator([fieldset(CollectionSpaceData::REF_NAMES_CHILDREN.name, input_index)])
      enter_auto_complete(input_locator, input_options_locator, authority, 'Create new record')
    end
  end

  # Removes a narrower authority context at a given index
  # @param [Integer] index
  def remove_narrower_auth(index)
    close_notifications_bar
    wait_for_element_and_click narrower_delete_btn(index)
    when_not_exists(narrower_delete_btn(index), Config.short_wait)
  end

  # ADJACENT

  # Returns the display names of adjacent authority contexts
  # @return [Array<String>]
  def adjacent_auths
    elements({:xpath => '//div[@class="cspace-ui-HierarchySiblingList--common"]//li'}).map &:text
  end

  # Verifies that an authority has a given set of broader, adjacent, and narrower contexts
  # @param [String] broader
  # @param [Array<String>] adjacent
  # @param [Array<String>] narrower
  # @return [Array<String>]
  def verify_hierarchy(broader, adjacent, narrower)
    errors = []
    close_notifications_bar if exists?(notifications_close_button)
    when_displayed(broader_input, Config.short_wait)
    sleep 2

    # Parent
    wait_until(Config.short_wait) do
      broader ? text_values_match?(broader, element_value(broader_input), errors) : text_values_match?('', element_value(broader_input), errors)
    end

    # Siblings
    wait_until(1, "Expected siblings #{adjacent}, but got #{adjacent_auths}") { adjacent_auths == adjacent }

    # Children
    wait_until(Config.short_wait) do
      narrower && narrower.any? ?
          (narrower.each { |narrow| text_values_match?(narrow, element_value(narrower_input narrower.index(narrow)), errors) }) :
          text_values_match?('', element_value(narrower_input 0), errors)
    end
    errors
  end
end
