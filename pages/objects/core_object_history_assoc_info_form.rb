module CoreObjectHistoryAssocInfoForm

  include Page
  include Logging
  include CollectionSpacePages

  def obj_history_assoc_info_button; {xpath: "//span[text() = 'Object History and Association Information']"} end
  def ownership_exch_price_value; input_locator([], CoreObjectData::OWNERSHIP_EXCH_PRICE_VALUE.name) end

  def expand_obj_history_assoc_info
    when_exists(obj_desc_info_button, Config.short_wait)
    if visible? ownership_exch_price_value
      logger.debug 'Object history association information is already expanded'
    else
      logger.info 'Expanding the object history association information'
      wait_for_element_and_click(obj_history_assoc_info_button, Config.short_wait)
    end
  end

  def enter_ownership_exch_price_value(data)
    logger.info "Entering ownership exchange price value '#{data[CoreObjectData::OWNERSHIP_EXCH_PRICE_VALUE.name]}'"
    wait_for_element_and_type(ownership_exch_price_value, data[CoreObjectData::OWNERSHIP_EXCH_PRICE_VALUE.name])
  end

end
