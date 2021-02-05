require_relative '../../../spec_helper'

module CoreMediaHandlingInfoForm

  include Logging
  include Page
  include CollectionSpacePages

  DEPLOYMENT = Deployment::CORE

  def media_num_input; input_locator([], CoreMediaHandlingData::ID_NUM.name) end
  def media_num_options; input_options_locator([], CoreMediaHandlingData::ID_NUM.name) end
  def dimens_measure_value_input(indices); input_locator([fieldset(CoreMediaHandlingData::DIMENS_LIST.name, indices[0]), fieldset(CoreMediaHandlingData::MEASURE_SUB_GRP.name, indices[1])], CoreMediaHandlingData::VALUE.name) end

  def enter_id_number(data)
    logger.debug "Entering id number #{data[CoreMediaHandlingData::ID_NUM.name]}"
    wait_for_options_and_type(media_num_input, media_num_options, data[CoreMediaHandlingData::ID_NUM.name])
  end

  def description_input_locator; text_area_locator([], CoreMediaHandlingData::DESCRIPTION.name) end

  # Enters description
  # @param [Hash] data_set
  def enter_description(data_set)
    description = data_set[CoreMediaHandlingData::DESCRIPTION.name]
    logger.debug "Entering description '#{description}'"
    wait_for_element_and_type(description_input_locator, description) if description
  end

  # Combines all data entry methods
  # @param [Hash] data_set
  def enter_media_info_data(data_set)
    hide_notifications_bar
    enter_id_number data_set
  end

end
