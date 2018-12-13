require_relative '../spec_helper'

class ConfigBotGarden < Config

  def ConfigBotGarden.base_url
    Config.base_url Deployment::BOT_GARDEN
  end

  def ConfigBotGarden.admin
    Config.admin_user Deployment::BOT_GARDEN
  end

end
