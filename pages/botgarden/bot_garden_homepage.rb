require_relative '../../spec_helper'

class BotGardenHomepage < Homepage

  include Logging
  include Page

  DEPLOYMENT = Deployment::BOT_GARDEN

  HEADING = {:xpath => '//h2[contains(.,"UCBG CollectionSpace")]'}

  def initialize(driver)
    @driver = driver
  end

  # Loads the BotGarden homepage
  def load_page
    logger.info 'Loading BotGarden homepage'
    get ConfigBotGarden.base_url
    when_exists(HEADING, Config.medium_wait)
  end

end
