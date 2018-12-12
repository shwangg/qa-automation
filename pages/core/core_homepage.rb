require_relative '../../spec_helper'

module Homepages
  class CoreHomepage

    include Logging
    include Config
    include Page
    include Homepages

    HEADING = {:xpath => '//h2[contains(.,"Welcome to the CollectionSpace Demo")]'}

    attr_reader :driver

    def initialize(driver)
      @driver = driver
    end

    # Loads the Core homepage
    def load_page
      logger.info 'Loading Core homepage'
      get base_url_core
      when_exists(HEADING, medium_wait)
    end

  end
end