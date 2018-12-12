require_relative '../spec_helper'

module Config

  def settings
    settings = {}
    default_settings = File.join(File.dirname(File.absolute_path(__FILE__)), 'settings.yml')
    settings.merge! YAML.load_file(default_settings)
  end

  # BROWSER

  def webdriver_settings
    settings['webdriver']
  end

  # LOGGING

  def log_level
    const_get settings['log_level']
  end

  def log_file
    log_dir = 'tmp/selenium-log'
    FileUtils.mkdir_p log_dir
    File.join(log_dir, "#{Time.now.strftime('%Y-%m-%d')}.log")
  end

  # TIMEOUTS

  def short_wait
    settings['timeout']['short']
  end

  def medium_wait
    settings['timeout']['medium']
  end

  # BASE URL

  def base_url
    settings['base_url']
  end

  def base_url_core
    base_url['core']
  end

end
