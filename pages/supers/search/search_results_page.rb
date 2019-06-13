require_relative '../../../spec_helper'

class SearchResultsPage

  include Logging
  include Page
  include CollectionSpacePages

  def result_rows; {:xpath => '//div[@class="cspace-ui-SearchResultTable--common"]//*[@aria-label="row"]'} end
  def no_results_msg; {:xpath => '//span[text()="No records found"]'} end
  def related_selected_button; {:name => 'relate'} end

  def result_row(id)
    {:xpath => "//div[@class=\"cspace-ui-SearchResultTable--common\"]//*[@aria-label=\"row\"][contains(.,\"#{id}\")]"}
  end

  # Checks whether the page header contains the keyword searched
  # @param [String] keyword
  # @return [boolean]
  def keyword_condition_present?(keyword)
    exists?({:xpath => "//h1[contains(.,\"#{keyword}\")]"})
  end

  # Checks whether a search parameter is included in the list of conditions applied
  # @param [String] condition
  # @return [boolean]
  def field_condition_present?(condition)
    exists?({:xpath => "//div[contains(@class,\"FieldConditionInput\")]//div[text()=\"#{condition}\"]"})
  end

  # Waits for search result rows to be present
  def wait_for_results
    wait_until(Config.medium_wait) { elements(result_rows).any? }
  end

  # Checks for the presence of a search results row containing the object number from a test data set
  # @param [Hash] data_set
  # @return [boolean]
  def object_row_exists?(data_set)
    exists? result_row(data_set[ObjectData::OBJECT_NUM.name])
  end

  # Clicks a search results row containing a given string
  # @param [String] unique_identifier
  def click_result(unique_identifier)
    wait_for_results
    wait_for_page_and_click result_row(unique_identifier)
  end

  # Clicks the checkbox for a search result row
  # @param [String] identifier
  def select_result_row(identifier)
    wait_for_element_and_click({:xpath => "//div[@class=\"cspace-ui-SearchResultTable--common\"]//div[@aria-label=\"row\"][contains(.,\"#{identifier}\")]//input"})
  end

  # Selects search result rows and clicks the 'Relate' button
  # @param [Array<String>] identifiers
  def relate_records(identifiers)
    identifiers.each do |identifier|
      wait_for_element_and_click({:xpath => "//div[@class=\"cspace-ui-SearchResultTable--common\"]//div[@aria-label=\"row\"][contains(.,\"#{identifier}\")]//input"})
    end
    wait_for_element_and_click related_selected_button
    wait_for_notification 'related to'
  end
end
