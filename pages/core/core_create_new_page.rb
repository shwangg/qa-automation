require_relative '../../spec_helper'

class CoreCreateNewPage

  include Logging
  include Page
  include CollectionSpacePages

  DEPLOYMENT = Deployment::CORE

  def object_link; {:id => 'collectionobject'} end
  def acquisition_link; {:id => 'acquisition'} end
  def exhibition_link; {:id => 'exhibition'} end
  def use_of_collections_link; {:id => 'uoc'} end
  def authority_org_local_link; {:xpath => '//a[@id="organization/local"]'} end
  def authority_org_ulan_link; {:xpath => '//a[@id="organization/ulan"]'} end

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

  # Clicks the link to create a new use of collections procedure
  def click_create_new_use_of_collections
    wait_for_page_and_click use_of_collections_link
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

end
