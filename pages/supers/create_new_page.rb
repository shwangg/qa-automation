require_relative '../../spec_helper'

class CreateNewPage

  include Logging
  include Page
  include CollectionSpacePages

  def object_link; {:id => 'collectionobject'} end
  def acquisition_link; {:id => 'acquisition'} end

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

end
