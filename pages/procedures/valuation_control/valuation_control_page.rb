class ValuationControlPage

  include Logging
  include Page
  include CollectionSpacePages
  include Sidebar
  include CoreValuationControlInfoForm

  # Enters new valuation control data, save it, and wait for a delete button to appear
  # @param [Hash] data_set
  # @return [Array<Object>]
  def create_new_valuation_control(data_set)
    enter_valuation_control_info_data data_set
    click_save_button
    when_exists(delete_button, Config.short_wait)
  end

  def enter_number_and_text(data)
    enter_valuation_control_ref_num data
    enter_value_note data
  end

  def enter_number(data)
    enter_valuation_control_ref_num data
  end

end
