require_relative '../spec_helper'

class User

  attr_accessor :username, :password, :role

  def initialize(test_data)
    test_data.each { |k, v| public_send("#{k}=", v) }
  end

end
