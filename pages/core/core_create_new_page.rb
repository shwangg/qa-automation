require_relative '../../spec_helper'

class CoreCreateNewPage < CreateNewPage

  include Logging
  include Page
  include CollectionSpacePages

  DEPLOYMENT = Deployment::CORE

  def authority_org_ulan_link; {:id => 'organization/ulan'} end

  # Clicks the ULAN link to create an organization
  def click_create_new_org_ulan
    wait_for_element_and_click authority_org_ulan_link
  end

end
