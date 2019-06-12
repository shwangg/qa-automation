require_relative '../../../spec_helper'

module CoreExhibitionInfoForm

  include Logging
  include Page
  include CollectionSpacePages

  DEPLOYMENT = Deployment::CORE

  def sponsor_input_locator(index); input_locator([fieldset(ExhibitionData::SPONSOR.name, index)]) end
  def sponsor_options_locator(index); input_options_locator([fieldset(ExhibitionData::SPONSOR.name, index)]) end

  # Selects an existing sponsor from the sponsor input
  # @param [String] name
  # @param [Integer] index
  def select_sponsor(name, index)
    enter_auto_complete(sponsor_input_locator(index), sponsor_options_locator(index), name)
  end

end
