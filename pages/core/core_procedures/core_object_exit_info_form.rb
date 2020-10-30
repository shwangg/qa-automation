require_relative '../../../spec_helper'

module CoreObjectExitInfoForm

  include Logging
  include Page
  include CollectionSpacePages

  DEPLOYMENT = Deployment::CORE

  def object_num_input; input_locator([], CoreObjectExitData::EXIT_NUM.name) end
  def object_num_options; input_options_locator([], CoreObjectExitData::EXIT_NUM.name) end

  def enter_exit_number(data)
    logger.debug "Entering number #{data[CoreObjectExitData::EXIT_NUM.name]}"
    wait_for_options_and_type(object_num_input, object_num_options, data[CoreObjectExitData::EXIT_NUM.name])
  end

  def exit_note_input_locator; text_area_locator([], CoreObjectExitData::EXIT_NOTE.name) end

  # Enters exit note
  # @param [Hash] data_set
  def enter_exit_note(data_set)
    exit_note = data_set[CoreObjectExitData::EXIT_NOTE.name]
    logger.debug "Entering exit_note '#{exit_note}'"
    wait_for_element_and_type(exit_note_input_locator,exit_note) if exit_note
  end

  # Combines all data entry methods
  # @param [Hash] data_set
  def enter_object_exit_info_data(data_set)
    hide_notifications_bar
    enter_exit_number data_set
  end

end
