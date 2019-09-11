require_relative '../../../spec_helper'

class CoreAcquisitionPage

  include Logging
  include Page
  include CollectionSpacePages
  include CoreSidebar
  include CoreAcquisitionInfoForm

  DEPLOYMENT = Deployment::CORE

  # Enters new acquisition data, save it, and wait for a delete button to appear
  # @param [Hash] data_set
  # @return [Array<Object>]
  def create_new_acquisition(data_set)
    enter_acquisition_info_data data_set
    click_save_button
    when_exists(delete_button, Config.short_wait)
  end

end
