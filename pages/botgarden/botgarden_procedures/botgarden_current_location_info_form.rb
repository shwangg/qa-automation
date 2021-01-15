require_relative '../../../spec_helper'

module BOTGARDENCurrentLocationInfoForm

  include Logging
  include BOTGARDENPages
  include CollectionSpacePages

  DEPLOYMENT = Deployment::BOTGARDEN

  # ACTION DATE

  def acton_date_input_locator; input_locator([], BOTGARDENCurrentLocationData::ACTION_DATE.name) end

  # Enters an action date
  # @param [Hash] data_set
  def enter_action_date(data_set)
    action_date = data_set[BOTGARDENCurrentLocationData::ACTION_DATE.name]
    if action_date
        logger.debug "Entering accession date '#{action_date}'"
        enter_simple_date(acton_date_input_locator, action_date)
    end
  end

  # GARDEN LOCATION

  def garden_location_input_locator; input_locator([], BOTGARDENCurrentLocationData::GARDEN_LOCATION.name) end

  # Selects an garden location
  # @param [Hash] data_set
  def select_garden_location(data_set)
    garden = data_set[BOTGARDENCurrentLocationData::GARDEN_LOCATION.name]
    if garden
      logger.debug "Entering garden location '#{garden}'"
      garden_location_options_locator = input_options_locator([], BOTGARDENCurrentLocationData::GARDEN_LOCATION.name)
      hit_escape
      enter_auto_complete(garden_location_input_locator, garden_location_options_locator, '')
      enter_auto_complete(garden_location_input_locator, garden_location_options_locator, garden)
    end
  end

#   def delete_garden_location()


  # MOVEMENT NOTE

  def movement_note_input_locator; text_area_locator([], BOTGARDENCurrentLocationData::MOVEMENT_NOTE.name) end

  # Enters movement note
  # @param [Hash] data_set
  def enter_movement_note(data_set)
    mov_note = data_set[BOTGARDENCurrentLocationData::MOVEMENT_NOTE.name]
    logger.debug "Entering movement note '#{mov_note}'"
    wait_for_element_and_type(movement_note_input_locator, mov_note) if mov_note
  end

  # ACTION CODE

  def action_code_input_locator; input_locator([], BOTGARDENCurrentLocationData::ACTION_CODE.name) end

  # Selects an action code
  # @param [Hash] data_set
  def select_action_code(data_set)
    action = data_set[BOTGARDENCurrentLocationData::ACTION_CODE.name]
    if action
      logger.debug "Entering action code '#{action}'"
      action_code_options_locator = input_options_locator([], BOTGARDENCurrentLocationData::ACTION_CODE.name)
      hit_escape
      wait_for_options_and_select(action_code_input_locator, action_code_options_locator, action)
    end
  end
end
