require_relative '../spec_helper'

class ConfigPAHMA < Config

  def ConfigPAHMA.base_url
    Config.base_url Deployment::PAHMA
  end

  def ConfigPAHMA.admin
    Config.admin_user Deployment::PAHMA
  end

end
