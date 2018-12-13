require_relative '../../spec_helper'

class UCJEPSHomepage < Homepage

  include Logging
  include Page

  HEADING = {:xpath => '//h2[contains(.,"UCJEPS CollectionSpace")]'}

  DEPLOYMENT = Deployment::UCJEPS

  def initialize(driver)
    @driver = driver
  end

  # Loads the UCJEPS homepage
  def load_page
    logger.info 'Loading UCJEPS homepage'
    get ConfigUCJEPS.base_url
    when_exists(HEADING, Config.medium_wait)
  end

end
