module PAHMAInventoryMovementInfoForm

  include Logging
  include Page
  include CollectionSpacePages
  include CoreInventoryMovementInfoForm

  # CURRENT LOCATION

  def pahma_crate_input; input_locator([], PAHMAInventoryMovementData::CRATE.name) end
  def pahma_crate_options; input_options_locator([], PAHMAInventoryMovementData::CRATE.name) end

  def enter_pahma_current_location(data)
    hide_notifications_bar
    logger.info "Entering current location '#{data[PAHMAInventoryMovementData::CURRENT_LOCATION.name]}'"
    enter_auto_complete(current_location_input, current_location_options, data[PAHMAInventoryMovementData::CURRENT_LOCATION.name], 'PAHMA Storage Locations')
    logger.info "Entering current location crate '#{data[PAHMAInventoryMovementData::CRATE.name]}'"
    enter_auto_complete(pahma_crate_input, pahma_crate_options, data[PAHMAInventoryMovementData::CRATE.name], 'Crates')
    logger.info "Selecting current location fitness '#{data[PAHMAInventoryMovementData::CURRENT_LOCATION_FITNESS.name]}'"
    wait_for_options_and_select(current_location_fitness_input, current_location_fitness_options, data[PAHMAInventoryMovementData::CURRENT_LOCATION_FITNESS.name])
    logger.info "Entering current location note '#{data[PAHMAInventoryMovementData::CURRENT_LOCATION_NOTE.name]}'"
    wait_for_element_and_type(current_location_note_input, data[PAHMAInventoryMovementData::CURRENT_LOCATION_NOTE.name])
  end

  # LOCATION HANDLERS

  def pahma_location_handler_input(index); input_locator([fieldset(PAHMAInventoryMovementData::LOCATION_HANDLERS.name, index)]) end
  def pahma_location_handler_options(index); input_options_locator([fieldset(PAHMAInventoryMovementData::LOCATION_HANDLERS.name, index)]) end

  def enter_pahma_location_handlers(data)
    hide_notifications_bar
    handlers = data[PAHMAInventoryMovementData::LOCATION_HANDLERS.name] || [{PAHMAInventoryMovementData::LOCATION_HANDLER.name => ''}]
    prep_fieldsets_for_test_data([fieldset(PAHMAInventoryMovementData::LOCATION_HANDLERS.name)], handlers)
    handlers.each_with_index do |handler, index|
      logger.info "Entering handler '#{handler[PAHMAInventoryMovementData::LOCATION_HANDLER.name]}' at index #{index}"
      enter_auto_complete(pahma_location_handler_input(index), pahma_location_handler_options(index), handler[PAHMAInventoryMovementData::LOCATION_HANDLER.name], 'PAHMA Persons')
    end
  end

  # REASON

  def pahma_reason_input; input_locator([], PAHMAInventoryMovementData::REASON.name) end
  def pahma_reason_options; input_options_locator([], PAHMAInventoryMovementData::REASON.name) end

  def enter_pahma_reason(data)
    hide_notifications_bar
    logger.info "Selecing reason '#{data[PAHMAInventoryMovementData::REASON.name]}'"
    wait_for_options_and_select(pahma_reason_input, pahma_reason_options, data[PAHMAInventoryMovementData::REASON.name])
  end

  # METHOD

  def pahma_method_input(index); input_locator([fieldset(PAHMAInventoryMovementData::METHODS.name, index)]) end
  def pahma_method_options(index); input_options_locator([fieldset(PAHMAInventoryMovementData::METHODS.name, index)]) end

  def enter_pahma_methods(data)
    hide_notifications_bar
    methods = data[PAHMAInventoryMovementData::METHODS.name] || [{PAHMAInventoryMovementData::METHOD.name => ''}]
    prep_fieldsets_for_test_data([fieldset(PAHMAInventoryMovementData::METHODS.name)], methods)
    methods.each_with_index do |method, index|
      logger.info "Selecting method '#{method}' at index #{index}"
      wait_for_options_and_select(pahma_method_input(index), pahma_method_options(index), method[PAHMAInventoryMovementData::METHOD.name])
    end
  end

  # NOTE

  def pahma_note_input; text_area_locator([], PAHMAInventoryMovementData::NOTE.name) end

  def enter_pahma_note(data)
    hide_notifications_bar
    logger.info "Entering note '#{data[PAHMAInventoryMovementData::NOTE.name]}'"
    wait_for_element_and_type(pahma_note_input, data[PAHMAInventoryMovementData::NOTE.name])
  end

end
