require_relative '../spec_helper'

class ConfigCore < Config

  def ConfigCore.base_url
    Config.base_url Deployment::CORE
  end

  def ConfigCore.admin
    Config.admin_user Deployment::CORE
  end

end
