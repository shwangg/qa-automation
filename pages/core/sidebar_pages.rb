require_relative '../../spec_helper'

module SidebarPages

  include Page
  include Logging

  def terms_used_button_locator; {:xpath => '//button[contains(.,"Terms Used:")]'} end
  def terms_used_expanded_div_locator; {:xpath => '//section[contains(.,"Terms Used:")]/div'} end
  def terms_used_term_links_locator; {:xpath => '//section[contains(.,"Terms Used:")]//a[@role="row"]'} end
  def terms_used_term_link_locator(term); {:xpath => "//section[contains(.,\"Terms Used:\")]//a[contains(.,'#{term}')]"} end
  def terms_used_num_per_page_input; {:xpath => '//section[contains(.,"Terms Used:")]//input'} end
  def terms_used_num_per_page_option; {:xpath => '//section[contains(.,"Terms Used:")]//input/following-sibling::div//li'} end

  def used_by_button_locator; {:xpath => '//button[contains(.,"Used By:")]'} end
  def used_by_expanded_div_locator; {:xpath => '//section[contains(.,"Used By:")]/div'} end
  def used_by_links_locator; {:xpath => '//section[contains(.,"Used By:")]//a[@role="row"]'} end
  def used_by_link_locator(identifier); {:xpath => "//section[contains(.,\"Used By:\")]//a[contains(.,'#{identifier}')]"} end

  def related_procedures_add_button; {:xpath => '//a[contains(@href,"/list/procedure")]/following-sibling::button'} end

  # TERMS USED

  # Expands the Terms Used section of the sidebar
  def expand_sidebar_terms_used
    scroll_to_top
    sleep Config.click_wait
    wait_for_element_and_click terms_used_button_locator unless exists?(terms_used_expanded_div_locator)
  end

  # Selects the show '20' option for Terms Used
  def show_twenty_terms
    expand_sidebar_terms_used
    wait_for_options_and_select(terms_used_num_per_page_input, terms_used_num_per_page_option, '20')
  end

  # Clicks the link for a Term in the sidebar
  # @param [String] term
  def click_sidebar_term(term)
    wait_for_element_and_click terms_used_term_link_locator(term)
  end

  # USED BY

  # Expands the Used By section of the sidebar
  def expand_sidebar_used_by
    scroll_to_top
    sleep Config.click_wait
    wait_for_element_and_click used_by_button_locator unless exists?(used_by_expanded_div_locator)
  end

  # Clicks the link for a Used By record in the sidebar
  # @param [String] identifier - this should match the string under the Record column
  def click_sidebar_used_by(identifier)
    wait_for_element_and_click used_by_link_locator(identifier)
  end

  # RELATED PROCEDURES

  # Clicks the Add button to relate two procedures
  def click_add_related_procedure
    wait_for_element_and_click related_procedures_add_button
  end

end
