require_relative '../../spec_helper'

class BMUPage < WebAppPage

  def file_upload_input; {name: 'imagefiles'} end

  def select_file(file_name)
    when_exists(file_upload_input, Config.short_wait)
    element(file_upload_input).send_keys File.expand_path(file_name)
  end

end
