require_relative '../../../spec_helper'

module CoreGroupInfoForm

  include Logging
  include Page
  include CollectionSpacePages

  DEPLOYMENT = Deployment::CORE

  def title_input; input_locator([], CoreGroupData::TITLE.name) end
  def enter_title(data)
    logger.debug "Entering title #{data[CoreGroupData::TITLE.name]}"
    wait_for_element_and_type(title_input, data[CoreGroupData::TITLE.name])
  end

  def scope_note_input_locator; text_area_locator([], CoreGroupData::SCOPE_NOTE.name) end

  # Enters scope note
  # @param [Hash] data_set
  def enter_scope_note(data_set)
    scope_note = data_set[CoreGroupData::SCOPE_NOTE.name]
    logger.debug "Entering group note '#{scope_note}'"
    wait_for_element_and_type(scope_note_input_locator, scope_note) if scope_note
  end
end
