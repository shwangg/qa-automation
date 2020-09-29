require_relative '../../../spec_helper'

module CoreMediaHandlingInfoForm

  include Logging
  include Page
  include CollectionSpacePages

  DEPLOYMENT = Deployment::CORE

  def object_num_input; input_locator([], CoreMediaHandlingData::ID_NUM.name) end
  def object_num_options; input_options_locator([], CoreMediaHandlingData::ID_NUM.name) end

  def enter_id_number(data)
    logger.debug "Entering id number #{data[CoreMediaHandlingData::ID_NUM.name]}"
    wait_for_options_and_type(object_num_input, object_num_options, data[CoreMediaHandlingData::ID_NUM.name])
  end

  def description_input_locator; text_area_locator([], CoreMediaHandlingData::DESCRIPTION.name) end

  # Enters description
  # @param [Hash] data_set
  def enter_description(data_set)
    description = data_set[CoreMediaHandlingData::DESCRIPTION.name]
    logger.debug "Entering description '#{description}'"
    wait_for_element_and_type(description_input_locator, description) if description
  end
end
