require_relative '../spec_helper'

class ConfigCineFiles < Config

  def ConfigCineFiles.base_url
    Config.base_url Deployment::CINE_FILES
  end

  def ConfigCineFiles.admin
    Config.admin_user Deployment::CINE_FILES
  end

end
