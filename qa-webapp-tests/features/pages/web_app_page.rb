require_relative '../../spec_helper'

class WebAppPage

  include Logging
  include Page

  def sign_out_link; {link_text: 'Sign out'} end

  def log_out
    wait_for_element_and_click sign_out_link
  end

  def click_link_with_text(text)
    wait_for_element_and_click({link_text: text})
    sleep Config.click_wait
  end

  def click_button_with_text(text)
    wait_for_element_and_click({xpath: "//button[text()='#{text}']"})
    sleep Config.click_wait
  end

  def click_button_with_value(value)
    wait_for_element_and_click({xpath: "//input[@value='#{value}']"})
    sleep Config.click_wait
  end

  def click_checkboxes(boxes)
    boxes.split(', ').each { |box| wait_for_element_and_click({name: box}) }
  end

  def text_in_page_section?(section, text)
    element({css: section}).text.include? text
  end

end
