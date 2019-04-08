require 'rspec'
require 'rspec/core/rake_task'
require 'yaml'
require 'hash_deep_merge'
require 'fileutils'
require 'json'
require 'logger'
require 'selenium-webdriver'

require_relative 'models/deployment'
require_relative 'config/config'

deployment = Config.deployment.code

require_relative "config/config_#{deployment}"
require_relative 'logging'
require_relative 'config/web_driver_manager'
require_relative 'config/test_config'

require_relative 'models/data/collection_space_data'
require_relative 'models/data/object_data'
require_relative "models/data/#{deployment}/#{deployment}_object_data"
require_relative 'models/data/acquisition_data'
require_relative 'models/user_role'
require_relative 'models/user'

require_relative 'pages/page'
require_relative 'pages/collection_space_pages'

require_relative 'pages/supers/login_page'
require_relative "pages/#{deployment}/#{deployment}_login_page"

require_relative 'pages/supers/search_objects_form'
require_relative 'pages/supers/search_acquisitions_form'
require_relative 'pages/supers/search_page'
require_relative "pages/#{deployment}/#{deployment}_search_objects_form"
require_relative "pages/#{deployment}/#{deployment}_search_acquisitions_form"
require_relative "pages/#{deployment}/#{deployment}_search_page"

require_relative 'pages/supers/search_results_page'
require_relative "pages/#{deployment}/#{deployment}_search_results_page"

require_relative 'pages/supers/create_new_page'
require_relative "pages/#{deployment}/#{deployment}_create_new_page"

require_relative 'pages/supers/object_id_info_form'
require_relative 'pages/supers/object_page'
require_relative "pages/#{deployment}/#{deployment}_object_id_info_form"
require_relative "pages/#{deployment}/#{deployment}_object_page"

require_relative 'pages/supers/acquisition_info_form'
require_relative 'pages/supers/acquisition_page'
require_relative "pages/#{deployment}/#{deployment}_acquisition_info_form"
require_relative "pages/#{deployment}/#{deployment}_acquisition_page"
