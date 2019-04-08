require_relative '../../spec_helper'

module SearchAcquisitionsForm

  include Logging
  include Page
  include CollectionSpacePages

  def acquis_ref_num_input(index)
    input_locator([fieldset(AcquisitionData::ACQUIS_REF_NUM.name, index)])
  end

  # Enters an acquisition ref number
  # @param [Hash] data_set
  def enter_ref_num(data_set)
    ref_num = data_set[AcquisitionData::ACQUIS_REF_NUM.name]
    logger.debug "Entering acquisition ref number '#{ref_num}'"
    wait_for_element_and_type(acquis_ref_num_input(0), ref_num) if ref_num
  end

end
