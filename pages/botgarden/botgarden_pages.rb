require_relative '../../spec_helper'

module BOTGARDENPages

  include Logging
  include Page
  include CollectionSpacePages

  def current_locations_tab; {:xpath => '//button[text()="Current Locations"]'} end
  def primary_tab; {:xpath => '//button[text()="Primary Record"]'} end
  def related_panel_rows; {:xpath => '//div[contains(@class,"cspace-ui-RelatedRecordBrowser")]//div[@class="cspace-ui-SearchResultTable--common"]//*[@aria-label="row"]'} end
  def nth_result_row(value); {:xpath => "//div[@class=\"cspace-ui-SearchResultTable--common\"]//*[@aria-label=\"row\"][#{value}]"} end

  # Clicks the Primary Record tab on a record
  def click_primary_record_tab
    logger.info 'Clicking the primary record tab'
    wait_for_element_and_click primary_tab
  end

  #Clicks the secondary 'Current Locations' tab on a record
  def click_current_locations_tab
    logger.info 'Clicking the secondary Current Locations tab'
    when_displayed(primary_tab, Config.short_wait)
    wait_for_element_and_click(current_locations_tab, 2)
  rescue
    select_related_type 'Current Locations'
  end

end
