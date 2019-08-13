require_relative '../../../spec_helper'

module CoreInventoryMovementInfoForm

  include Logging
  include Page
  include CollectionSpacePages

  def ref_num_input; input_locator([], CoreInventoryMovementData::REF_NUM.name) end
  def normal_location_input; input_locator([], CoreInventoryMovementData::NORMAL_LOCATION.name) end
  def normal_location_options; input_options_locator([], CoreInventoryMovementData::NORMAL_LOCATION.name) end
  def current_location_input; input_locator([], CoreInventoryMovementData::CURRENT_LOCATION.name) end
  def current_location_options; input_options_locator([], CoreInventoryMovementData::CURRENT_LOCATION.name) end
  def current_location_fitness_input; input_locator([], CoreInventoryMovementData::CURRENT_LOCATION_FITNESS.name) end
  def current_location_fitness_options; input_options_locator([], CoreInventoryMovementData::CURRENT_LOCATION_FITNESS.name) end
  def current_location_note_input; input_locator([], CoreInventoryMovementData::CURRENT_LOCATION_NOTE.name) end
  def location_date_input; input_locator([], CoreInventoryMovementData::LOCATION_DATE.name) end

  # REFERENCE NUMBER

  def enter_reference_number(data)
    hide_notifications_bar
    logger.info "Entering reference number '#{data[CoreInventoryMovementData::REF_NUM.name]}'"
    wait_for_element_and_type(ref_num_input, data[CoreInventoryMovementData::REF_NUM.name])
  end

  # NORMAL LOCATION

  def enter_normal_location(data)
    hide_notifications_bar
    logger.info "Entering normal location '#{data[CoreInventoryMovementData::NORMAL_LOCATION.name]}'"
    enter_auto_complete(normal_location_input, normal_location_options, data[CoreInventoryMovementData::NORMAL_LOCATION.name], 'Local Storage Locations')
  end

  # CURRENT LOCATION

  def enter_current_location(data)
    hide_notifications_bar
    logger.info "Entering current location '#{data[CoreInventoryMovementData::CURRENT_LOCATION.name]}'"
    enter_auto_complete(current_location_input, current_location_options, data[CoreInventoryMovementData::CURRENT_LOCATION.name], 'Local Storage Locations')
    logger.info "Selecting current location fitness '#{data[CoreInventoryMovementData::CURRENT_LOCATION_FITNESS.name]}'"
    wait_for_options_and_select(current_location_fitness_input, current_location_fitness_options, data[CoreInventoryMovementData::CURRENT_LOCATION_FITNESS.name])
    logger.info "Entering current location note '#{data[CoreInventoryMovementData::CURRENT_LOCATION_NOTE.name]}'"
    wait_for_element_and_type(current_location_note_input, data[CoreInventoryMovementData::CURRENT_LOCATION_NOTE.name])
  end

  # LOCATION DATE

  def enter_location_date(data)
    hide_notifications_bar
    logger.info "Entering location date '#{data[CoreInventoryMovementData::LOCATION_DATE.name]}'"
    enter_simple_date(location_date_input, data[CoreInventoryMovementData::LOCATION_DATE.name])
  end

end
