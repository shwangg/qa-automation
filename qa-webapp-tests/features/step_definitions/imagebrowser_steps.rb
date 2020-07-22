When(/^I search for "([^"]*)" and enter "([^"]*)"$/) do |query, text|
  @img_browser_page.search_images(query, text)
end
