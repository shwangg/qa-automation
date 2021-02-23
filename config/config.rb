require_relative '../spec_helper'

class Config

  @override_settings_dir = File.join(ENV['HOME'], '.cspace-selenium-config/')

  default_settings = File.join(File.dirname(File.absolute_path(__FILE__)), 'settings.yml')
  override_settings = File.join(@override_settings_dir, 'settings.yml')

  @global_settings = {}
  @global_settings.merge! YAML.load_file(default_settings)
  @global_settings.deep_merge! YAML.load_file(override_settings) if File.exist? override_settings

  def Config.override_settings_dir
    @override_settings_dir
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

  def Config.test_results
    results_dir = 'tmp/test-results'
    FileUtils.mkdir_p results_dir
    File.join(results_dir, "test-results-#{Time.now.strftime('%Y-%m-%d-%H-%M')}")
  end

  # TIMEOUTS

  def Config.timeouts
    @global_settings['timeout']
  end

  # For inserting a pause before each click, should default to zero but can be used to slow down test execution
  def Config.click_wait
    timeouts['click']
  end

  # Intended for awaiting updates to a loaded page, e.g., Ajax
  def Config.short_wait
    timeouts['short']
  end

  # Intended for awaiting page loads or slow page updates
  def Config.medium_wait
    timeouts['medium']
  end

  # Intended for file uploads and downloads, or asynchronous updates
  def Config.long_wait
    timeouts['long']
  end

  # DEPLOYMENT SPECIFIC SETTINGS

  def Config.base_url(deployment)
    @global_settings[deployment.code]['base_url']
  end

  def Config.webapps_base_url
    @global_settings['webapps_base_url']
  end

  def Config.admin_user(deployment)
    settings = @global_settings[deployment.code]
    role = UserRole.new('TENANT_ADMINISTRATOR', '', deployment)
    role.perms.transform_values! { 'D' }
    User.new({username: settings['admin']['username'], password: settings['admin']['password'], roles: [role]})
  end

  def Config.test_user(test_id)
    User.new(username: "#{test_id}-#{@global_settings['test_user']['username']}",
             password: "#{@global_settings['test_user']['password']}"[0..23],
             roles: [],
             name: "Test User #{test_id}")
  end

end
