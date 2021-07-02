class PersonPage < AuthorityPage

  include Logging
  include Page
  include CollectionSpacePages
  include CorePersonInfoForm

  # Enters data in the various forms on the new Person authority page 
  # @param [Hash] test_data
  # @return [Array<Object>]
  def enter_person_auth_data(test_data)
    enter_terms(test_data)
    enter_nationality(test_data)
  end

  # Combines methods to enter new Person authority data, save it, and wait for a delete button to appear. Returns any errors caused by form fields
  # @param [Hash] test_data
  # @return [Array<Object>]
  def create_new_person_authority(test_data)
    data_input_errors = enter_person_auth_data test_data
    wait_for_element_and_click top_save_button
    when_exists(delete_button, Config.short_wait)
    data_input_errors
  end

end
