require_relative '../spec_helper'

class TestConfig

  include Logging

  attr_reader :deployment

  def initialize(driver)
    @driver = driver
    @deployment = Config.deployment
  end

  def get_page(driver, super_klass)
    subs = super_klass.descendants
    sub = subs.find { |p| p::DEPLOYMENT == @deployment }
    sub.new driver
  end

  def get_users
    case @deployment
      when Deployment::BAMPFA
        [ConfigBAMPFA.admin]
      when Deployment::BOT_GARDEN
        [ConfigBotGarden.admin]
      when Deployment::CINE_FILES
        [ConfigCineFiles.admin]
      when Deployment::CORE
        [ConfigCore.admin]
      when Deployment::PAHMA
        [ConfigPAHMA.admin]
      when Deployment::UCJEPS
        [ConfigUCJEPS.admin]
      else
        logger.error "Invalid deployment '#{@deployment.code}'"
    end

  end
end
