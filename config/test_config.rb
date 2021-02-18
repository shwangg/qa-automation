require_relative '../spec_helper'

class TestConfig < Config

  include Logging

  attr_accessor :deployment, :driver

  def initialize(deployment=nil)
    @deployment = deployment || Config.deployment
  end

  def set_driver(driver)
    @driver = driver
  end

  # Returns the page object associated with the deployment configured for testing. If testing the Core create new object
  # page, returns an object of the Core class of the create new object page. If another deployment is to be tested, then
  # a sub-class of the Core class should exist with its customized UI references. This allows the same set of tests to
  # interact with different versions of the same UI.
  # @param [Class] core_klass
  # @return [Object]
  def get_page(core_klass)
    if @deployment == Deployment::CORE
      core_klass.new @driver
    else
      subs = ObjectSpace.each_object(Class).select { |klass| klass < core_klass }
      sub = subs.find { |p| p::DEPLOYMENT == @deployment }
      sub.new @driver
    end
  end

  # Returns the admin usr
  # @return [User]
  def get_admin_user
    Config.admin_user @deployment
  end

  # Returns a generic, role-less test user with unique username / password / name
  def get_test_user(test_id)
    Config.test_user test_id
  end

  # Given test data and a key used as ID, sets the epoch as the unique ID for the test
  # @param [Hash] test_data
  # @param [String] key
  # @return [Hash]
  def set_unique_test_id(test_data, key)
    test_data.merge!({key => Time.now.to_i})
  end

  # TEST DATA

  # Returns the file path to default test data maintained in the code
  # @param [Deployment] deployment
  # @param [String] file_name
  # @return [String]
  def default_test_data(deployment, file_name)
    File.join(File.dirname(File.absolute_path(__FILE__)), "/test-data/#{deployment.code}/#{file_name}")
  end

  # Returns the file path to override test data maintained outside the code
  # @param [Deployment] deployment
  # @param [String] file_name
  # @return [String]
  def override_test_data(deployment, file_name)
    File.join(Config.override_settings_dir, "#{deployment.code}/#{file_name}")
  end

  # Returns a hash containing test data. If an override file exists, then uses that. Otherwise, uses the default test data.
  # @param [Deployment] deployment
  # @param [String] file_name
  # @return [Hash]
  def parse_test_data(deployment, file_name)
    file_path = (File.file?(override_test_data(deployment, file_name))) ?
        override_test_data(deployment, file_name) :
        default_test_data(deployment, file_name)
    JSON.parse File.read(file_path)
  end

  # Returns the test data for the 'create object' tests
  # @return [Array<Hash>]
  def create_object_test_data(deployment = nil)
    parse_test_data((deployment || @deployment), 'test-data-create-new-object.json')['objects']
  end

  #added
  def create_autocomplete_term_matching_search_test_data(deployment = nil)
    parse_test_data((deployment || @deployment), 'test-data-autocomplete-term-matching-search.json')['objects']
  end

  def create_data_entry_templates_test_data(deployment = nil)
    parse_test_data((deployment || @deployment), 'test-data-data-entry-templates.json')['objects']
  end

  def create_temporary_test_data(deployment = nil)
    parse_test_data((deployment || @deployment), 'test-data-temporary.json')['objects']
  end

  # Returns the test data for the 'all authorities' tests
  # @return [Array<Hash>]
  def all_authorities_test_data(deployment = nil)
    parse_test_data((deployment || @deployment), 'test-data-all-authorities.json')['organizations']
  end

  # Returns the test data for the 'all procedures' tests
  # @return [Array<Hash>]
  def all_procedures_test_data(deployment = nil)
    parse_test_data((deployment || @deployment), 'test-data-all-procedures.json')['useOfCollections']
  end

  # Returns the test data for the 'inventory movement' tests
  # @return [Array<Hash>]
  def inventory_movement_test_data(deployment = nil)
    parse_test_data((deployment || @deployment), 'test-data-inventory-movement.json')['movements']
  end

  # Returns the test data for the 'numeric fields' tests
  # @return [Array<Hash>]
  def numeric_fields_test_data(deployment = nil)
    parse_test_data((deployment || @deployment), 'test-data-numeric-fields.json')
  end

  # Returns the test data for the 'special characters and formatting' tests
  # @return [Array<Hash>]
  def special_characters_test_data(deployment = nil)
    parse_test_data((deployment || @deployment), 'test-data-special-characters.json')
  end

  # Returns the test data for the 'UpdateDeadFlagListener' Event Listener test
  def update_dead_flag_listener_data(deployment = nil)
    parse_test_data((deployment || @deployment), 'test-data-update-dead-flag.json')
  end

end
