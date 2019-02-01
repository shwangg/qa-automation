require_relative '../../spec_helper'

class LoginPage

  include Logging
  include Page
  include CollectionSpacePages

  def username_input; {:id => 'username'} end
  def password_input; {:id => 'password'} end
  def sign_in_button; {:name => 'login'} end

  # Logs in from homepage
  # @param [String] username
  # @param [String] password
  def log_in(username, password)
    logger.info "Logging in as #{username}"
    wait_for_element_and_type(username_input, username)
    wait_for_element_and_type(password_input, password)
    wait_for_element_and_click sign_in_button
    when_exists(sign_out_link, Config.short_wait)
  end

end
