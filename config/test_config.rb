require_relative '../spec_helper'

class TestConfig < Config

  include Logging

  attr_reader :deployment, :driver

  def initialize
    @deployment = Config.deployment
  end

  def set_driver(driver)
    @driver = driver
  end

  # Returns the page object associated with the deployment configured for testing. For example, if testing the Core create new object
  # page, returns an object of the Core sub-class of the create new object page. This allows the same set of tests to interact with
  # different versions of the same UI.
  # @param [Class] super_klass
  # @return [Object]
  def get_page(super_klass)
    subs = ObjectSpace.each_object(Class).select { |klass| klass < super_klass }
    sub = subs.find { |p| p::DEPLOYMENT == @deployment }
    sub.new @driver
  end

  # Returns an array of test users associated with the deployment configured for testing
  # @return [Array<User>]
  def get_users
    [Config.admin_user(@deployment)]
  end

  # Returns the admin usr
  # @return [User]
  def get_admin_user
    get_users.find { |u| u.role == UserRole::ADMIN }
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
    File.join(ENV['HOME'], "/qa-automation/test-data/#{deployment.code}/#{file_name}")
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
  def create_object_test_data
    parse_test_data(@deployment, 'test-data-create-new-object.json')['objects']
  end

end
