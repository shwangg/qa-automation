require_relative '../../spec_helper'

module PAHMAPages

  include Logging
  include Page
  include CollectionSpacePages

  def movement_secondary_tab; {:xpath => '//button[text()="Inventory/Movement"]'} end

  def click_movement_secondary_tab
    logger.info 'Clicking the secondary Movement tab'
    wait_for_element_and_click(movement_secondary_tab, 2)
  rescue
    select_related_type 'Inventory/Movement'
  end

end
