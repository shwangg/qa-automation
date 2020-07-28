require_relative '../../../spec_helper'

class CoreMediaHandlingPage

  include Logging
  include Page
  include CollectionSpacePages
  include CoreSidebar
  include CoreMediaHandlingInfoForm

  DEPLOYMENT = Deployment::CORE

  # Enters new media handling data, save it, and wait for a delete button to appear
  # @param [Hash] data_set
  # @return [Array<Object>]
  def create_new_media(data_set)
    enter_media_info_data data_set
    click_save_button
    when_exists(delete_button, Config.short_wait)
  end

end
