When(/^I enter "(.*?)" in "(.*?)" and click "(.*?)"$/) do |query, field, button|
  @search_page.enter_search_term(field, query)
  @search_page.click_button_with_text button
end

When(/^I enter "(.*?)" in the "(.*?)" field$/) do |query, field|
  @search_page.enter_search_term(field, query)
end

When(/^I enter "(.*?)" in the "(.*?)" field and click Search/) do |query, field|
  @i_reports_page.enter_report_search_term(field, query)
  @i_reports_page.click_button_with_value 'Search'
end

Then(/^I click on "(.*?)" in the dropdown menu and search$/) do |text|
  @search_page.select_auto_complete text
  @search_page.click_list_button
end

Then(/^I verify the search fields "(.*?)"$/) do |labels|
  sleep 1
  labels.split(', ').each do |label|
    expect(@search_page.exists?(@search_page.search_field_label_loc label)).to be true
  end
end

Then(/^I verify the table headers "(.*?)"$/) do |headers|
  headers.split(', ').each do |header|
    expect(@search_page.when_displayed(@search_page.results_table_header_loc(header), Config.short_wait)).to be_truthy
  end
end

Then(/^I will click the arrows to toggle between pages$/) do
  @search_page.click_next
  expect(@search_page.text_in_page_section?('div#searchfieldsTarget', 'Keyword')).to be true
  @search_page.click_previous
  expect(@search_page.text_in_page_section?('div#searchfieldsTarget', 'Keyword')).to be true
end

Then (/^I click the button "(.*?)" and download the csv file$/) do |button|
  @search_page.click_button_with_text button
end

Then (/^I click the button "(.*?)"$/) do |button|
  @search_page.click_button_with_text button
end

Then(/^I will click the up and down arrows beside the headers without knowing table name$/) do
  @search_page.facets_header_els.each { |el| el.click }
end

Then(/^I will click on a value "([^"]*)" and see it appear in the field "([^"]*)"$/) do |val, field|
  @search_page.click_link_with_text val
  expect(@search_page.element_value({id: field})).to eql(val)
end

Then(/^I verify the maps buttons$/) do
  expect(@search_page.exists? @search_page.berkeley_mapper_button_loc).to be true
  expect(@search_page.exists? @search_page.google_map_button_loc).to be true
end

Then(/^I will select "([^"]*)" under Select field to summarize on$/) do |field|
  @search_page.choose_summarize_field field
  @search_page.click_button_with_text "Display Summary"
  sleep 1
end

Then(/^I will click "(.*?)" and the "([^"]*)" field should have "([^"]*)"$/) do |button, field, result|
  @search_page.click_button_with_text button
  expect(@search_page.element_value({id: field})).to eql(result)
end

Then(/^I will click "(.*?)" and the "([^"]*)" select should have visible option "([^"]*)"$/) do |button, select, option_value|
  @search_page.click_button_with_text button
  expect(@search_page.visible?({xpath: "//select[@id=\"#{select}\"]/option[text()=\"#{option_value}\"]"})).to be true
end

And(/^I verify the contents of the page$/) do 
    # Screenshot appears; please verify the results are in Full display
    # screenshot_and_open_image
end

Then(/^I mark the checkboxes "(.*?)"$/) do |boxes|
  @search_page.click_checkboxes boxes
end
