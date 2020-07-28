require_relative '../../../spec_helper'

class CoreObjectPage

  include Logging
  include Page
  include CollectionSpacePages
  include CoreSidebar
  include CorePages
  include CoreObjectIdInfoForm

  DEPLOYMENT = Deployment::CORE

  def page_heading; {:xpath => '//h1'} end

  def enter_object_id_data(data)
    enter_object_number data
    enter_num_objects data
    enter_other_numbers data
    enter_resp_depts data
    select_collection data
    select_status data
    enter_publish_to data
    select_inventory_status data
    enter_brief_description data
    #enter_dist_features data #TO DO: FIX ME
    enter_comments data
    enter_titles data
    enter_object_names data
  end

  # Enters data in the various forms on the new object page
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
    wait_for_element_and_click top_save_button
    when_exists(delete_button, Config.short_wait)
    data_input_errors
  end

  # Checks data in the various forms on the new object page
  # @param [Hash] data_set
  def verify_object_data(data_set)
    verify_object_info_data data_set
  end

end
