require_relative '../../spec_helper'

class BAMPFALoginPage < CoreUCBLoginPage

  include Logging
  include Page
  include CollectionSpacePages

  DEPLOYMENT = Deployment::BAMPFA

  def page_heading; {:xpath => '//h2[contains(.,"BAMPFA CollectionSpace")]'} end

  # Loads the BOTGARDEN homepage
  def load_page
    logger.info 'Loading BAMPFA homepage'
    get ConfigBAMPFA.base_url
    when_exists(page_heading, Config.medium_wait)
  end

end
