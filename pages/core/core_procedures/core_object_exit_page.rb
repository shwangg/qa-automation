require_relative '../../../spec_helper'

class CoreObjectExitPage

  include Logging
  include Page
  include CollectionSpacePages
  include CoreSidebar
  include CoreObjectExitInfoForm

  DEPLOYMENT = Deployment::CORE

  # Enters new object exit data, save it, and wait for a delete button to appear
  # @param [Hash] data_set
  # @return [Array<Object>]
  def create_new_object_exit(data_set)
    enter_object_exit_info_data data_set
    click_save_button
    when_exists(delete_button, Config.short_wait)
  end

end
