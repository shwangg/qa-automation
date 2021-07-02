module PAHMAHeldInTrustInfoForm

  include Logging
  include Page
  include CollectionSpacePages
  include CoreHeldInTrustInfoForm

  #AGREEMENT DATE
  def pahma_agreement_date_input; disabled_input_locator_by_label("Agreement date") end

  ##DEPOSITORS
  def enter_pahma_depositors(test_data)
    enter_depositors(test_data, "PAHMA Persons")
  end

  ##AGREEMENT NOTE
  def agreement_note_input; text_area_locator([], PAHMAHeldInTrustData::AGREEMENT_NOTE.name) end

  def enter_agreement_note(test_data)
    logger.info "Entering agreement note #{test_data[PAHMAHeldInTrustData::AGREEMENT_NOTE.name]}"
    wait_for_element_and_type(agreement_note_input, test_data[PAHMAHeldInTrustData::AGREEMENT_NOTE.name])
  end

  def verify_agreement_note(test_data)
    errors = []
    text_values_match?(test_data[PAHMAHeldInTrustData::AGREEMENT_NOTE.name], element_value(agreement_note_input), errors)
    errors
  end

  ##INTERNAL APPROVAL
  def enter_pahma_internal_approvals(test_data)
    enter_internal_approvals(test_data, "PAHMA Persons")
  end

  ##EXTERNAL APPROVAL
  def enter_pahma_external_approvals(test_data)
    enter_external_approvals(test_data, "PAHMA Persons")
  end

  ##HANDLING LIMITATIONS
  def enter_pahma_handling_limitations(test_data)
    enter_handling_limitations(test_data, "PAHMA Persons")
  end

  ##CORRESPONDENCES
  def enter_pahma_correspondences(test_data)
    enter_correspondences(test_data, "PAHMA Persons")
  end
end
