require_relative '../spec_helper'

class UserRole

  attr_accessor :name

  def initialize(name)
    @name = name
  end

  ROLES = [
      ADMIN = new('admin')
  ]

end
