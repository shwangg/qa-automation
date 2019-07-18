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
require_relative 'config/config_core'

require_relative 'logging'
require_relative 'config/web_driver_manager'
require_relative 'config/test_config'

require_relative 'models/data/collection_space_data'
require_relative 'models/data/core/core_authorities/core_authority_data'
require_relative 'models/data/core/core_authorities/core_org_data'
require_relative 'models/data/core/core_objects/core_object_data'
require_relative 'models/data/core/core_procedures/core_acquisition_data'
require_relative 'models/data/core/core_procedures/core_exhibition_data'
require_relative 'models/data/core/core_procedures/core_use_of_collections_data'
require_relative 'models/user_role'
require_relative 'models/user'

require_relative 'pages/page'
require_relative 'pages/collection_space_pages'
require_relative 'pages/core/sidebar_pages'
require_relative 'pages/core/core_login_page'
require_relative 'pages/core/core_search/core_search_acquisitions_form'
require_relative 'pages/core/core_search/core_search_objects_form'
require_relative 'pages/core/core_search/core_search_page'
require_relative 'pages/core/core_search/core_search_results_page'
require_relative 'pages/core/core_create_new_page'
require_relative 'pages/core/core_authorities/core_authority_page'
require_relative 'pages/core/core_authorities/core_organization_info_form'
require_relative 'pages/core/core_authorities/core_organization_page'
require_relative 'pages/core/core_objects/core_object_id_info_form'
require_relative 'pages/core/core_objects/core_object_page'
require_relative 'pages/core/core_procedures/core_acquisition_info_form'
require_relative 'pages/core/core_procedures/core_acquisition_page'
require_relative 'pages/core/core_procedures/core_exhibition_info_form'
require_relative 'pages/core/core_procedures/core_exhibition_page'
require_relative 'pages/core/core_procedures/core_use_of_collections_info_form'
require_relative 'pages/core/core_procedures/core_use_of_collections_page'

deployment = Config.deployment.code

unless deployment == 'core'
  require_relative "config/config_#{deployment}"
  require_relative "models/data/#{deployment}/#{deployment}_authorities/#{deployment}_org_data"
  require_relative "models/data/#{deployment}/#{deployment}_objects/#{deployment}_object_data"
  require_relative "pages/#{deployment}/#{deployment}_login_page"
  require_relative "pages/#{deployment}/#{deployment}_search/#{deployment}_search_acquisitions_form"
  require_relative "pages/#{deployment}/#{deployment}_search/#{deployment}_search_objects_form"
  require_relative "pages/#{deployment}/#{deployment}_search/#{deployment}_search_page"
  require_relative "pages/#{deployment}/#{deployment}_search/#{deployment}_search_results_page"
  require_relative "pages/#{deployment}/#{deployment}_create_new_page"
  require_relative "pages/#{deployment}/#{deployment}_objects/#{deployment}_object_id_info_form"
  require_relative "pages/#{deployment}/#{deployment}_objects/#{deployment}_object_page"
  require_relative "pages/#{deployment}/#{deployment}_procedures/#{deployment}_acquisition_info_form"
  require_relative "pages/#{deployment}/#{deployment}_procedures/#{deployment}_acquisition_page"
  require_relative "pages/#{deployment}/#{deployment}_procedures/#{deployment}_exhibition_info_form"
  require_relative "pages/#{deployment}/#{deployment}_procedures/#{deployment}_exhibition_page"
  require_relative "pages/#{deployment}/#{deployment}_procedures/#{deployment}_use_of_collections_page"
  require_relative "pages/#{deployment}/#{deployment}_authorities/#{deployment}_authority_page"
  require_relative "pages/#{deployment}/#{deployment}_authorities/#{deployment}_organization_info_form"
  require_relative "pages/#{deployment}/#{deployment}_authorities/#{deployment}_organization_page"
end
