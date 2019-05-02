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
require_relative 'models/data/supers/objects/object_data'
require_relative "models/data/#{deployment}/#{deployment}_objects/#{deployment}_object_data"
require_relative 'models/data/supers/procedures/acquisition_data'
require_relative 'models/data/supers/procedures/exhibition_data'
require_relative 'models/data/supers/authorities/authority_data'
require_relative "models/data/#{deployment}/#{deployment}_authorities/#{deployment}_authority_data"
require_relative 'models/data/supers/authorities/org_data'
require_relative "models/data/#{deployment}/#{deployment}_authorities/#{deployment}_org_data"
require_relative 'models/user_role'
require_relative 'models/user'

require_relative 'pages/page'
require_relative 'pages/collection_space_pages'
require_relative 'pages/supers/sidebar_pages'

require_relative 'pages/supers/login_page'
require_relative "pages/#{deployment}/#{deployment}_login_page"

require_relative 'pages/supers/search/search_acquisitions_form'
require_relative 'pages/supers/search/search_objects_form'
require_relative 'pages/supers/search/search_page'
require_relative "pages/#{deployment}/#{deployment}_search/#{deployment}_search_acquisitions_form"
require_relative "pages/#{deployment}/#{deployment}_search/#{deployment}_search_objects_form"
require_relative "pages/#{deployment}/#{deployment}_search/#{deployment}_search_page"

require_relative 'pages/supers/search/search_results_page'
require_relative "pages/#{deployment}/#{deployment}_search/#{deployment}_search_results_page"

require_relative 'pages/supers/create_new_page'
require_relative "pages/#{deployment}/#{deployment}_create_new_page"

require_relative 'pages/supers/objects/object_id_info_form'
require_relative 'pages/supers/objects/object_page'
require_relative "pages/#{deployment}/#{deployment}_objects/#{deployment}_object_id_info_form"
require_relative "pages/#{deployment}/#{deployment}_objects/#{deployment}_object_page"

require_relative 'pages/supers/procedures/acquisition_info_form'
require_relative 'pages/supers/procedures/acquisition_page'
require_relative "pages/#{deployment}/#{deployment}_procedures/#{deployment}_acquisition_info_form"
require_relative "pages/#{deployment}/#{deployment}_procedures/#{deployment}_acquisition_page"
require_relative 'pages/supers/procedures/exhibition_info_form'
require_relative 'pages/supers/procedures/exhibition_page'
require_relative "pages/#{deployment}/#{deployment}_procedures/#{deployment}_exhibition_info_form"
require_relative "pages/#{deployment}/#{deployment}_procedures/#{deployment}_exhibition_page"

require_relative 'pages/supers/authorities/authority_page'
require_relative 'pages/supers/authorities/organization_info_form'
require_relative 'pages/supers/authorities/organization_page'
require_relative "pages/#{deployment}/#{deployment}_authorities/#{deployment}_authority_page"
require_relative "pages/#{deployment}/#{deployment}_authorities/#{deployment}_organization_info_form"
require_relative "pages/#{deployment}/#{deployment}_authorities/#{deployment}_organization_page"
