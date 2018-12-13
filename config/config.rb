require_relative '../spec_helper'

class Config

  default_settings = File.join(File.dirname(File.absolute_path(__FILE__)), 'settings.yml')
  override_settings = File.join(File.join(ENV['HOME'], '.cspace-selenium-config/'), 'settings.yml')

  @global_settings = {}
  @global_settings.merge! YAML.load_file(default_settings)
  @global_settings.deep_merge! YAML.load_file(override_settings)

  def Config.global_settings
    @global_settings
  end

  # BROWSER

  def Config.webdriver_settings
    settings = @global_settings['webdriver']
    {
      :browser => settings['browser'],
      :headless => settings['headless']
    }
  end

  # LOGGING

  def Config.log_level
    const_get @global_settings['log_level']
  end

  def Config.log_file
    log_dir = 'tmp/selenium-log'
    FileUtils.mkdir_p log_dir
    File.join(log_dir, "#{Time.now.strftime('%Y-%m-%d')}.log")
  end

  # TIMEOUTS

  def Config.short_wait
    @global_settings['timeout']['short']
  end

  def Config.medium_wait
    @global_settings['timeout']['medium']
  end

  # MUSEUM SPECIFIC SETTINGS

  def Config.deployment
    Deployment::DEPLOYMENTS.find { |m| m.code == @global_settings['deployment'] }
  end

  def Config.base_url(deployment)
    @global_settings[deployment.code]['base_url']
  end

  def Config.admin_user(deployment)
    settings = @global_settings[deployment.code]
    admin_data = settings[UserRole::ADMIN.name]
    User.new({:username => admin_data['username'], :password => admin_data['password'], :role => UserRole::ADMIN})
  end

end
