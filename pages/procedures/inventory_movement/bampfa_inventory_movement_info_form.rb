module BAMPFAInventoryMovementInfoForm

  include Logging
  include Page
  include CollectionSpacePages
  include CoreInventoryMovementInfoForm

  # CURRENT LOCATION

  def bampfa_crate_input; input_locator([], BAMPFAInventoryMovementData::CRATE.name) end
  def bampfa_crate_options; input_options_locator([], BAMPFAInventoryMovementData::CRATE.name) end

  def enter_bampfa_current_location(data)
    hide_notifications_bar
    logger.info "Entering current location '#{data[BAMPFAInventoryMovementData::CURRENT_LOCATION.name]}'"
    enter_auto_complete(current_location_input, current_location_options, data[BAMPFAInventoryMovementData::CURRENT_LOCATION.name], 'Local Storage Locations')
    logger.info "Entering current location crate '#{data[BAMPFAInventoryMovementData::CRATE.name]}'"
    enter_auto_complete(bampfa_crate_input, bampfa_crate_options, data[BAMPFAInventoryMovementData::CRATE.name], 'Crates')
    logger.info "Selecting current location fitness '#{data[BAMPFAInventoryMovementData::CURRENT_LOCATION_FITNESS.name]}'"
    wait_for_options_and_select(current_location_fitness_input, current_location_fitness_options, data[BAMPFAInventoryMovementData::CURRENT_LOCATION_FITNESS.name])
    logger.info "Entering current location note '#{data[BAMPFAInventoryMovementData::CURRENT_LOCATION_NOTE.name]}'"
    wait_for_element_and_type(current_location_note_input, data[BAMPFAInventoryMovementData::CURRENT_LOCATION_NOTE.name])
  end

  def enter_bampfa_current_location_only(data)
    hide_notifications_bar
    logger.info "Entering current location '#{data[BAMPFAInventoryMovementData::CURRENT_LOCATION.name]}'"
    enter_auto_complete(current_location_input, current_location_options, data[BAMPFAInventoryMovementData::CURRENT_LOCATION.name], 'Local Storage Locations')
  end 

  # HANDLER

  def bampfa_handler_input; input_locator([], BAMPFAInventoryMovementData::HANDLER.name) end

  def enter_bampfa_handler(data)
    hide_notifications_bar
    logger.info "Entering handler '#{data[BAMPFAInventoryMovementData::HANDLER.name]}'"
    wait_for_element_and_type(bampfa_handler_input, data[BAMPFAInventoryMovementData::HANDLER.name])
  end


  # REASON

  def bampfa_reason_input; input_locator([], BAMPFAInventoryMovementData::REASON.name) end
  def bampfa_reason_options; input_options_locator([], BAMPFAInventoryMovementData::REASON.name) end

  def enter_bampfa_reason(data)
    hide_notifications_bar
    logger.info "Selecing reason '#{data[BAMPFAInventoryMovementData::REASON.name]}'"
    wait_for_options_and_select(bampfa_reason_input, bampfa_reason_options, data[BAMPFAInventoryMovementData::REASON.name])
  end

  # METHOD

  def bampfa_method_input(index); input_locator([fieldset(BAMPFAInventoryMovementData::METHODS.name, index)]) end
  def bampfa_method_options(index); input_options_locator([fieldset(BAMPFAInventoryMovementData::METHODS.name, index)]) end

  def enter_bampfa_methods(data)
    hide_notifications_bar
    methods = data[BAMPFAInventoryMovementData::METHODS.name] || [{BAMPFAInventoryMovementData::METHOD.name => ''}]
    prep_fieldsets_for_test_data([fieldset(BAMPFAInventoryMovementData::METHODS.name)], methods)
    methods.each_with_index do |method, index|
      logger.info "Selecting method '#{method}' at index #{index}"
      wait_for_options_and_select(bampfa_method_input(index), bampfa_method_options(index), method[BAMPFAInventoryMovementData::METHOD.name])
    end
  end

  # NOTE

  def bampfa_note_input; text_area_locator([], BAMPFAInventoryMovementData::NOTE.name) end

  def enter_bampfa_note(data)
    hide_notifications_bar
    logger.info "Entering note '#{data[BAMPFAInventoryMovementData::NOTE.name]}'"
    wait_for_element_and_type(bampfa_note_input, data[BAMPFAInventoryMovementData::NOTE.name])
  end

end
