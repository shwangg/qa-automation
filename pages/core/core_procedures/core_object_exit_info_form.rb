#Object Exit Info form

require_relative '../../../spec_helper'

module CoreObjectExitInfoForm

  include Logging
  include Page
  include CollectionSpacePages

  DEPLOYMENT = Deployment::CORE

  def exit_num_input_locator; input_locator([], CoreObjectExitData::OBJECT_EXIT_NUM.name) end

  # Enters an acquisition reference number
  # @param [Hash] data_set
  def enter_object_exit_num(data_set)
    exit_num = data_set[CoreObjectExitData::OBJECT_EXIT_NUM.name]
    logger.debug "Entering exit number '#{exit_num}'"
    exit_num_options_locator = input_options_locator([], CoreObjectExitData::OBJECT_EXIT_NUM.name)
    wait_for_options_and_type(exit_num_input_locator, exit_num_options_locator, exit_num)
  end


  # Combines all data entry methods
  # @param [Hash] data_set
  def enter_object_exit_info_data(data_set)
    hide_notifications_bar
    enter_object_exit_num data_set
  end

end
