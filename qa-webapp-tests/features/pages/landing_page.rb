require_relative '../../spec_helper'

class LandingPage < WebAppPage

  include Logging
  include Page

  def apps_available_h1; {xpath: '//h1[text()="Applications Available"]'} end
  def sign_in_link; {link_text: 'Sign in'} end
  def user_icon; {xpath: '//img[contains(@src, "usericon.jpg")]'} end

  def load_page(institution)
    get "#{Config.webapps_base_url}/#{institution}"
    when_displayed(apps_available_h1, Config.short_wait)
  end

  def click_sign_in
    wait_for_element_and_click sign_in_link
  end

  def click_app(app_name)
    click_link_with_text app_name
  end

end
