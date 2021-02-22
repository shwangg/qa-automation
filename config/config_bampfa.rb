require_relative '../spec_helper'

class ConfigBAMPFA < Config

  def ConfigBAMPFA.base_url
    Config.base_url Deployment::BAMPFA
  end

  def ConfigBAMPFA.admin
    Config.admin_user Deployment::BAMPFA
  end

end
