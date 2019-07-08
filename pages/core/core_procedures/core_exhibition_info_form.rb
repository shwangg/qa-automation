require_relative '../../../spec_helper'

module CoreExhibitionInfoForm

  include Logging
  include Page
  include CollectionSpacePages

  DEPLOYMENT = Deployment::CORE

  def exhibition_num_input_locator; input_locator([], CoreExhibitionData::EXHIBITION_NUM.name) end
  def exhibition_num_options_locator; input_options_locator([], CoreExhibitionData::EXHIBITION_NUM.name) end

  # Enters an exhibition number
  # @param [String] num
  def enter_exhibition_num(num)
    logger.debug "Entering exhibition number #{num}"
    wait_for_options_and_type(exhibition_num_input_locator, exhibition_num_options_locator, num)
  end

  def sponsor_input_locator(index); input_locator([fieldset(CoreExhibitionData::SPONSOR.name, index)]) end
  def sponsor_options_locator(index); input_options_locator([fieldset(CoreExhibitionData::SPONSOR.name, index)]) end

  # Selects an existing sponsor from the sponsor input
  # @param [String] name
  # @param [Integer] index
  def select_sponsor(name, index)
    enter_auto_complete(sponsor_input_locator(index), sponsor_options_locator(index), name)
  end

end
