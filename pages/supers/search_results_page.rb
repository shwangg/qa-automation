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

end
