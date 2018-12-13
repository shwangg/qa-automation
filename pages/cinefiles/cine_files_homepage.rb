require_relative '../../spec_helper'

class CineFilesHomepage < Homepage

  include Logging
  include Page

  DEPLOYMENT = Deployment::CINE_FILES

  HEADING = {:xpath => '//h2[contains(.,"CineFiles CollectionSpace")]'}

  def initialize(driver)
    @driver = driver
  end

  # Loads the CineFiles homepage
  def load_page
    logger.info 'Loading CineFiles homepage'
    get ConfigCineFiles.base_url
    when_exists(HEADING, Config.medium_wait)
  end

end
