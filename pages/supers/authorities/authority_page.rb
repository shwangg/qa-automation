require_relative '../../../spec_helper'

class AuthorityPage

  include Logging
  include Page
  include CollectionSpacePages

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

  # Selects or creates a broader authority context
  # @param [String] authority
  def add_broader_auth(authority)
    logger.info "Broader context is '#{authority}'"
    close_notifications_bar
    autocomplete_select_or_create(broader_input, broader_input_options, authority)
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

  # Selects or creates a set of narrower authority contexts
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
      autocomplete_select_or_create(input_locator, input_options_locator, authority)
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
