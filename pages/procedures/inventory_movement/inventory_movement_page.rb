class InventoryMovementPage

  include Sidebar
  include CoreInventoryMovementInfoForm
  include PAHMAInventoryMovementInfoForm
  include BOTGARDENCurrentLocationInfoForm

  # Completes the Info form on the page
  # @param [Hash] data
  def complete_info_form(data)
    enter_reference_number data
    enter_normal_location data
    enter_current_location data
    enter_location_date data
  end

  def complete_pahma_info_form(data)
    enter_pahma_current_location data
    enter_location_date data
    enter_pahma_location_handlers data
    enter_pahma_reason data
    enter_pahma_methods data
    enter_pahma_note data
  end

  # Completes the Info form, saves the record, and adds the resulting record's URL to the test data
  # @param [Hash] data
  def create_unlocked_movement(data)
    complete_info_form data
    save_record_only
    data.merge!({:url => url})
  end

  def create_unlocked_pahma_movement(data)
    complete_pahma_info_form data
    save_record_only
    data.merge!({:url => url})
  end

  def enter_number_and_text(data)
    enter_current_location_preset data
    save_record_only
  end
  
  def enter_number(data)
    enter_current_location_preset data
    save_record_only
  end

  def enter_botgarden_current_location_data(data)
    enter_botgarden_action_date data
    select_botgarden_garden_location data
    enter_botgarden_movement_note data
    select_botgarden_action_code data
  end

end
