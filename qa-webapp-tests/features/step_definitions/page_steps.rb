When(/^I click "(.*?)"/) do |link_text|
  @page.click_link_with_text link_text
end

When(/^I open a new window by clicking "(.*?)"/) do |link_text|
  @page.click_link_with_text link_text
  @page.switch_to_new_window
end

When(/^I click the button with value "(.*?)"$/) do |button|
  @page.click_button_with_value button
end

Then(/^I find a link with text "(.*?)"$/) do |link_text|
  expect(@page.exists?({link_text: link_text})).to be true
end

Then(/^I find no link with text "(.*?)"$/) do |link_text|
  expect(@page.exists?({link_text: link_text})).to be false
end

Then(/^I find the value "(.*?)" in "(.*?)"$/) do |value, id|
  expect(@page.element_value({id: id})).to include(value)
end

Then(/^I find the content "(.*?)" in "(.*?)"$/) do |content, section|
  items = content.split(', ')
  sleep 1
  @page.when_exists({css: section}, Config.short_wait)
  @page.wait_until(Config.short_wait) { |i| @page.element({css: section}).text }
  items.each { |item| expect(@page.element({css: section}).text).to include(item) }
end

# TODO Then(/^I see a table with (\d+) headers "([^"]*)" and (\d+) cols "([^"]*)"$/) do |numHeaders, headers, numCols, cols|
#   for header in headers.split(', ')
#     find('tr', text: header).should have_content(header)
#   end
#   for col in cols.split(', ')
#     all('tr', text: col, :between => 3..10)[0].should have_content(col)
#   end
# end

Then(/^"(.*?)" opens in a new window$/) do |title|
  expect(@page.new_window_opens? title).to be true
end

When(/^I go back$/) do
  @page.go_back
end
