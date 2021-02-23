module CoreConservationInfoForm

  include Logging
  include Page
  include CollectionSpacePages

  def ref_num_input_locator; input_locator([], CoreConservationData::CONS_REF_NUM.name) end

  # Enters conservation reference number
  # @param [Hash] data_set
  def enter_conservation_ref_num(data_set)
    conserv_num = data_set[CoreConservationData::CONS_REF_NUM.name]
    logger.debug "Entering reference number '#{conserv_num}'"
    ref_num_options_locator = input_options_locator([], CoreConservationData::CONS_REF_NUM.name)
    wait_for_options_and_type(ref_num_input_locator, ref_num_options_locator, conserv_num)
  end

  # PRODECURAL STATUS

  def procedural_status_input_locator(index); input_locator([fieldset(CoreConservationData::STATUS_GROUP.name, index)], CoreConservationData::STATUS.name) end
  def procedural_date_input_locator(index); input_locator([fieldset(CoreConservationData::STATUS_GROUP.name, index)], CoreConservationData::STATUS_DATE.name) end

  # Selects a set of status groups
  # @param [Hash] data_set
  def enter_procedural_status(data_set)
    statuses = data_set[CoreConservationData::STATUS_GROUP.name]
    statuses && statuses.each do |status|
      index = statuses.index status
      logger.debug "Entering status #{status} at index #{index}"
      add_button_locator = add_button_locator([fieldset(CoreConservationData::STATUS_GROUP.name)])
      procedural_status_options_locator = input_options_locator([fieldset(CoreConservationData::STATUS_GROUP.name, index)], CoreConservationData::STATUS.name)
      wait_for_element_and_click add_button_locator unless index.zero?
      wait_for_options_and_select(procedural_status_input_locator(index), procedural_status_options_locator, status[CoreConservationData::STATUS.name])
      enter_simple_date(procedural_date_input_locator(index), status[CoreConservationData::STATUS_DATE.name])
    end
  end

  # TREATMENT PURPOSE 

  def treatment_purpose_input_locator; input_locator([], CoreConservationData::TREATMENT_PURPOSE.name) end

  # Selects an treatment purpose
  # @param [Hash] data_set
  def select_treatment_purpose(data_set)
    purpose = data_set[CoreConservationData::TREATMENT_PURPOSE.name]
    if purpose
      logger.debug "Entering acquisition method '#{purpose}'"
      treatment_purpose_options_locator = input_options_locator([], CoreConservationData::TREATMENT_PURPOSE.name)
      hit_escape
      wait_for_options_and_select(treatment_purpose_input_locator, treatment_purpose_options_locator, purpose)
    end
  end

  # CONSERVATOR

  def conservator_input_locator; input_locator([fieldset(CoreConservationData::CONSERVATOR.name)]) end

  # Selects a set of conservators
  # @param [Hash] data_set
  def select_conservators(data_set)
    conservator = data_set[CoreConservationData::CONSERVATOR.name]
    if conservator
      logger.debug "Entering conservators #{conservator}"
      conservator_options_locator = input_options_locator([fieldset(CoreConservationData::CONSERVATOR.name)])
      enter_auto_complete(conservator_input_locator, conservator_options_locator, conservator, 'Local Persons')
    end
  end

  # EXAMINATION NOTE

  def examination_note_input_locator(index); text_area_locator([fieldset(CoreConservationData::EXAMINATION_GROUP.name, index)], CoreConservationData::EXAMINATION_NOTE.name) end

  # Selects a set of examinations
  # @param [Hash] data_set
  def enter_examination_note(data_set)
    exams = data_set[CoreConservationData::EXAMINATION_GROUP.name]
    exams && exams.each do |exam|
      index = exams.index exam
      logger.debug "Entering examination note #{exam} at index #{index}"
      add_button_locator = add_button_locator([fieldset(CoreConservationData::EXAMINATION_GROUP.name)])
      wait_for_element_and_click add_button_locator unless index.zero?
      wait_for_element_and_type(examination_note_input_locator(index), exam[CoreConservationData::EXAMINATION_NOTE.name])
    end
  end

  # APPROVED BY

  def approved_by_input_locator; input_locator([], CoreConservationData::APPROVED_BY.name) end

  # Selects an approved by
  # @param [Hash] data_set
  def select_approved_by(data_set)
    by = data_set[CoreConservationData::APPROVED_BY.name]
    if by
      logger.debug "Entering approved by '#{by}'"
      approved_by_options_locator = input_options_locator([], CoreConservationData::APPROVED_BY.name)
      hit_escape
      enter_auto_complete(approved_by_input_locator, approved_by_options_locator, by, 'Local Persons')
    end
  end

  # APPROVAL DATE 

  def approval_date_input_locator; input_locator([], CoreConservationData::APPROVED_DATE.name) end

  # Enters an approval date
  # @param [Hash] data_set
  def enter_approval_date(data_set)
    date = data_set[CoreConservationData::APPROVED_DATE.name]
    if date
      logger.debug "Entering approval date '#{date}'"
      enter_simple_date(approval_date_input_locator, date)
    end
  end

  # TREATMENT START DATE

  def treatment_start_input_locator; input_locator([], CoreConservationData::TREATMENT_START.name) end

  # Enters an treatment start date
  # @param [Hash] data_set
  def enter_treatment_start(data_set)
    date = data_set[CoreConservationData::TREATMENT_START.name]
    if date
      logger.debug "Entering treatment start date '#{date}'"
      enter_simple_date(treatment_start_input_locator, date)
    end
  end

  # TREATMENT END DATE

  def treatment_end_input_locator; input_locator([], CoreConservationData::TREATMENT_END.name) end

  # Enters an treatment end date 
  # @param [Hash] data_set
  def enter_treatment_end(data_set)
    date = data_set[CoreConservationData::TREATMENT_END.name]
    if date
      logger.debug "Entering treatment end date '#{date}'"
      enter_simple_date(treatment_end_input_locator, date)
    end
  end

  # RESEARCHER

  def researcher_input_locator; input_locator([], CoreConservationData::RESEARCHER.name) end

  # Selects an researcher
  # @param [Hash] data_set
  def select_researcher(data_set)
    researcher = data_set[CoreConservationData::RESEARCHER.name]
    if researcher
      logger.debug "Entering researcher '#{researcher}'"
      researcher_options_locator = input_options_locator([], CoreConservationData::RESEARCHER.name)
      hit_escape
      enter_auto_complete(researcher_input_locator, researcher_options_locator, researcher, 'Local Persons')
    end
  end

  # PROPOSAL DATE

  def proposal_date_input_locator; input_locator([], CoreConservationData::PROPOSAL_DATE.name) end

  # Enters an proposal date
  # @param [Hash] data_set
  def enter_proposal_date(data_set)
    date = data_set[CoreConservationData::PROPOSAL_DATE.name]
    if date
      logger.debug "Entering proposal date '#{date}'"
      enter_simple_date(proposal_date_input_locator, date)
    end
  end

  # SAMPLE TAKEN BY

  def taken_by_input_locator(index); input_locator([fieldset(CoreConservationData::ANALYSIS_GROUP.name, index)], CoreConservationData::SAMPLE_BY.name) end

  # Selects a set of sample taken by
  # @param [Hash] data_set
  def select_sample_taken_by(data_set)
    takens = data_set[CoreConservationData::STATUS_GROUP.name]
    takens && takens.each do |by|
      index = takens.index by
      logger.debug "Entering sample taken by #{funding} at index #{index}"
      add_button_locator = add_button_locator([fieldset(CoreConservationData::ANALYSIS_GROUP.name)])
      taken_by_options_locator = input_options_locator([fieldset(CoreConservationData::ANALYSIS_GROUP.name, index)], CoreConservationData::SAMPLE_BY.name)
      wait_for_element_and_click add_button_locator unless index.zero?
      enter_auto_complete(taken_by_input_locator(index), taken_by_options_locator, by[CoreConservationData::SAMPLE_BY.name], 'Local Persons')
    end
  end

  # PROPOSED TREATMENT

  def proposed_treatment_input_locator; text_area_locator([], CoreConservationData::PROPOSED_TREATMENT.name) end

  # Enters proposed treatment
  # @param [Hash] data_set
  def enter_proposed_treatment(data_set)
    treatment = data_set[CoreConservationData::PROPOSED_TREATMENT.name]
    logger.debug "Entering proposed treatment '#{treatment}'"
    wait_for_element_and_type(proposed_treatment_input_locator, treatment) if treatment
  end

  # FABRICATION NOTE

  def fabric_note_input_locator; text_area_locator([], CoreConservationData::FABRIC_NOTE.name) end

  # Enters conservation note
  # @param [Hash] data_set
  def enter_fabrication_note(data_set)
    fabric_note = data_set[CoreConservationData::FABRIC_NOTE.name]
    logger.debug "Entering conservation note '#{fabric_note}'"
    wait_for_element_and_type(fabric_note_input_locator, fabric_note) if fabric_note
  end

  # TREATMENT SUMMARY

  def treatment_summary_input_locator; text_area_locator([], CoreConservationData::TREATMENT_SUMMARY.name) end
  
  # Enters treatment summary
  # @param [Hash] data_set
  def enter_treatment_summary(data_set) 
    summary = data_set[CoreConservationData::TREATMENT_SUMMARY.name]
    logger.debug "Entering treatment summary '#{summary}'"
    wait_for_element_and_type(treatment_summary_input_locator, summary) if summary
  end


  def header_1; {:xpath => '//span[contains(.,"Object Analysis Information")]'} end

  def expand_headers
    unless exists? object_audit_input_locator
      wait_for_element_and_click header_1
    end
  end

  # Combines all data entry methods
  # @param [Hash] data_set
  def enter_conservation_info_data(data_set)
    hide_notifications_bar
    # expand_headers
    scroll_to_top
    enter_conservation_ref_num data_set
    enter_procedural_status data_set
    select_treatment_purpose data_set
    select_conservators data_set
    enter_examination_note data_set
    # select_approved_by data_set
    # enter_approval_date data_set
    # enter_treatment_start data_set
    # enter_treatment_end data_set
    # select_researcher data_set
    # enter_proposal_date data_set
    # select_sample_taken_by data_set
    enter_proposed_treatment data_set
    enter_fabrication_note data_set
    enter_treatment_summary data_set      
  end
end
