require_relative '../../spec_helper'

class LoginPage < WebAppPage

  def username_input; {name: 'username'} end
  def password_input; {name: 'password'} end
  def sign_in_button; {xpath: '//input[@value="Sign In"]'} end

  def log_in(username, password)
    logger.info 'Logging in'
    wait_for_element_and_type(username_input, username)
    wait_for_element_and_type(password_input, password)
    wait_for_element_and_click sign_in_button
    when_displayed(sign_out_link, Config.short_wait)
  end

end
