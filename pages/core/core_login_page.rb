require_relative '../../spec_helper'

class CoreLoginPage

  include Logging
  include Page
  include CollectionSpacePages

  DEPLOYMENT = Deployment::CORE

  def page_heading; {:xpath => '//h2[contains(.,"CollectionSpace")]'} end
  def username_input; {:id => 'username'} end
  def password_input; {:id => 'password'} end
  def sign_in_button; {:name => 'login'} end

  # Loads the Core homepage
  def load_page
    logger.info 'Loading Core homepage'
    get ConfigCore.base_url
    when_exists(page_heading, Config.medium_wait)
  end

  # Logs in from homepage
  # @param [String] username
  # @param [String] password
  def log_in(username, password)
    logger.info "Logging in as #{username}"
    wait_for_element_and_type(username_input, username)
    wait_for_element_and_type(password_input, password)
    wait_for_element_and_click sign_in_button
    when_exists(sign_out_link, Config.medium_wait)
  end

end
