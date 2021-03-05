require_relative 'spec_helper'

begin

  # These opts will show test progress in the terminal as well as output the results to a file.

  opts = "--format progress --format documentation --out #{Config.test_results} --no-color"

  task default: :cspace
  RSpec::Core::RakeTask.new(:cspace) do |t|
    t.rspec_opts = opts
  end

  task default: :cspace_ucb
  RSpec::Core::RakeTask.new(:cspace_ucb) do |t|
    t.pattern = ENV['SCRIPTS'] ? "spec/ucb/*/*#{ENV['SCRIPTS']}*" : 'spec/ucb/*/*.rb'
    t.rspec_opts = opts
  end

end
