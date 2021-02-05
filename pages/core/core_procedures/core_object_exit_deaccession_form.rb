module CoreObjectExitDeaccessionForm

  include Logging
  include Page
  include CollectionSpacePages

  DEPLOYMENT = Deployment::CORE

  def obj_exit_deaccession_button; {xpath: '//button//h3//span[text()="Deaccession and Disposal Information"]'} end
  def disposal_value_loc; input_locator([], CoreObjectExitData::DISPOSAL_VALUE.name) end
  def grp_disposal_value_loc; input_locator([], CoreObjectExitData::GRP_DISPOSAL_VALUE.name) end

  def expand_deaccession_info
    when_exists(obj_exit_deaccession_button, Config.short_wait)
    if visible? disposal_value_loc
      logger.debug 'Object deaccession information is already expanded'
    else
      logger.info 'Expanding the object deaccession information'
      wait_for_element_and_click(obj_exit_deaccession_button, Config.short_wait)
    end
  end

  def enter_disposal_value(data)
    logger.debug "Entering disposal value '#{data[CoreObjectExitData::DISPOSAL_VALUE.name]}'"
    wait_for_element_and_type(disposal_value_loc, data[CoreObjectExitData::DISPOSAL_VALUE.name])
  end

  def enter_grp_disposal_value(data)
    logger.debug "Entering group disposal value '#{data[CoreObjectExitData::GRP_DISPOSAL_VALUE.name]}'"
    wait_for_element_and_type(grp_disposal_value_loc, data[CoreObjectExitData::GRP_DISPOSAL_VALUE.name])
  end

end
