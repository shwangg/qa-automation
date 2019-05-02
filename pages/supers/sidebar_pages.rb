require_relative '../../spec_helper'

module SidebarPages

  include Page
  include Logging

  def terms_used_button_locator; {:xpath => '//button[contains(.,"Terms Used:")]'} end
  def terms_used_expanded_div_locator; {:xpath => '//section[contains(.,"Terms Used:")]/div'} end
  def terms_used_term_links_locator; {:xpath => '//section[contains(.,"Terms Used:")]//a[@role="row"]'} end
  def terms_used_term_link_locator(term); {:xpath => "//a[contains(.,'#{term}')]"} end

  # Expands the Terms Used section of the sidebar
  def expand_sidebar_terms_used
    scroll_to_top
    wait_for_element_and_click terms_used_button_locator unless exists?(terms_used_expanded_div_locator)
  end

  # Clicks the link for a Term in the sidebar
  # @param [String] term
  def click_sidebar_term(term)
    wait_for_element_and_click terms_used_term_link_locator(term)
  end

end
