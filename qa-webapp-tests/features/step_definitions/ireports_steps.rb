When(/^I click the back button$/) do
  @i_reports_page.click_back
end

When(/^I enter "(.*?)" in "(.*?)" and click the report button$/) do |query, field|
  @i_reports_page.enter_report_search_term(field, query)
  @i_reports_page.click_button_with_text 'report'
end

Then(/^I will click reset and the "([^"]*)" field should have "([^"]*)"$/) do |field, result|
  @search_page.click_button_with_text 'reset'
  expect(@search_page.element_value({name: field})).to eql(result)
end

Then(/^I will see the correct report in pdf format$/) do
    # Screenshot appears; please verify the results of the Search for Images.
    #  screenshot_and_open_image
    @page.go_back
end

