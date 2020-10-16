require_relative '../spec_helper'

class Deployment

  attr_accessor :name, :code

  def initialize(name, code)
    @name = name
    @code = code
  end

  DEPLOYMENTS = [
      BAMPFA = new('BAMPFA', 'bampfa'),
      BOTGARDEN = new('BOTGARDEN', 'botgarden'),
      CINEFILES = new('CINEFILES', 'cinefiles'),
      CORE = new('Core', 'core'),
      CORE_UCB = new('Core', 'core_ucb'),
      PAHMA = new('PAHMA', 'pahma'),
      UCJEPS = new('UCJEPS', 'ucjeps')
  ]

end
