require_relative '../../../spec_helper'

module ExhibitionInfoForm

  include Logging
  include Page
  include CollectionSpacePages

  def exhibition_num_input_locator; input_locator([], ExhibitionData::EXHIBITION_NUM.name) end
  def exhibition_num_options_locator; input_options_locator([], ExhibitionData::EXHIBITION_NUM.name) end

  # Enters an exhibition number
  # @param [String] num
  def enter_exhibition_num(num)
    logger.debug "Entering exhibition number #{num}"
    wait_for_options_and_type(exhibition_num_input_locator, exhibition_num_options_locator, num)
  end

end
