require_relative '../../spec_helper'

class CoreCreateNewPage

  include Logging
  include Page
  include CollectionSpacePages

  DEPLOYMENT = Deployment::CORE

  def object_link; {:id => 'collectionobject'} end
  def acquisition_link; {:id => 'acquisition'} end
  def exhibition_link; {:id => 'exhibition'} end
  def movement_link; {:id => 'movement'} end
  def media_handling_link; {:id => 'media'} end
  def object_exit_link; {:id => 'objectexit'} end
  def use_of_collections_link; {:id => 'uoc'} end
  def valuation_control_link; {:id => 'valuation'} end
  def authority_org_local_link; {:xpath => '//a[@id="organization/local"]'} end
  def authority_org_ulan_link; {:xpath => '//a[@id="organization/ulan"]'} end
  def condition_check_link; {:id => 'conditioncheck'} end
  def conservation_link; {:id => 'conservation'} end
  def group_link; {:id => 'group'} end
  def intake_link; {:id => 'intake'} end
  def loan_in_link; {:id => 'loanin'} end
  def loan_out_link; {:id => 'loanout'} end
  def media_handling_link; {:id => 'media'} end
  def object_exit_link; {:id => 'objectexit'} end
  def valuation_control_link; {:id => 'valuation'} end
  def authority_citation_local_link; {:xpath => '//a[@id="citation/local"]'} end
  def authority_citation_worldcat_link; {:xpath => '//a[@id="citation/worldcat"]'} end
  def authority_concept_activity_link; {:xpath => '//a[@id="concept/activity"]'} end
  def authority_concept_associated_link; {:xpath => '//a[@id="concept/associated"]'} end
  def authority_concept_material_link; {:xpath => '//a[@id="concept/material"]'} end
  def authority_concept_nomenclature_link; {:xpath => '//a[@id="concept/nomenclature"]'} end
  def authority_concept_occasion_link; {:xpath => '//a[@id="concept/occasion"]'} end
  def authority_person_local_link; {:xpath => '//a[@id="person/local"]'} end
  def authority_person_ulan_link; {:xpath => '//a[@id="person/ulan"]'} end
  def authority_place_local_link; {:xpath => '//a[@id="place/local"]'} end
  def authority_place_tgn_link; {:xpath => '//a[@id="place/tgn"]'} end
  def authority_storage_local_link; {:xpath => '//a[@id="location/local"]'} end
  def authority_storage_offsite_link; {:xpath => '//a[@id="location/offsite"]'} end
  def authority_work_local_link; {:xpath => '//a[@id="work/local"]'} end
  def authority_work_cona_link; {:xpath => '//a[@id="work/cona"]'} end

  # Loads the Create New page with a given base URL
  # @param [String] base_url
  def load_page(base_url)
    get "#{base_url}/create"
    wait_for_title 'Create New'
  end

  # Clicks the link to create a new collection object
  def click_create_new_object
    wait_for_page_and_click object_link
  end

  # Clicks the link to create a new acquisition record
  def click_create_new_acquisition
    wait_for_page_and_click acquisition_link
  end

  # Clicks the link to create a new inventory/movement record
  def click_create_new_movement
    wait_for_page_and_click movement_link
  end

  # Clicks the link to create a new media handling record
  def click_create_new_media
    wait_for_page_and_click media_handling_link
  end

  # Clicks the link to create a new object exit record
  def click_create_new_object_exit
    wait_for_page_and_click object_exit_link
  end

  # Clicks the link to create a new use of collections procedure
  def click_create_new_use_of_collections
    wait_for_page_and_click use_of_collections_link
  end

  # Clicks the link to create a new valuation control record
  def click_create_new_valuation_control
    wait_for_page_and_click valuation_control_link
  end
  
  # Clicks the link to create a new exhibition record
  def click_create_new_exhibition
    wait_for_page_and_click exhibition_link
  end

  # Clicks the link to create a new Local organization
  def click_create_new_org_local
    wait_for_page_and_click authority_org_local_link
  end

  # Clicks the ULAN link to create an organization
  def click_create_new_org_ulan
    wait_for_element_and_click authority_org_ulan_link
  end

  # Clicks the link to create a new condition check
  def click_create_new_condition_check
    wait_for_element_and_click condition_check_link
  end

  # Clicks the link to create a new conservation check
  def click_create_new_conservation_check
    wait_for_element_and_click conservation_link
  end

  # Clicks the link to create a new group record
  def click_create_new_group
    wait_for_element_and_click group_link
  end

  # Clicks the link to create a new intake record
  def click_create_new_intake
    wait_for_element_and_click intake_link
  end

  # Clicks the link to create a new loan in record
  def click_create_new_loan_in
    wait_for_element_and_click loan_in_link
  end

  # Clicks the link to create a new loan out record
  def click_create_new_loan_out
    wait_for_element_and_click loan_out_link
  end

  # Clicks the link to create a new media handling record
  def click_create_new_media_handling
    wait_for_element_and_click media_handling_link
  end

  # Clicks the link to create a new object exit record
  def click_create_new_object_exit
    wait_for_element_and_click object_exit_link
  end

  # Clicks the link to create a new valuation control record
  def click_create_new_valuation_control
    wait_for_element_and_click valuation_control_link
  end

  # Clicks the link to create a new local citation record
  def click_create_new_authority_citation_local
    wait_for_element_and_click authority_citation_local_link
  end

  # Clicks the link to create a new worldcat citation record
  def click_create_new_authority_citation_world
    wait_for_element_and_click authority_citation_worldcat_link
  end

  # Clicks the link to create a new activity record
  def click_create_new_authority_activity
    wait_for_element_and_click authority_concept_activity_link
  end

  # Clicks the link to create a new associated concept record
  def click_create_new_authority_concept_associated
    wait_for_element_and_click authority_concept_associated_link
  end

  # Clicks the link to create a new concept material record
  def click_create_new_authority_concept_material
    wait_for_element_and_click authority_concept_material_link
  end

  # Clicks the link to create a new concept nomenclature record
  def click_create_new_authority_concept_nomenclature
    wait_for_element_and_click authority_concept_nomenclature_link
  end

  # Clicks the link to create a new concept occasion record
  def click_create_new_authority_concept_occasion
    wait_for_element_and_click authority_concept_occasion_link
  end

  # Clicks the link to create a new local person record
  def click_create_new_authority_person_local
    wait_for_element_and_click authority_person_local_link
  end

  # Clicks the link to create new ulan person record
  def click_create_new_authority_person_ulan
    wait_for_element_and_click authority_person_ulan_link
  end

  # Clicks the link to create a new local place record
  def click_create_new_place_local
    wait_for_element_and_click authority_place_local_link
  end

  # Clicks the link to create a new tgn place record
  def click_create_new_authority_place_tgn
    wait_for_element_and_click authority_place_tgn_link
  end

  # Clicks the link to create a new local storage record
  def click_create_new_authority_storage_local
    wait_for_element_and_click authority_storage_local_link
  end

  # Clicks the link to create a new offsite storage record
  def click_create_new_authority_storage_offsite
    wait_for_element_and_click authority_storage_offsite_link
  end

  # Clicks the link to create a new local work record
  def click_create_new_authority_work_local
    wait_for_element_and_click authority_work_local_link
  end

  # Clicks the link to create a new cona work record
  def click_create_new_authority_work_cona
    wait_for_element_and_click authority_work_cona_link
  end

end
