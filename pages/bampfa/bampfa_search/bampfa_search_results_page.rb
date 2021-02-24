require_relative '../../../spec_helper'

class BAMPFASearchResultsPage < CoreUCBSearchResultsPage

  include Logging
  include Page
  include CollectionSpacePages

  DEPLOYMENT = Deployment::BAMPFA

  # Returns the display name for a search result row
  # @param [Integer] row number
  def name_of_nth_row(value)
    element_text(:xpath => "//div[@class=\"cspace-ui-SearchResultTable--common\"]//*[@aria-label=\"row\"][#{value}]//div[@aria-colindex = 3]")
  end

end
