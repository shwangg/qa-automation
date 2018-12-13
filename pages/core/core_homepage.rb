require_relative '../../spec_helper'

class CoreHomepage < Homepage

  include Logging
  include Page

  HEADING = {:xpath => '//h2[contains(.,"Welcome to the CollectionSpace Demo")]'}

  DEPLOYMENT = Deployment::CORE

  def initialize(driver)
    @driver = driver
  end

  # Loads the Core homepage
  def load_page
    logger.info 'Loading Core homepage'
    get ConfigCore.base_url
    when_exists(HEADING, Config.medium_wait)
  end

end
