require_relative 'spec_helper'

module Logging

  class << self
    def logger
      @logger ||= Logger.new Config.log_file
      @logger.level = Config.log_level
      @logger
    end

    def logger=(logger)
      @logger = logger
    end
  end

  def self.included(base)
    class << base
      def logger
        Logging.logger
      end
    end
  end

  def logger
    Logging.logger
  end

end
