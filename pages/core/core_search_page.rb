require_relative '../../spec_helper'

class CoreSearchPage < SearchPage

  include Page
  include CollectionSpacePages
  include CoreSearchObjectsForm
  include CoreSearchAcquisitionsForm

  DEPLOYMENT = Deployment::CORE

  # Enters object search criteria and hits search. Returns an array of any errors caused by form fields.
  # @param [Hash] data_set
  # @return [Array<Object>]
  def perform_adv_search_for_all(data_set)
    click_clear_button
    select_adv_search_all_option
    search_input_errors = enter_object_id_search_data data_set
    click_search_button
    search_input_errors
  end

end
