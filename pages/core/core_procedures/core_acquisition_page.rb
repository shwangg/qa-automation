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

  def enter_number_and_text(data)
    enter_acquisition_ref_num data
    enter_acquisition_note data
  end

  def enter_number(data)
    enter_acquisition_ref_num data
  end
end
