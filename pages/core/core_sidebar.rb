require_relative '../../spec_helper'

module CoreSidebar

  include Page
  include Logging

  def section_xpath(label); "//section[contains(.,'#{label}:')]" end
  def section_header_xpath(label); "//header[contains., '#{label}:']" end
  def button_locator(label); {:xpath => "//button[contains(.,'#{label}:')]"} end
  def open_related_button_locator(path); {:xpath => "//a[contains(@href,'/list/#{path}')]"} end
  def add_related_button_locator(path); {:xpath => "//a[contains(@href,'/list/#{path}')]/following-sibling::button"} end
  def expanded_div_locator(label); {:xpath => "#{section_xpath(label)}/div"} end
  def links_locator(label); {:xpath => "#{section_xpath(label)}//a[@role='row']"} end
  def link_locator(label, identifier); {:xpath => "#{section_xpath(label)}//a[contains(.,'#{identifier}')]"} end
  def report_link_locator(label, identifier); {:xpath => "#{section_xpath(label)}//div[contains(@class,'innerScrollContainer')]//div[contains(.,'#{identifier}')]"} end
  def num_per_page_input(label); {:xpath => "#{section_xpath(label)}//input"} end
  def num_per_page_option(label); {:xpath => "#{section_xpath(label)}//input/following-sibling::div//li"} end
  def empty_sidebar_section(label); {:xpath => "#{section_header_xpath(label)}/following-sibling::div//div[@class = 'cspace-ui-SearchResultEmpty--common']"} end 

  def show_sidebar_button; button_locator("Show sidebar") end
  def hide_sidebar_button; button_locator("Hide sidebar") end

  def terms_used_button; button_locator('Terms Used') end
  def terms_used_expanded_div; expanded_div_locator('Terms Used') end
  def terms_used_links; links_locator('Terms Used') end
  def terms_used_term_link(term); link_locator('Terms Used', term) end
  def terms_used_num_per_page_input; num_per_page_input('Terms Used') end
  def terms_used_num_per_page_option; num_per_page_option('Terms Used') end

  def related_obj_button; button_locator('Related Objects') end
  def related_obj_add_button; add_related_button_locator('collectionobject') end
  def related_obj_expanded_div; expanded_div_locator('Related Objects') end
  def related_obj_links; links_locator('Related Objects') end
  def related_obj_link(obj); link_locator('Related Objects', obj) end
  def related_obj_num_per_page_input; num_per_page_input('Related Objects') end
  def related_obj_num_per_page_option; num_per_page_option('Related Objects') end

  def used_by_button; button_locator('Used By') end
  def used_by_expanded_div; expanded_div_locator('Used By') end
  def used_by_links; links_locator('Used By') end
  def used_by_link(identifier); link_locator('Used By', identifier) end

  def related_proc_button; button_locator('Procedures') end
  def related_proc_add_button; add_related_button_locator('procedure') end
  def related_proc_expanded_div; expanded_div_locator('Procedures') end
  def related_proc_links; links_locator('Procedures') end
  def related_proc_link(proc); link_locator('Procedures', proc) end
  def related_proc_num_per_page_input; num_per_page_input('Procedures') end
  def related_proc_num_per_page_option; num_per_page_option('Procedures') end

  def reports_button; button_locator('Reports') end
  def reports_report_link(report); report_link_locator('Reports', report) end
  def reports_num_per_page_input; num_per_page_input('Reports') end
  def reports_num_per_page_options; num_per_page_options('Reports') end
  

  # Makes sure the sidebar is shown
  def show_sidebar
    begin
      wait_for_element_and_click show_sidebar_button
    rescue Selenium::WebDriver::Error::WebDriverError
    end
  end

  # Makes sure a sidebar section is expanded, given a button and input that locate the section
  def expand_sidebar_section(button_locator, num_per_page_locator)
    sleep 1
    begin
      wait_for_element_and_click button_locator
    rescue Selenium::WebDriver::Error::WebDriverError
      scroll_to_top
      wait_for_element_and_click button_locator
    end
    when_displayed(num_per_page_locator, 1)
  rescue
    wait_for_element_and_click button_locator
  end

  # TERMS USED

  # Expands the Terms Used section of the sidebar
  def expand_sidebar_terms_used
    expand_sidebar_section(terms_used_button, terms_used_num_per_page_input)
  end

  # Selects the show '20' option for Terms Used
  def show_twenty_terms
    expand_sidebar_terms_used
    wait_for_options_and_select(terms_used_num_per_page_input, terms_used_num_per_page_option, '20')
  end

  # Clicks the link for a Term in the sidebar
  # @param [String] term
  def click_sidebar_term(term)
    wait_for_element_and_click terms_used_term_link(term)
  end

  # RELATED OBJECTS

  # Expands the Related Objects section of the sidebar
  def expand_sidebar_related_obj
    expand_sidebar_section(related_obj_button, related_obj_num_per_page_input)
  end

  # Selects the show '20' option for Related Objects
  def show_twenty_related_obj
    expand_sidebar_related_obj
    wait_for_options_and_select(related_obj_num_per_page_input, related_obj_num_per_page_option, '20')
  end

  # Clicks the link for an Object in the sidebar
  # @param [String] obj
  def click_sidebar_related_obj(obj)
    wait_for_element_and_click related_obj_link(obj)
  end

  # Clicks the 'Open' button to view related objects
  def click_open_related_object
    wait_for_element_and_click open_related_button_locator('collectionobject')
  end

  # Clicks the 'Add' button the relate an existing object
  def click_add_related_object
    wait_for_element_and_click related_obj_add_button
  end

  # USED BY

  # Expands the Used By section of the sidebar
  def expand_sidebar_used_by
    expand_sidebar_section(used_by_button, used_by_expanded_div)
  end

  # Clicks the link for a Used By record in the sidebar
  # @param [String] identifier - this should match the string under the Record column
  def click_sidebar_used_by(identifier)
    wait_for_element_and_click used_by_link(identifier)
  end

  # RELATED PROCEDURES

  # Expands the Related Procedures section of the sidebar
  def expand_sidebar_related_proc
    expand_sidebar_section(related_proc_button, related_proc_num_per_page_input)
  end

  # Selects the show '20' option for Related Procedures
  def show_twenty_related_proc
    expand_sidebar_related_proc
    wait_for_options_and_select(related_proc_num_per_page_input, related_proc_num_per_page_option, '20')
  end

  # Clicks the 'Open' button to view related procedures
  def click_open_related_procedures
    wait_for_element_and_click open_related_button_locator("procedure")
  end

  # Clicks the Add button to relate two procedures
  def click_add_related_procedure
    wait_for_element_and_click related_proc_add_button
  end

  # Clicks the link for a Related Procedure record in the sidebar
  # @param [String] identifier - this should match the string under the Record column
  def click_sidebar_related_proc(identifier)
    wait_for_element_and_click related_proc_link(identifier)
  end

  # REPORTS

  # Expands the Reports section of the sidebar
  def expand_sidebar_reports
    expand_sidebar_section(reports_button, reports_num_per_page_input)
  end

  # Clicks the link for a Report in the sidebar
  # @param [String] term
  def click_sidebar_report(report)
    wait_for_element_and_click reports_report_link(report)

  end

end
