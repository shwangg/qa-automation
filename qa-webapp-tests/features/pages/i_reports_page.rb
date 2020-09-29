require_relative '../../spec_helper'

class IReportsPage < WebAppPage

  def back_button; {xpath: '//input[@value="back"]'} end
  def reports_table_link; {xpath: '//table//a'} end

  def enter_report_search_term(field, query)
    input = {name: field}
    wait_for_element_and_type(input, query)
  end

  def click_back
    # The 'back' button doesn't respond to the driver click() method
    go_back
    sleep Config.click_wait
    go_back
    sleep Config.click_wait
    go_back
    wait_until(Config.medium_wait) { elements(reports_table_link).any? }
  end

end
