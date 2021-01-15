require_relative '../../../spec_helper'

module BOTGARDENCurrentLocationInfoForm

  include Logging
  include BOTGARDENPages
  include CollectionSpacePages

  DEPLOYMENT = Deployment::BOTGARDEN

  def action_code_input; input_locator([], BOTGARDENCurrentLocationData::ACTION_CODE.name) end
  def action_code_options; input_options_locator([], BOTGARDENCurrentLocationData::ACTION_CODE.name) end
  def action_date_input; input_locator([], BOTGARDENCurrentLocationData::ACTION_DATE.name) end
  def location_input; input_locator([], BOTGARDENCurrentLocationData::LOCATION.name) end
  def location_options; input_options_locator([], BOTGARDENCurrentLocationData::LOCATION.name) end

  # Enters action code
  # @param [Hash] data
  def enter_action_code(data)
    action_code = data[BOTGARDENCurrentLocationData::ACTION_CODE.name]
    if action_code
      logger.info "Selecting action code '#{action_code}'"
      wait_for_options_and_select(action_code_input, action_code_options, action_code)
    end
  end

  # Enters action date
  # @param [Hash] data
  def enter_action_date(data)
    action_date = data[BOTGARDENCurrentLocationData::ACTION_DATE.name]
    if action_date
      logger.info "Entering action date '#{action_date}'"
      enter_simple_date(action_date_input, action_date)
    end
  end

  # Enters garden location
  # @param [Hash] data
  def enter_garden_location(data)
    location = data[BOTGARDENCurrentLocationData::LOCATION.name]
    if location
      logger.debug "Entering garden location #{location}"
      enter_auto_complete(location_input, location_options, location)
    end
  end

end
