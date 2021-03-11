module PAHMASearchAccessionsForm

  include Logging
  include Page
  include CollectionSpacePages
  include CoreSearchAcquisitionsForm

  def load_pahma_search_accessions_form
    click_search_link
    click_clear_button
    select_record_type_option 'Accessions'
  end

end
