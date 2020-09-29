require_relative '../../spec_helper'

class WebappSearchPage < WebAppPage

  def search_field_label_loc(label); {xpath: "//div[@id='searchfieldsTarget']//label[text()='#{label}']"} end
  def results_table_header_loc(header); {xpath: "//table[@id='resultsListing']//th[contains(., '#{header}')]"} end
  def berkeley_mapper_button_loc; {id: 'map-bmapper'} end
  def google_map_button_loc; {id: 'map-google'} end
  def summarize_on_select; {id: 'summarizeon'} end

  def enter_search_term(field, term)
    wait_for_element_and_type({id: field}, term)
  end

  def select_auto_complete(option)
    wait_for_element_and_click({xpath: "//li[contains(., \"#{option}\")]"})
  end

  def click_list_button
    wait_for_element_and_click({id: 'search-list'})
  end

  def click_previous
    wait_for_element_and_click({id: 'prev'})
  end

  def click_next
    wait_for_element_and_click({id: 'next'})
  end

  def choose_summarize_field(option)
    opt_loc = {xpath: "//option[text()=\"#{option}\"]"}
    wait_for_element_and_select(summarize_on_select, opt_loc)
  end

  def facets_header_els
    elements({xpath: '//div[@id="facets"]//th[contains(@class, "tablesorter-header")]'})
  end

  def click_image(img_id)
    wait_for_element_and_click({xpath: "//a[contains(@href, '#{img_id}')]"})
  end

end
