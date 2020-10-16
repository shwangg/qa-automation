require_relative '../../spec_helper'

class ImageBrowserPage < WebAppPage

  def keyword_input; {name: 'keyword'} end
  def max_results_input; {name: 'maxresults'} end
  def search_button; {xpath: '//input[@value="Search"]'} end
  def search_option_button(option); {xpath: "//input[@value='#{option}']"} end

  def search_imaginator(text, button)
    wait_for_element_and_type(keyword_input, text)
    wait_for_element_and_click search_option_button(button)
  end

  def search_images(text, max)
    wait_for_element_and_type(keyword_input, text)
    wait_for_element_and_type(max_results_input, max)
    wait_for_element_and_click search_button
    sleep 0.5
  end

end
