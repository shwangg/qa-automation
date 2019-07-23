require_relative '../spec_helper'

class ConfigUCJEPS < Config

  def ConfigUCJEPS.base_url
    Config.base_url Deployment::UCJEPS
  end

  def ConfigUCJEPS.admin
    Config.admin_user Deployment::UCJEPS
  end

end
