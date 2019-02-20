require_relative '../../spec_helper'

class CoreObjectPage < ObjectPage

  include Logging
  include Page
  include CollectionSpacePages
  include CoreObjectIdInfoForm

  DEPLOYMENT = Deployment::CORE

  # Enters data in the various forms on the Core new object page
  # @param [Hash] data_set
  # @return [Array<Object>]
  def enter_object_data(data_set)
    enter_object_id_data data_set
  end

  # Combines methods to enter new object data, save it, and wait for a delete button to appear. Returns any errors caused by form fields.
  # @param [Hash] data_set
  # @return [Array<Object>]
  def create_new_object(data_set)
    data_input_errors = enter_object_data data_set
    click_save_button
    when_exists(delete_button, Config.short_wait)
    data_input_errors
  end

  # Checks data in the various forms on the Core new object page
  # @param [Hash] data_set
  def verify_object_data(data_set)
    verify_object_info_data data_set
  end

end
