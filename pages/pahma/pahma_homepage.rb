require_relative '../../spec_helper'

class PAHMAHomepage < Homepage

  include Logging
  include Page

  DEPLOYMENT = Deployment::PAHMA

  HEADING = {:xpath => '//h2[contains(.,"PAHMA CollectionSpace")]'}

  def initialize(driver)
    @driver = driver
  end

  # Loads the PAHMA homepage
  def load_page
    logger.info 'Loading PAHMA homepage'
    get ConfigPAHMA.base_url
    when_exists(HEADING, Config.medium_wait)
  end

end
