require_relative '../../../spec_helper'

module PAHMAInventoryMovementInfoForm

  include Logging
  include Page
  include CollectionSpacePages
  include CoreInventoryMovementInfoForm

  def crate_input; input_locator([], PAHMAInventoryMovementData::CRATE.name) end
  def crate_options; input_options_locator([], PAHMAInventoryMovementData::CRATE.name) end
  def location_handler_input(index); input_locator([fieldset(PAHMAInventoryMovementData::LOCATION_HANDLERS.name, index)]) end
  def location_handler_options(index); input_options_locator([fieldset(PAHMAInventoryMovementData::LOCATION_HANDLERS.name, index)]) end
  def reason_input; input_locator([], PAHMAInventoryMovementData::REASON.name) end
  def reason_options; input_options_locator([], PAHMAInventoryMovementData::REASON.name) end
  def method_input(index); input_locator([fieldset(PAHMAInventoryMovementData::METHODS.name, index)]) end
  def method_options(index); input_options_locator([fieldset(PAHMAInventoryMovementData::METHODS.name, index)]) end
  def note_input; text_area_locator([], PAHMAInventoryMovementData::NOTE.name) end

  # CURRENT LOCATION

  def enter_current_location(data)
    hide_notifications_bar
    logger.info "Entering current location '#{data[PAHMAInventoryMovementData::CURRENT_LOCATION.name]}'"
    enter_auto_complete(current_location_input, current_location_options, data[PAHMAInventoryMovementData::CURRENT_LOCATION.name], 'PAHMA Storage Locations')
    logger.info "Entering current location crate '#{data[PAHMAInventoryMovementData::CRATE.name]}'"
    enter_auto_complete(crate_input, crate_options, data[PAHMAInventoryMovementData::CRATE.name], 'Crates')
    logger.info "Selecting current location fitness '#{data[PAHMAInventoryMovementData::CURRENT_LOCATION_FITNESS.name]}'"
    wait_for_options_and_select(current_location_fitness_input, current_location_fitness_options, data[PAHMAInventoryMovementData::CURRENT_LOCATION_FITNESS.name])
    logger.info "Entering current location note '#{data[PAHMAInventoryMovementData::CURRENT_LOCATION_NOTE.name]}'"
    wait_for_element_and_type(current_location_note_input, data[PAHMAInventoryMovementData::CURRENT_LOCATION_NOTE.name])
  end

  # LOCATION HANDLERS

  def enter_location_handlers(data)
    hide_notifications_bar
    handlers = data[PAHMAInventoryMovementData::LOCATION_HANDLERS.name] || [{PAHMAInventoryMovementData::LOCATION_HANDLER.name => ''}]
    prep_fieldsets_for_test_data([fieldset(PAHMAInventoryMovementData::LOCATION_HANDLERS.name)], handlers)
    handlers.each_with_index do |handler, index|
      logger.info "Entering handler '#{handler[PAHMAInventoryMovementData::LOCATION_HANDLER.name]}' at index #{index}"
      enter_auto_complete(location_handler_input(index), location_handler_options(index), handler[PAHMAInventoryMovementData::LOCATION_HANDLER.name], 'PAHMA Persons')
    end
  end

  # REASON

  def enter_reason(data)
    hide_notifications_bar
    logger.info "Selecing reason '#{data[PAHMAInventoryMovementData::REASON.name]}'"
    wait_for_options_and_select(reason_input, reason_options, data[PAHMAInventoryMovementData::REASON.name])
  end

  # METHOD

  def enter_methods(data)
    hide_notifications_bar
    methods = data[PAHMAInventoryMovementData::METHODS.name] || [{PAHMAInventoryMovementData::METHOD.name => ''}]
    prep_fieldsets_for_test_data([fieldset(PAHMAInventoryMovementData::METHODS.name)], methods)
    methods.each_with_index do |method, index|
      logger.info "Selecting method '#{method}' at index #{index}"
      wait_for_options_and_select(method_input(index), method_options(index), method[PAHMAInventoryMovementData::METHOD.name])
    end
  end

  # NOTE

  def enter_note(data)
    hide_notifications_bar
    logger.info "Entering note '#{data[PAHMAInventoryMovementData::NOTE.name]}'"
    wait_for_element_and_type(note_input, data[PAHMAInventoryMovementData::NOTE.name])
  end

end
