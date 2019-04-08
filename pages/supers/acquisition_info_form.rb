require_relative '../../spec_helper'

module AcquisitionInfoForm

  include Logging
  include Page
  include CollectionSpacePages

  def ref_num_input_locator
    input_locator([], AcquisitionData::ACQUIS_REF_NUM.name)
  end

  # Enters an acquisition reference number
  # @param [Hash] data_set
  def enter_acquisition_ref_num(data_set)
    acquis_ref_num = data_set[AcquisitionData::ACQUIS_REF_NUM.name]
    logger.debug "Entering reference number '#{acquis_ref_num}'"
    ref_num_options_locator = input_options_locator([], AcquisitionData::ACQUIS_REF_NUM.name)
    wait_for_options_and_type(ref_num_input_locator, ref_num_options_locator, acquis_ref_num)
  end

end
