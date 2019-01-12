require_relative '../../spec_helper'

class CoreHomepage < Homepage

  include Logging
  include Page
  include CollectionSpacePages

  def page_heading; {:xpath => '//h2[contains(.,"Welcome to the CollectionSpace Demo")]'} end

  DEPLOYMENT = Deployment::CORE

  # Loads the Core homepage
  def load_page
    logger.info 'Loading Core homepage'
    get ConfigCore.base_url
    when_exists(page_heading, Config.medium_wait)
  end

end
