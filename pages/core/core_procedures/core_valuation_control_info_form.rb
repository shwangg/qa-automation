require_relative '../../../spec_helper'

module CoreValuationControlInfoForm

  include Logging
  include Page
  include CollectionSpacePages

  DEPLOYMENT = Deployment::CORE

  def ref_num_input_locator; input_locator([], CoreValuationControlData::VALUE_NUM.name) end

  # Enters an valuation control reference number
  # @param [Hash] data_set
  def enter_valuation_control_ref_num(data_set)
    vc_ref_num = data_set[CoreValuationControlData::VALUE_NUM.name]
    logger.debug "Entering reference number '#{vc_ref_num}'"
    ref_num_options_locator = input_options_locator([], CoreValuationControlData::VALUE_NUM.name)
    wait_for_options_and_type(ref_num_input_locator, ref_num_options_locator, vc_ref_num)
  end


  # Combines all data entry methods
  # @param [Hash] data_set
  def enter_valuation_control_info_data(data_set)
    hide_notifications_bar
    enter_valuation_control_ref_num data_set
  end

end
