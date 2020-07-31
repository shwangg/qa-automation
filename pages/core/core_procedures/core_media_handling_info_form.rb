require_relative '../../../spec_helper'

module CoreMediaHandlingInfoForm

  include Logging
  include Page
  include CollectionSpacePages

  DEPLOYMENT = Deployment::CORE

  def id_num_input_locator; input_locator([], CoreMediaHandlingData::MEDIA_ID_NUM.name) end

  # Enters an acquisition reference number
  # @param [Hash] data_set
  def enter_media_id_num(data_set)
    media_id_num = data_set[CoreMediaHandlingData::MEDIA_ID_NUM.name]
    logger.debug "Entering id number '#{media_id_num}'"
    id_num_options_locator = input_options_locator([], CoreMediaHandlingData::MEDIA_ID_NUM.name)
    wait_for_options_and_type(id_num_input_locator, id_num_options_locator, media_id_num)
  end


  # Combines all data entry methods
  # @param [Hash] data_set
  def enter_media_info_data(data_set)
    hide_notifications_bar
    enter_media_id_num data_set
  end

end
