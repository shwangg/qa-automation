require_relative '../../spec_helper'

class CoreLoginPage < LoginPage

  include Logging
  include Page
  include CollectionSpacePages

  DEPLOYMENT = Deployment::CORE

  def page_heading; {:xpath => '//h2[contains(.,"CollectionSpace")]'} end

  # Loads the Core homepage
  def load_page
    logger.info 'Loading Core homepage'
    get ConfigCore.base_url
    when_exists(page_heading, Config.medium_wait)
  end

end
