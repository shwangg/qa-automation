require_relative '../spec_helper'

class Homepage

  include Logging
  include Page
  include CollectionSpacePages

  USERNAME_INPUT = {:id => 'username'}
  PASSWORD_INPUT = {:id => 'password'}
  SIGN_IN_BUTTON = {:name => 'login'}

  # Returns the sub-classes of Homepage
  # @return [Array<Class>]
  def self.descendants
    ObjectSpace.each_object(Class).select { |klass| klass < self }
  end

  # Logs in from homepage
  # @param [String] username
  # @param [String] password
  def log_in(username, password)
    logger.info "Logging in as #{username}"
    wait_for_element_and_type(USERNAME_INPUT, username)
    wait_for_element_and_type(PASSWORD_INPUT, password)
    wait_for_element_and_click SIGN_IN_BUTTON
    when_exists(SIGN_OUT_LINK, Config.short_wait)
  end

end
