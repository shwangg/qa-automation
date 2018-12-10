require 'yaml'

class Config

  @settings = {}
  default_settings = File.join(File.dirname(File.absolute_path(__FILE__)), 'settings.yml')
  @settings.merge! YAML.load_file(default_settings)

  def Config.settings
    @settings
  end

end
