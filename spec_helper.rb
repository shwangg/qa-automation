require 'rspec'
require 'rspec/core/rake_task'
require 'yaml'
require 'hash_deep_merge'
require 'fileutils'
require 'json'
require 'logger'
require 'selenium-webdriver'

require_relative 'models/deployment'
require_relative 'models/data/object_data'
require_relative 'models/data/core/core_object_data'
require_relative 'models/user_role'
require_relative 'models/user'

require_relative 'config/config'
require_relative 'config/config_core'
require_relative 'logging'
require_relative 'config/web_driver_manager'
require_relative 'config/test_config'

require_relative 'pages/page'
require_relative 'pages/collection_space_pages'

require_relative 'pages/supers/login_page'
require_relative 'pages/core/core_login_page'

require_relative 'pages/supers/search_page'
require_relative 'pages/core/core_search_page'

require_relative 'pages/supers/search_results_page'
require_relative 'pages/core/core_search_results_page'

require_relative 'pages/supers/create_new_page'
require_relative 'pages/core/core_create_new_page'

require_relative 'pages/supers/object_id_info_form'
require_relative 'pages/supers/object_page'
require_relative 'pages/core/core_object_id_info_form'
require_relative 'pages/core/core_object_page'
