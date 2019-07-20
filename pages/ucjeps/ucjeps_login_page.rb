require_relative '../../spec_helper'

class UCJEPSLoginPage < CoreLoginPage

  DEPLOYMENT = Deployment::UCJEPS

  def page_heading; {:xpath => '//h2[contains(.,"UCJEPS CollectionSpace")]'} end

  # Loads the UCJEPS homepage
  def load_page
    logger.info 'Loading UCJEPS homepage'
    get ConfigUCJEPS.base_url
    when_exists(page_heading, Config.medium_wait)
  end

end
