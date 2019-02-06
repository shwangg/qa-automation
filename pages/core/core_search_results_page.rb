require_relative '../../spec_helper'

class CoreSearchResultsPage < SearchResultsPage

  include Logging
  include Page
  include CollectionSpacePages

  DEPLOYMENT = Deployment::CORE

  # Checks for the presence of a search results row containing the object number from a test data set
  # @param [Hash] data_set
  # @return [boolean]
  def object_row_exists?(data_set)
    exists? result_row(data_set[CoreObjectData::OBJECT_NUM.name])
  end

  # Clicks a search results row containing the object number from a test data set
  # @param [Hash] data_set
  def click_result(data_set)
    wait_for_element_and_click result_row(data_set[CoreObjectData::OBJECT_NUM.name])
  end

end
