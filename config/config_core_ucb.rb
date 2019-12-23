require_relative '../spec_helper'

class ConfigCoreUCB < Config

  def ConfigCoreUCB.base_url
    Config.base_url Deployment::CORE_UCB
  end

  def ConfigCoreUCB.admin
    Config.admin_user Deployment::CORE_UCB
  end

end
