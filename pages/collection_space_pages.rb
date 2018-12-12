require_relative '../spec_helper'

module CollectionSpacePages

  include Page
  include Logging

  SIGN_OUT_LINK = {:xpath => '//a[contains(.,"Sign out")]'}

  # Logs out using the sign out link in the header
  def log_out
    logger.info 'Logging out'
    wait_for_element_and_click SIGN_OUT_LINK
  end

end
