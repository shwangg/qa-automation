require_relative '../../spec_helper'

class PAHMALoginPage < CoreUCBLoginPage

  include Logging
  include Page
  include CollectionSpacePages

  DEPLOYMENT = Deployment::PAHMA

  def page_heading; {:xpath => '//h2[contains(.,"PAHMA CollectionSpace")]'} end

  # Loads the PAHMA homepage
  def load_page
    logger.info 'Loading PAHMA homepage'
    get ConfigPAHMA.base_url
    when_exists(page_heading, Config.medium_wait)
  end

end
