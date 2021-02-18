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
require_relative 'models/data/core/core_authorities/core_authority_type'
require_relative 'models/data/core/core_authorities/core_authority_data'
require_relative 'models/data/core/core_authorities/core_citation_data'
require_relative 'models/data/core/core_authorities/core_concept_data'
require_relative 'models/data/core/core_authorities/core_org_data'
require_relative 'models/data/core/core_objects/core_object_data'
require_relative 'models/data/core/core_procedures/core_acquisition_data'
require_relative 'models/data/core/core_procedures/core_condition_check_data'
require_relative 'models/data/core/core_procedures/core_conservation_data'
require_relative 'models/data/core/core_procedures/core_current_location_data'
require_relative 'models/data/core/core_procedures/core_exhibition_data'
require_relative 'models/data/core/core_procedures/core_group_data'
require_relative 'models/data/core/core_procedures/core_intake_data'
require_relative 'models/data/core/core_procedures/core_inventory_movement_data'
require_relative 'models/data/core/core_procedures/core_loan_in_data'
require_relative 'models/data/core/core_procedures/core_loan_out_data'
require_relative 'models/data/core/core_procedures/core_media_handling_data'
require_relative 'models/data/core/core_procedures/core_object_exit_data'
require_relative 'models/data/core/core_procedures/core_procedure_data'
require_relative 'models/data/core/core_procedures/core_use_of_collections_data'
require_relative 'models/data/core/core_procedures/core_valuation_control_data'
require_relative 'models/record_types/core_record_types'
require_relative 'models/user_role'
require_relative 'models/user'
require_relative 'models/data/core/core_tools/core_invocables_data'

require_relative 'pages/page'
require_relative 'pages/collection_space_pages'
require_relative 'pages/core/core_pages'
require_relative 'pages/core/core_sidebar'
require_relative 'pages/core/core_login_page'
require_relative 'pages/core/core_search/core_search_acquisitions_form'
require_relative 'pages/core/core_search/core_search_condition_check_form'
require_relative 'pages/core/core_search/core_search_conservation_form'
require_relative 'pages/core/core_search/core_search_objects_form'
require_relative 'pages/core/core_search/core_search_organizations_form'
require_relative 'pages/core/core_search/core_search_page'
require_relative 'pages/core/core_search/core_search_results_page'
require_relative 'pages/core/core_create_new_page'
require_relative 'pages/core/core_authorities/core_authority_page'
require_relative 'pages/core/core_authorities/core_organization_info_form'
require_relative 'pages/core/core_authorities/core_organization_page'
require_relative 'pages/core/core_authorities/core_citation_page'
require_relative 'pages/core/core_authorities/core_concept_page'
require_relative 'pages/core/core_authorities/core_person_page'
require_relative 'pages/core/core_authorities/core_place_page'
require_relative 'pages/core/core_authorities/core_storage_page'
require_relative 'pages/core/core_authorities/core_work_page'
require_relative 'pages/core/core_objects/core_object_desc_info_form'
require_relative 'pages/core/core_objects/core_object_id_info_form'
require_relative 'pages/core/core_objects/core_object_history_assoc_info_form'
require_relative 'pages/core/core_objects/core_object_page'
require_relative 'pages/core/core_procedures/core_acquisition_info_form'
require_relative 'pages/core/core_procedures/core_acquisition_page'
require_relative 'pages/core/core_procedures/core_condition_check_info_form'
require_relative 'pages/core/core_procedures/core_condition_check_page'
require_relative 'pages/core/core_procedures/core_conservation_info_form'
require_relative 'pages/core/core_procedures/core_conservation_page'
require_relative 'pages/core/core_procedures/core_current_location_info_form'
require_relative 'pages/core/core_procedures/core_current_location_page'
require_relative 'pages/core/core_procedures/core_exhibition_info_form'
require_relative 'pages/core/core_procedures/core_exhibition_page'
require_relative 'pages/core/core_procedures/core_group_info_form'
require_relative 'pages/core/core_procedures/core_group_page'
require_relative 'pages/core/core_procedures/core_intake_info_form'
require_relative 'pages/core/core_procedures/core_intake_page'
require_relative 'pages/core/core_procedures/core_inventory_movement_info_form'
require_relative 'pages/core/core_procedures/core_inventory_movement_page'
require_relative 'pages/core/core_procedures/core_loan_in_info_form'
require_relative 'pages/core/core_procedures/core_loan_in_page'
require_relative 'pages/core/core_procedures/core_loan_out_info_form'
require_relative 'pages/core/core_procedures/core_loan_out_page'
require_relative 'pages/core/core_procedures/core_media_handling_info_form'
require_relative 'pages/core/core_procedures/core_media_handling_page'
require_relative 'pages/core/core_procedures/core_object_exit_deaccession_form'
require_relative 'pages/core/core_procedures/core_object_exit_info_form'
require_relative 'pages/core/core_procedures/core_object_exit_page'
require_relative 'pages/core/core_procedures/core_use_of_collections_info_form'
require_relative 'pages/core/core_procedures/core_use_of_collections_page'
require_relative 'pages/core/core_procedures/core_valuation_control_info_form'
require_relative 'pages/core/core_procedures/core_valuation_control_page'
require_relative 'pages/core/core_procedures/core_valuation_info_form'
require_relative 'pages/core/core_procedures/core_valuation_page'
require_relative 'pages/core/core_tools/core_tools_page'
require_relative 'pages/core/core_tools/core_invocables_page'
require_relative 'pages/core/core_admin/core_admin_page'

Dir.glob("config/config_*").each { |file| require_relative file if file.include? '.rb' }

%w(core_ucb bampfa botgarden cinefiles pahma ucjeps).each do |deployment|
  Dir.glob("models/data/#{deployment}/*").each { |file| require_relative file if file.include? '.rb' }
  Dir.glob("models/data/#{deployment}/#{deployment}_authorities/*").each { |file| require_relative file if file.include? '.rb' }
  Dir.glob("models/data/#{deployment}/#{deployment}_objects/*").each { |file| require_relative file if file.include? '.rb' }
  Dir.glob("models/data/#{deployment}/#{deployment}_procedures/*").each { |file| require_relative file if file.include? '.rb' }
  Dir.glob("models/data/#{deployment}/#{deployment}_tools/*").each { |file| require_relative file if file.include? '.rb' }
  require_relative "models/record_types/#{deployment}_record_types.rb"

  Dir.glob("pages/#{deployment}/*").each { |file| require_relative file if file.include? '.rb' }
  Dir.glob("pages/#{deployment}/#{deployment}_admin/*page.rb").each { |file| require_relative file }
  Dir.glob("pages/#{deployment}/#{deployment}_authorities/*form.rb").each { |file| require_relative file }
  Dir.glob("pages/#{deployment}/#{deployment}_authorities/*page.rb").each { |file| require_relative file }
  Dir.glob("pages/#{deployment}/#{deployment}_objects/*form.rb").each { |file| require_relative file }
  Dir.glob("pages/#{deployment}/#{deployment}_objects/*page.rb").each { |file| require_relative file }
  Dir.glob("pages/#{deployment}/#{deployment}_procedures/*form.rb").each { |file| require_relative file }
  Dir.glob("pages/#{deployment}/#{deployment}_procedures/*page.rb").each { |file| require_relative file }
  Dir.glob("pages/#{deployment}/#{deployment}_search/*form.rb").each { |file| require_relative file }
  Dir.glob("pages/#{deployment}/#{deployment}_search/*page.rb").each { |file| require_relative file }
  Dir.glob("pages/#{deployment}/#{deployment}_tools/*form.rb").each { |file| require_relative file }
  Dir.glob("pages/#{deployment}/#{deployment}_tools/*page.rb").each { |file| require_relative file }
end
