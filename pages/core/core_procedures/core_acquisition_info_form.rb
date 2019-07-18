require_relative '../../../spec_helper'

module CoreAcquisitionInfoForm

  include Logging
  include Page
  include CollectionSpacePages

  DEPLOYMENT = Deployment::CORE

  def ref_num_input_locator; input_locator([], CoreAcquisitionData::ACQUIS_REF_NUM.name) end

  # Enters an acquisition reference number
  # @param [Hash] data_set
  def enter_acquisition_ref_num(data_set)
    acquis_ref_num = data_set[CoreAcquisitionData::ACQUIS_REF_NUM.name]
    logger.debug "Entering reference number '#{acquis_ref_num}'"
    ref_num_options_locator = input_options_locator([], CoreAcquisitionData::ACQUIS_REF_NUM.name)
    wait_for_options_and_type(ref_num_input_locator, ref_num_options_locator, acquis_ref_num)
  end

  # ACCESSION DATE

  def access_date_input_locator; structured_date_input_locator([]) end

  # Enters an accession date
  # @param [Hash] data_set
  def enter_accession_date(data_set)
    access_date = data_set[CoreAcquisitionData::ACCESSION_DATE_GRP.name]
    if access_date
      logger.debug "Entering accession date '#{access_date}'"
      wait_for_element_and_type(access_date_input_locator, access_date)
      hit_enter
    end
  end

  # ACQUISITION DATE

  def acquis_date_input_locator(index); structured_date_input_locator([fieldset(CoreAcquisitionData::ACQUIS_DATE_GRP.name, index)]) end

  # Enters a set of acquisition dates
  # @param [Hash] data_set
  def enter_acquisition_dates(data_set)
    acquis_dates = data_set[CoreAcquisitionData::ACQUIS_DATE_GRP.name]
    acquis_dates && acquis_dates.each do |date|
      index = acquis_dates.index date
      logger.debug "Entering acquisition date '#{date}' at index #{index}"
      add_button_locator = add_button_locator([fieldset(CoreAcquisitionData::ACQUIS_DATE_GRP.name)])
      hit_escape
      wait_for_element_and_click add_button_locator unless index.zero?
      wait_for_element_and_type(acquis_date_input_locator(index), date[CoreAcquisitionData::ACQUIS_DATE.name])
      hit_enter
    end
  end

  # ACQUISITION METHOD

  def acquis_method_input_locator; input_locator([], CoreAcquisitionData::ACQUIS_METHOD.name) end

  # Selects an acquisition method
  # @param [Hash] data_set
  def select_acquisition_method(data_set)
    acquis_method = data_set[CoreAcquisitionData::ACQUIS_METHOD.name]
    if acquis_method
      logger.debug "Entering acquisition method '#{acquis_method}'"
      method_options_locator = input_options_locator([], CoreAcquisitionData::ACQUIS_METHOD.name)
      hit_escape
      wait_for_options_and_select(acquis_method_input_locator, method_options_locator, acquis_method)
    end
  end

  # ACQUISITION NOTE

  def acquis_note_input_locator; text_area_locator([], CoreAcquisitionData::ACQUIS_NOTE.name) end

  # Enters an acquisition note
  # @param [Hash] data_set
  def enter_acquisition_note(data_set)
    acquis_note = data_set[CoreAcquisitionData::ACQUIS_NOTE.name]
    logger.debug "Entering acquisition note '#{acquis_note}'"
    wait_for_element_and_type(acquis_note_input_locator, acquis_note) if acquis_note
  end

  # ACQUISITION PROVISOS

  def acquis_provisos_input_locator; text_area_locator([], CoreAcquisitionData::ACQUIS_PROVISOS.name) end

  # Enters acquisition provisos
  # @param [Hash] data_set
  def enter_acquisition_provisos(data_set)
    acquis_provisos = data_set[CoreAcquisitionData::ACQUIS_PROVISOS.name]
    logger.debug "Entering acquisition provisos '#{acquis_provisos}'"
    wait_for_element_and_type(acquis_provisos_input_locator, acquis_provisos) if acquis_provisos
  end

  # ACQUISITION REASON

  def acquis_reason_input_locator; text_area_locator([], CoreAcquisitionData::ACQUIS_REASON.name) end

  # Enters an acquisition reason
  # @param [Hash] data_set
  def enter_acquisition_reason(data_set)
    acquis_reason = data_set[CoreAcquisitionData::ACQUIS_REASON.name]
    logger.debug "Entering acquisition reason '#{acquis_reason}'"
    wait_for_element_and_type(acquis_reason_input_locator, acquis_reason) if acquis_reason
  end

  # ACQUISITION SOURCE

  def acquis_source_input_locator(index); input_locator([fieldset(CoreAcquisitionData::ACQUIS_SOURCES.name, index)]) end

  # Selects a set of acquisition sources
  # @param [Hash] data_set
  def select_acquisition_sources(data_set)
    acquis_sources = data_set[CoreAcquisitionData::ACQUIS_SOURCES.name]
    acquis_sources && acquis_sources.each do |source|
      index = acquis_sources.index source
      logger.debug "Entering acquisition source #{source} at index #{index}"
      add_button_locator = add_button_locator([fieldset(CoreAcquisitionData::ACQUIS_SOURCES.name)])
      source_options_locator = input_options_locator([fieldset(CoreAcquisitionData::ACQUIS_SOURCES.name, index)])
      wait_for_element_and_click add_button_locator unless index.zero?
      enter_auto_complete(acquis_source_input_locator(index), source_options_locator, source[CoreAcquisitionData::ACQUIS_SOURCE.name], 'Local Persons')
    end
  end

  # CREDIT LINE

  def credit_line_input_locator; input_locator([], CoreAcquisitionData::CREDIT_LINE.name) end

  # Enters a credit line
  # @param [Hash] data_set
  def enter_credit_line(data_set)
    credit_line = data_set[CoreAcquisitionData::CREDIT_LINE.name]
    logger.debug "Entering credit line '#{credit_line}'"
    wait_for_element_and_type(credit_line_input_locator, credit_line) if credit_line
  end

  # FUNDING SOURCE

  def funding_source_input_locator(index); input_locator([fieldset(CoreAcquisitionData::ACQUIS_FUNDING_LIST.name, index)], CoreAcquisitionData::ACQUIS_FUNDING_SOURCE.name) end

  # Selects a set of funding sources
  # @param [Hash] data_set
  def select_funding_sources(data_set)
    fundings = data_set[CoreAcquisitionData::ACQUIS_FUNDING_LIST.name]
    fundings && fundings.each do |funding|
      index = fundings.index funding
      logger.debug "Entering funding source #{funding} at index #{index}"
      add_button_locator = add_button_locator([fieldset(CoreAcquisitionData::ACQUIS_FUNDING_LIST.name)])
      funding_source_options_locator = input_options_locator([fieldset(CoreAcquisitionData::ACQUIS_FUNDING_LIST.name, index)], CoreAcquisitionData::ACQUIS_FUNDING_SOURCE.name)
      wait_for_element_and_click add_button_locator unless index.zero?
      enter_auto_complete(funding_source_input_locator(index), funding_source_options_locator, funding[CoreAcquisitionData::ACQUIS_FUNDING_SOURCE.name], 'Local Persons')
    end
  end

  # FIELD COLLECTION EVENT NAME

  def event_names_input_locator(index); input_locator([fieldset(CoreAcquisitionData::FIELD_COLLECT_EVENT_NAMES.name, index)]) end

  # Enters a set of field collection event names in the object collection info area
  # @param [Hash] data_set
  def enter_obj_collection_info(data_set)
    wait_for_element_and_click({:xpath => '//button[contains(.,"Object Collection Information")]'})
    field_collect_event_names = data_set[CoreAcquisitionData::FIELD_COLLECT_EVENT_NAMES.name]
    field_collect_event_names && field_collect_event_names.each do |name|
      index = field_collect_event_names.index name
      logger.debug "Entering field collection event name #{name} at index #{index}"
      add_button_locator = add_button_locator([fieldset(CoreAcquisitionData::FIELD_COLLECT_EVENT_NAMES.name)])
      wait_for_element_and_click add_button_locator unless index.zero?
      wait_for_element_and_type(event_names_input_locator(index), name[CoreAcquisitionData::FIELD_COLLECT_EVENT_NAME.name])
    end
  end

  # Combines all data entry methods
  # @param [Hash] data_set
  def enter_acquisition_info_data(data_set)
    hide_notifications_bar
    enter_acquisition_ref_num data_set
    enter_accession_date data_set
    enter_acquisition_dates data_set
    select_acquisition_method data_set
    select_acquisition_sources data_set
    enter_acquisition_note data_set
    enter_acquisition_reason data_set
    enter_acquisition_provisos data_set
    select_funding_sources data_set
    enter_credit_line data_set
    enter_obj_collection_info data_set
  end

end
