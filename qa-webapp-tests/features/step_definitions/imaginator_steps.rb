Then(/^I will enter "(.*?)" and click "(.*?)"$/) do |query, button|
  @img_browser_page.search_imaginator(query, button)
end

Then(/^I verify a page only listing images$/) do
    # Screenshot appears; please verify the results of the Search for Images.
    #  screenshot_and_open_image
end
