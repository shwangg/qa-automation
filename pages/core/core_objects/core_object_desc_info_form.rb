require_relative '../../../spec_helper'

module CoreObjectDescInfoForm

  include Logging
  include Page
  include CollectionSpacePages

  DEPLOYMENT = Deployment::CORE

  def obj_desc_info_button; {xpath: '//button//h3//span[text()="Object Description Information"]'} end
  def age_value_input; input_locator([], CoreObjectData::AGE.name) end
  def dimens_measure_value_input(indices); input_locator([fieldset(CoreObjectData::DIMENS_LIST.name, indices[0]), fieldset(CoreObjectData::MEASURE_SUB_GRP.name, indices[1])], CoreObjectData::VALUE.name) end

  def expand_obj_desc_info
    when_exists(obj_desc_info_button, Config.short_wait)
    if visible? age_value_input
      logger.debug 'Object description information is already expanded'
    else
      logger.info 'Expanding the object description information'
      wait_for_element_and_click(obj_desc_info_button, Config.short_wait)
    end
  end

  def enter_age_value(data)
    logger.info "Entering age value '#{data[CoreObjectData::AGE.name]}'"
    wait_for_element_and_type(age_value_input, data[CoreObjectData::AGE.name])
  end

end
