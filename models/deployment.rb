require_relative '../spec_helper'

class Deployment

  attr_accessor :name, :code

  def initialize(name, code)
    @name = name
    @code = code
  end

  DEPLOYMENTS = [
      BAMPFA = new('Berkeley Art Museum and Pacific Film Archive', 'bampfa'),
      BOT_GARDEN = new('UC Botanical Garden', 'botgarden'),
      CINE_FILES = new('CineFiles', 'cinefiles'),
      CORE = new('Core', 'core'),
      PAHMA = new('Phoebe A Hearst Museum of Anthropology', 'pahma'),
      UCJEPS = new('University and Jepson Herbaria', 'ucjeps')
  ]

end
