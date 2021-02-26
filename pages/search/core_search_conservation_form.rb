module CoreSearchConservationForm

  include Logging
  include Page
  include CollectionSpacePages

  def ref_num_input_locator(index); input_locator([fieldset(CoreConservationData::CONS_REF_NUM.name, index)]) end

  # Enters conservation ref number
  # @param [Hash] data_set
  def enter_conservation_ref_num(data_set)
    cons_ref_num = data_set[CoreConservationData::CONS_REF_NUM.name]
    logger.debug "Entering condition ref number '#{cons_ref_num}'"
    wait_for_element_and_type(ref_num_input_locator(0), cons_ref_num) if cons_ref_num
  end

  # Clicks the Search link and the Clear button, and selects 'Conservation Treatments' from the record type
  def load_search_conservation_form
    click_search_link
    click_clear_button
    select_record_type_option 'Conservation Treatments'
  end

  # PROCEDURAL STATUS

  def prodecural_status_input_locator(index); input_locator([fieldset(CoreConservationData::STATUS.name, index)]) end

  # Selects procedural status
  # @param [Hash] data_set
  def select_procedural_status(data_set)
    group = data_set[CoreConservationData::STATUS_GROUP.name][0][CoreConservationData::STATUS.name]
    logger.debug "Entering procedural status #{group}"
    prodecural_status_options_locator = input_options_locator([fieldset(CoreConservationData::STATUS.name, 0)])
    wait_for_options_and_select(prodecural_status_input_locator(0), prodecural_status_options_locator, group) if group
  end 
  
  # PROCEDURAL STATUS DATE

  def procedural_status_date_input_locator; input_locator([], CoreConservationData::STATUS_DATE.name) end

  # Enters an procedural status date
  # @param [Hash] data_set
  def enter_procedural_status_date(data_set)
    status_date = data_set[CoreConservationData::STATUS_GROUP.name][0][CoreConservationData::STATUS_DATE.name]
    if status_date
      logger.debug "Enter procedural status date '#{status_date}'"
      input = element procedural_status_date_input_locator
      input.clear
      sleep Config.click_wait
      input.send_keys status_date
      hit_enter
      hit_tab
    end
  end

  # CONSERVATOR

  def conservator_input_locator(index); input_locator([fieldset(CoreConservationData::CONSERVATOR.name, index)]) end

  # Selects a set of acquisition sources
  # @param [Hash] data_set
  def select_conservator(data_set)
    conservators = data_set[CoreConservationData::CONSERVATOR.name]
    if conservators
      logger.debug "Entering conservator #{conservators}"
      conservator_options_locator = input_options_locator([fieldset(CoreConservationData::CONSERVATOR.name, 0)])
      enter_auto_complete(conservator_input_locator(0), conservator_options_locator, conservators)
    end
  end  

  # EXAMINATION NOTE

  def examination_note_input_locator(index); input_locator([fieldset(CoreConservationData::EXAMINATION_NOTE.name, index)]) end

  # Enters one examination note
  # @param [Hash] data_set
  def enter_examination_note(data_set)
    note = data_set[CoreConservationData::EXAMINATION_GROUP.name][0][CoreConservationData::EXAMINATION_NOTE.name]
    logger.debug "Entering examination note '#{note}'"
    wait_for_element_and_type(examination_note_input_locator(0), note) if note
    scroll_to_top
  end

  # TREATMENT PURPOSE

  def treatment_purpose_input_locator(index); input_locator([fieldset(CoreConservationData::TREATMENT_PURPOSE.name, index)]) end

  # Selects treatment purpose
  # @param [Hash] data_set
  def select_treatment_purpose(data_set)
    treatment = data_set[CoreConservationData::TREATMENT_PURPOSE.name]
    logger.debug "Entering treatment purpose #{treatment}"
    treatment_purpose_options_locator = input_options_locator([fieldset(CoreConservationData::TREATMENT_PURPOSE.name, 0)])
    wait_for_options_and_select(treatment_purpose_input_locator(0), treatment_purpose_options_locator, treatment) if treatment
  end 
  
end
