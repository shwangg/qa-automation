require 'yaml'
require 'fileutils'

class Config

  @settings = {}
  default_settings = File.join(File.dirname(File.absolute_path(__FILE__)), 'settings.yml')
  @settings.merge! YAML.load_file(default_settings)

  def Config.webdriver_settings
    @settings['webdriver']
  end

  def Config.log_level
    const_get @settings['log_level']
  end

  def Config.log_file
    log_dir = 'tmp/selenium-log'
    FileUtils.mkdir_p log_dir
    File.join(log_dir, "#{Time.now.strftime('%Y-%m-%d')}-selenium-log.log")
  end

end
