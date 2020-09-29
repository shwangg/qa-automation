Then(/^I will click an image with id "(.*?)" and observe url contains imageserver$/) do |id|
  @search_page.click_image id
  @search_page.new_window_opens? 'imageserver'
end
