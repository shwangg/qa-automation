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

require_relative 'logging'
require_relative 'config/web_driver_manager'
require_relative 'config/test_config'

require_relative 'models/data/collection_space_data'
require_relative 'models/data/core/core_authorities/core_authority_type'
require_relative 'models/data/core/core_authorities/core_authority_data'
require_relative 'models/data/core/core_authorities/core_citation_data'
require_relative 'models/data/core/core_authorities/core_concept_data'
require_relative 'models/data/core/core_authorities/core_org_data'
require_relative 'models/data/core/core_authorities/core_person_data'
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
require_relative 'pages/sidebar'
require_relative 'pages/login_page'
require_relative 'pages/create_new_page'

require_relative 'pages/admin/admin_page'
require_relative 'pages/authorities/authority_page'
require_relative 'pages/authorities/citation/citation_page'
require_relative 'pages/authorities/concept/concept_page'
require_relative 'pages/authorities/organization//core_organization_info_form'
require_relative 'pages/authorities/organization/organization_page'
require_relative 'pages/authorities/person/core_person_info_form'
require_relative 'pages/authorities/person/person_page'
require_relative 'pages/authorities/place/place_page'
require_relative 'pages/authorities/storage/storage_page'
require_relative 'pages/authorities/taxon/botgarden_taxon_info_form'
require_relative 'pages/authorities/taxon/taxon_page'
require_relative 'pages/authorities/work/work_page'

require_relative 'pages/objects/core_object_desc_info_form'
require_relative 'pages/objects/core_object_history_assoc_info_form'
require_relative 'pages/objects/core_object_id_info_form'
require_relative 'pages/objects/botgarden_object_id_info_form'
require_relative 'pages/objects/pahma_object_id_info_form'
require_relative 'pages/objects/bampfa_object_id_info_form'
require_relative 'pages/objects/object_page'

require_relative 'pages/procedures/acquisition/core_acquisition_info_form'
require_relative 'pages/procedures/acquisition/pahma_accession_info_form'
require_relative 'pages/procedures/acquisition/acquisition_page'
require_relative 'pages/procedures/condition_check/core_condition_check_info_form'
require_relative 'pages/procedures/condition_check/pahma_condition_check_tech_assess_info_form'
require_relative 'pages/procedures/condition_check/condition_check_page'
require_relative 'pages/procedures/conservation/core_conservation_info_form'
require_relative 'pages/procedures/conservation/conservation_page'
require_relative 'pages/procedures/exhibition/core_exhibition_info_form'
require_relative 'pages/procedures/exhibition/exhibition_page'
require_relative 'pages/procedures/group/core_group_info_form'
require_relative 'pages/procedures/group/group_page'
require_relative 'pages/procedures/intake/core_intake_info_form'
require_relative 'pages/procedures/intake/intake_page'
require_relative 'pages/procedures/inventory_movement/core_inventory_movement_info_form'
require_relative 'pages/procedures/inventory_movement/botgarden_current_location_info_form'
require_relative 'pages/procedures/inventory_movement/pahma_inventory_movement_info_form'
require_relative 'pages/procedures/inventory_movement/bampfa_inventory_movement_info_form'
require_relative 'pages/procedures/inventory_movement/inventory_movement_page'
require_relative 'pages/procedures/loan_in/core_loan_in_info_form'
require_relative 'pages/procedures/loan_in/loan_in_page'
require_relative 'pages/procedures/loan_out/core_loan_out_info_form'
require_relative 'pages/procedures/loan_out/loan_out_page'
require_relative 'pages/procedures/media_handling/core_media_handling_info_form'
require_relative 'pages/procedures/media_handling/media_handling_page'
require_relative 'pages/procedures/nagpra_claim/nagpra_claim_page'
require_relative 'pages/procedures/object_exit/core_object_exit_deaccession_form'
require_relative 'pages/procedures/object_exit/core_object_exit_info_form'
require_relative 'pages/procedures/object_exit/object_exit_page'
require_relative 'pages/procedures/osteology/osteology_page'
require_relative 'pages/procedures/use_of_collections/core_use_of_collections_info_form'
require_relative 'pages/procedures/use_of_collections/pahma_use_of_collections_info_form'
require_relative 'pages/procedures/use_of_collections/use_of_collections_page'
require_relative 'pages/procedures/valuation_control/core_valuation_control_info_form'
require_relative 'pages/procedures/valuation_control/valuation_control_page'

require_relative 'pages/search/core_search_acquisitions_form'
require_relative 'pages/search/pahma_search_accessions_form'
require_relative 'pages/search/core_search_condition_check_form'
require_relative 'pages/search/core_search_conservation_form'
require_relative 'pages/search/core_search_objects_form'
require_relative 'pages/search/core_search_organizations_form'
require_relative 'pages/search/core_search_persons_form'
require_relative 'pages/search/pahma_search_objects_form'
require_relative 'pages/search/search_page'

require_relative 'pages/search_results_page'

require_relative 'pages/tools/tools_page'
require_relative 'pages/tools/invocables_page'

%w(core_ucb bampfa botgarden cinefiles pahma ucjeps).each do |deployment|
  Dir.glob("models/data/#{deployment}/*").each { |file| require_relative file if file.include? '.rb' }
  Dir.glob("models/data/#{deployment}/#{deployment}_authorities/*").each { |file| require_relative file if file.include? '.rb' }
  Dir.glob("models/data/#{deployment}/#{deployment}_objects/*").each { |file| require_relative file if file.include? '.rb' }
  Dir.glob("models/data/#{deployment}/#{deployment}_procedures/*").each { |file| require_relative file if file.include? '.rb' }
  Dir.glob("models/data/#{deployment}/#{deployment}_tools/*").each { |file| require_relative file if file.include? '.rb' }
  require_relative "models/record_types/#{deployment}_record_types.rb"
end
