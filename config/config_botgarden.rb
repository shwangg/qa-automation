require_relative '../spec_helper'

class ConfigBOTGARDEN < Config

  def ConfigBOTGARDEN.base_url
    Config.base_url Deployment::BOTGARDEN
  end

  def ConfigBOTGARDEN.admin
    Config.admin_user Deployment::BOTGARDEN
  end

end
