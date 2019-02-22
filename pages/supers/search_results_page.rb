require_relative '../../spec_helper'

class SearchResultsPage

  include Logging
  include Page
  include CollectionSpacePages

  def result_rows; {:xpath => '//div[@class="cspace-ui-SearchResultTable--common"]//a[contains(@class,"TableRow")]'} end

  def result_row(id)
    {:xpath => "//div[@class=\"cspace-ui-SearchResultTable--common\"]//a[contains(@class,\"TableRow\")][contains(.,\"#{id}\")]"}
  end

  def wait_for_results
    wait_until(Config.short_wait) { elements(result_rows).any? }
  end

  # Checks for the presence of a search results row containing the object number from a test data set
  # @param [Hash] data_set
  # @return [boolean]
  def object_row_exists?(data_set)
    exists? result_row(data_set[ObjectData::OBJECT_NUM.name])
  end

  # Clicks a search results row containing the object number from a test data set
  # @param [Hash] data_set
  def click_result(data_set)
    wait_for_element_and_click result_row(data_set[ObjectData::OBJECT_NUM.name])
  end

end
