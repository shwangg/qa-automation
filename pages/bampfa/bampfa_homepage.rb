require_relative '../../spec_helper'

class BAMPFAHomepage < Homepage

  include Logging
  include Page

  DEPLOYMENT = Deployment::BAMPFA

  HEADING = {:xpath => '//h2[contains(.,"BAMPFA CollectionSpace")]'}

  def initialize(driver)
    @driver = driver
  end

  # Loads the BAMPFA homepage
  def load_page
    logger.info 'Loading BAMPFA homepage'
    get ConfigBAMPFA.base_url
    when_exists(HEADING, Config.medium_wait)
  end

end
