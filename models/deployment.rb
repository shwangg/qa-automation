require_relative '../spec_helper'

class Deployment

  attr_accessor :name, :code

  def initialize(name, code)
    @name = name
    @code = code
  end

  DEPLOYMENTS = [
      CORE = new('Core', 'core'),
      PAHMA = new('PAHMA', 'pahma')
  ]

end
