require_relative '../../spec_helper'

class BOTGARDENLoginPage < CoreLoginPage

  include Logging
  include Page
  include CollectionSpacePages

  DEPLOYMENT = Deployment::BOTGARDEN

  def page_heading; {:xpath => '//h2[contains(.,"UCBG CollectionSpace")]'} end

  # Loads the BOTGARDEN homepage
  def load_page
    logger.info 'Loading BOTGARDEN homepage'
    get ConfigBOTGARDEN.base_url
    when_exists(page_heading, Config.medium_wait)
  end

end
