module CoreSearchAcquisitionsForm

  include Logging
  include Page
  include CollectionSpacePages

  def acquis_ref_num_input(index); input_locator([fieldset(CoreAcquisitionData::ACQUIS_REF_NUM.name, index)]) end

  # Enters an acquisition ref number
  # @param [Hash] data_set
  def enter_ref_num(data_set)
    ref_num = data_set[CoreAcquisitionData::ACQUIS_REF_NUM.name]
    logger.debug "Entering acquisition ref number '#{ref_num}'"
    wait_for_element_and_type(acquis_ref_num_input(0), ref_num) if ref_num
  end

  # Clicks the Search link and the Clear button, and selects 'Acquisitions' from the record type
  def load_search_acquisitions_form
    click_search_link
    click_clear_button
    select_record_type_option 'Acquisitions'
  end

  # ACCESSION DATE

  def access_date_input_locator; input_locator([], CoreAcquisitionData::ACCESSION_DATE_GRP.name) end

  # Enters an accession date in the first accession date input
  # @param [Hash] data_set
  def enter_accession_date(data_set)
    access_date = data_set[CoreAcquisitionData::ACCESSION_DATE_GRP.name]
    if access_date
      logger.debug "Enter accession date '#{access_date}'"
      input = element access_date_input_locator
      input.clear
      sleep Config.click_wait
      input.send_keys access_date
      hit_enter
      hit_tab
    end
  end

  # ACQUISITION DATES

  def acquis_date_input_locator; input_locator([], CoreAcquisitionData::ACQUIS_DATE_GRP.name) end

  # Enters two acquisition dates representing 'after' and 'before'
  # @param [Hash] data_set
  def enter_acquisition_dates(data_set)
    acquis_dates = data_set[CoreAcquisitionData::ACQUIS_DATE_GRP.name]
    acquis_dates && acquis_dates[0..1].each do |date|
      logger.debug "Entering date '#{date}'"
      inputs = elements acquis_date_input_locator
      input = acquis_dates[0..1].index(date).zero? ? inputs[0] : inputs[1]
      input.clear
      sleep Config.click_wait
      input.send_keys date[CoreAcquisitionData::ACQUIS_DATE.name]
      hit_enter
      hit_tab
    end
  end

  # ACQUISITION METHODS

  def acquis_method_input_locator(index); input_locator([fieldset(CoreAcquisitionData::ACQUIS_METHOD.name, index)]) end

  # Selects one acquisition method
  # @param [Hash] data_set
  def select_acquisition_method(data_set)
    acquis_method = data_set[CoreAcquisitionData::ACQUIS_METHOD.name]
    logger.debug "Selecting acquisition method #{acquis_method}"
    method_options_locator = input_options_locator([fieldset(CoreAcquisitionData::ACQUIS_METHOD.name, 0)])
    wait_for_options_and_select(acquis_method_input_locator(0), method_options_locator, acquis_method) if acquis_method
  end

  # ACQUISITION SOURCES

  def acquis_source_input_locator(index); input_locator([fieldset(CoreAcquisitionData::ACQUIS_SOURCE.name, index)]) end

  # Selects a set of acquisition sources
  # @param [Hash] data_set
  def select_acquisition_sources(data_set)
    acquis_sources = data_set[CoreAcquisitionData::ACQUIS_SOURCES.name]
    acquis_sources && acquis_sources.each do |source|
      index = acquis_sources.index source
      logger.debug "Entering acquisition source #{source} at index #{index}"
      add_button_locator = add_button_locator([fieldset(CoreAcquisitionData::ACQUIS_SOURCE.name)])
      source_options_locator = input_options_locator([fieldset(CoreAcquisitionData::ACQUIS_SOURCE.name, index)])
      wait_for_element_and_click add_button_locator unless index.zero?
      enter_auto_complete(acquis_source_input_locator(index), source_options_locator, source[CoreAcquisitionData::ACQUIS_SOURCE.name])
    end
  end

  # FUNDING SOURCES

  def funding_source_input_locator(index); input_locator([fieldset(CoreAcquisitionData::ACQUIS_FUNDING_SOURCE.name, index)]) end

  # Selects a set of funding sources
  # @param [Hash] data_set
  def select_funding_sources(data_set)
    funding_sources = data_set[CoreAcquisitionData::ACQUIS_FUNDING_LIST.name]
    funding_sources && funding_sources.each do |source|
      index = funding_sources.index source
      logger.debug "Entering funding source #{source} at index #{index}"
      add_button_locator = add_button_locator([fieldset(CoreAcquisitionData::ACQUIS_FUNDING_SOURCE.name)])
      source_options_locator = input_options_locator([fieldset(CoreAcquisitionData::ACQUIS_FUNDING_SOURCE.name, index)])
      wait_for_element_and_click add_button_locator unless index.zero?
      enter_auto_complete(funding_source_input_locator(index), source_options_locator, source[CoreAcquisitionData::ACQUIS_FUNDING_SOURCE.name])
    end
  end

  # CREDIT LINE

  def credit_line_input_locator(index); input_locator([fieldset(CoreAcquisitionData::CREDIT_LINE.name, index)]) end

  # Enters one credit line
  # @param [Hash] data_set
  def enter_credit_line(data_set)
    credit_line = data_set[CoreAcquisitionData::CREDIT_LINE.name]
    logger.debug "Entering credit line '#{credit_line}'"
    wait_for_element_and_type(credit_line_input_locator(0), credit_line) if credit_line
  end

  # FIELD COLLECTION EVENT NAMES

  def event_name_input_locator(index); input_locator([fieldset(CoreAcquisitionData::FIELD_COLLECT_EVENT_NAME.name, index)]) end

  # Enters a set of field collection event names
  # @param [Hash] data_set
  def enter_field_collect_event_names(data_set)
    field_collect_event_names = data_set[CoreAcquisitionData::FIELD_COLLECT_EVENT_NAMES.name]
    field_collect_event_names && field_collect_event_names.each do |name|
      index = field_collect_event_names.index name
      logger.debug "Entering field collection event name #{name} at index #{index}"
      add_button_locator = add_button_locator([fieldset(CoreAcquisitionData::FIELD_COLLECT_EVENT_NAME.name)])
      wait_for_element_and_click add_button_locator unless index.zero?
      wait_for_element_and_type(event_name_input_locator(index), name[CoreAcquisitionData::FIELD_COLLECT_EVENT_NAME.name])
      hit_tab
    end
  end

end
