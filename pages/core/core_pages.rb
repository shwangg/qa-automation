require_relative '../../spec_helper'

module CorePages

  include Logging
  include Page
  include CollectionSpacePages

  def primary_tab; {:xpath => '//button[text()="Primary Record"]'} end
  def exhibition_tab; {:xpath => '//button[text()="Exhibitions"]'} end
  def movement_secondary_tab; {:xpath => '//button[text()="Location/Movement/Inventory"]'} end
  def close_tab(label); {:xpath => "//button[text() = '#{label}']//following-sibling::button[@aria-label = 'close']"} end

  # Clicks the Primary Record tab on a record
  def click_primary_record_tab
    logger.info 'Clicking the primary record tab'
    wait_for_element_and_click primary_tab
  end

  #Clicks the secondary 'Exhibitions' tab on a record
  def click_exhibitions_tab
    logger.info 'Clicking the secondary Exhibitions tab'
    when_displayed(primary_tab, Config.short_wait)
    wait_for_element_and_click(exhibition_tab, 2)
  rescue
    select_related_type 'Exhibitions'
  end

  # Clicks the secondary 'Location/Movement/Inventory' tab on a record
  def click_movement_secondary_tab
    logger.info 'Clicking the secondary Movement tab'
    when_displayed(primary_tab, Config.short_wait)
    wait_for_element_and_click(movement_secondary_tab, 2)
  rescue
    select_related_type 'Location/Movement/Inventory'
  end

  # Closes the specified secondary tab on a record
  def click_close_tab(label)
    logger.info "Closing the secondary #{label} tab"
    wait_for_element_and_click close_tab(label)
  end
end
