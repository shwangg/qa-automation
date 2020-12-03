require_relative '../../../spec_helper'

class CoreCitationPage < CoreAuthorityPage

  include Logging
  include Page
  include CollectionSpacePages

  DEPLOYMENT = Deployment::CORE

  def display_name_input(index); input_locator([fieldset(CoreCitationData::CITATION_TERMS.name, index)], CoreCitationData::TERM_DISPLAY_NAME.name) end
  def display_name_add_btn; add_button_locator([fieldset(CoreCitationData::CITATION_TERMS.name)]) end

  def enter_display_name(name, index)
    logger.debug "Entering display name '#{name}'"
    wait_for_element_and_type(display_name_input(index), name)
  end

  def verify_display_name(name, index)
    wait_until(Config.short_wait, "Expected display name '#{name}', but got '#{element_value(display_name_input index)}'") do
      text_values_match?(name, element_value(display_name_input index))
    end
  end

  def enter_number_and_text(data)
    enter_acquisition_ref_num data
    enter_acquisition_note data
  end

  def enter_number(data)
    enter_acquisition_ref_num data
  end
end