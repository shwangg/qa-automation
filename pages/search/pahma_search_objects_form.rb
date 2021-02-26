module PAHMASearchObjectsForm

  include Page
  include CollectionSpacePages
  include CoreSearchObjectsForm

  # OBJECT NUMBER

  # TODO - object number range (for 'any' rather than 'all')

  def enter_pahma_object_nums(data_set)
    enter_object_nums data_set
  end

  # ALTERNATE NUMBER

  def pahma_alt_num_input(index); input_locator [fieldset(PAHMAObjectData::ALT_NUM.name, index)] end
  def pahma_alt_num_add_btn; add_button_locator [fieldset(PAHMAObjectData::ALT_NUM.name)] end

  def enter_pahma_alt_nums(data_set)
    alt_nums = data_set[PAHMAObjectData::ALT_NUM_GRP.name]
    alt_nums && alt_nums.each_with_index do |num, index|
      logger.debug "Entering #{num} at index #{index}"
      wait_for_element_and_click pahma_alt_num_add_btn unless index.zero?
      wait_for_element_and_type(pahma_alt_num_input(index), num[PAHMAObjectData::ALT_NUM.name])
    end
  end

  # IS COMPONENT?

  def pahma_is_component_input(index); input_locator [fieldset(PAHMAObjectData::IS_COMPONENT.name, index)] end
  def pahma_is_component_options(index); input_options_locator [fieldset(PAHMAObjectData::IS_COMPONENT.name, index)] end
  def pahma_is_component_add_btn; add_button_locator [fieldset(PAHMAObjectData::IS_COMPONENT.name)] end

  def enter_pahma_is_component(data_set)
    components = data_set[PAHMAObjectData::IS_COMPONENT.name]
    if components
      # Some search test data sets could have an array of is-components or an individual one.
      if components.instance_of? Array
        components.each_with_index do |comp, index|
          logger.debug "Entering #{comp} at index #{index}"
          wait_for_element_and_click pahma_is_component_add_btn unless index.zero?
          wait_for_options_and_select(pahma_is_component_input(index), pahma_is_component_options(index), comp)
        end
      else
        wait_for_options_and_select(pahma_is_component_input(0), pahma_is_component_options(0), components)
      end
    end
  end

  # OBJECT STATUS

  def pahma_obj_status_input(index); input_locator [fieldset(PAHMAObjectData::OBJ_STATUS.name, index)] end
  def pahma_obj_status_options(index); input_options_locator [fieldset(PAHMAObjectData::OBJ_STATUS.name, index)] end
  def pahma_obj_status_add_btn; add_button_locator [fieldset(PAHMAObjectData::OBJ_STATUS.name)] end

  def enter_pahma_object_statuses(data_set)
    obj_statuses = data_set[PAHMAObjectData::OBJ_STATUS_LIST.name]
    obj_statuses && obj_statuses.each_with_index do |status, index|
      logger.debug "Entering #{status} at index #{index}"
      wait_for_element_and_click pahma_obj_status_add_btn unless index.zero?
      wait_for_options_and_select(pahma_obj_status_input(index), pahma_obj_status_options(index), status[PAHMAObjectData::OBJ_STATUS.name])
    end
  end

  # OBJECT NAME

  def enter_pahma_object_names(data_set)
    enter_object_names data_set
  end

  # RESPONSIBLE COLLECTION MANAGER

  def enter_pahma_resp_collection_mgr(data_set)
    enter_resp_depts data_set
  end

  # OBJECT TYPE

  def pahma_obj_type_input(index); input_locator [fieldset(PAHMAObjectData::COLLECTION.name, index)] end
  def pahma_obj_type_options(index); input_options_locator [fieldset(PAHMAObjectData::COLLECTION.name, index)] end
  def pahma_obj_type_add_btn; add_button_locator [fieldset(PAHMAObjectData::COLLECTION.name)] end

  def enter_pahma_object_types(data_set)
    obj_types = data_set[PAHMAObjectData::COLLECTION.name]
    if obj_types
      # Some search test data sets could have an array of object types or an individual one.
      if obj_types.instance_of? Array
        obj_types.each_with_index do |type, index|
          logger.debug "Entering #{type} at index #{index}"
          wait_for_element_and_click pahma_obj_type_add_btn unless index.zero?
          wait_for_options_and_select(pahma_obj_type_input(index), pahma_obj_type_options(index), type[PAHMAObjectData::COLLECTION.name])
        end
      else
        wait_for_options_and_select(pahma_obj_type_input(0), pahma_obj_type_options(0), obj_types)
      end
    end
  end

  # ETHNOGRAPHIC FILE CODE

  def pahma_ethno_file_code_input(index); input_locator [fieldset(PAHMAObjectData::ETHNO_FILE_CODE.name, index)] end
  def pahma_ethno_file_code_add_btn; add_button_locator [fieldset(PAHMAObjectData::ETHNO_FILE_CODE.name)] end

  def enter_pahma_ethno_file_codes(data_set)
    ethno_file_codes = data_set[PAHMAObjectData::ETHNO_FILE_CODE_LIST.name]
    ethno_file_codes && ethno_file_codes.each_with_index do |code, index|
      logger.debug "Entering #{code} at index #{index}"
      wait_for_element_and_click pahma_ethno_file_code_add_btn unless index.zero?
      # TODO - handle option creation
      wait_for_element_and_type(pahma_ethno_file_code_input(index), code[PAHMAObjectData::ETHNO_FILE_CODE.name])
    end
  end

  # ASSOCIATED CULTURAL GROUP

  def pahma_assoc_cult_grp_input(index); input_locator [fieldset(PAHMAObjectData::ASSOC_PPL.name, index)] end
  def pahma_assoc_cult_grp_add_btn; add_button_locator [fieldset(PAHMAObjectData::ASSOC_PPL.name)] end

  def enter_pahma_assoc_cult_grps(data_set)
    assoc_cult_grps = data_set[PAHMAObjectData::ASSOC_PPL_GRP.name]
    assoc_cult_grps && assoc_cult_grps.each_with_index do |grp, index|
      logger.debug "Entering #{grp} at index #{index}"
      wait_for_element_and_click pahma_assoc_cult_grp_add_btn unless index.zero?
      # TODO - handle option creation
      wait_for_element_and_type(pahma_assoc_cult_grp_input(index), grp[PAHMAObjectData::ASSOC_PPL.name])
    end
  end

  # MATERIAL

  def pahma_material_input(index); input_locator [fieldset(PAHMAObjectData::MATERIAL.name, index)] end
  def pahma_material_add_btn; add_button_locator [fieldset(PAHMAObjectData::MATERIAL.name)] end

  def enter_pahma_materials(data_set)
    materials = data_set[PAHMAObjectData::MATERIAL_GRP.name]
    materials && materials.each_with_index do |mat, index|
      logger.debug "Entering #{mat} at index #{index}"
      wait_for_element_and_click pahma_material_add_btn unless index.zero?
      # TODO - handle option creation
      wait_for_element_and_type(pahma_material_input(index), mat[PAHMAObjectData::MATERIAL.name])
    end
  end

  # TITLE

  def enter_pahma_titles(data_set)
    enter_titles data_set
  end

  # AUDIO SERIES

  def pahma_audio_series_input(index); input_locator [fieldset(PAHMAObjectData::AUDIO_SERIES.name, index)] end
  def pahma_audio_series_options(index); input_options_locator [fieldset(PAHMAObjectData::AUDIO_SERIES.name, index)] end
  def pahma_audio_series_add_btn; add_button_locator [fieldset(PAHMAObjectData::AUDIO_SERIES.name)] end

  def enter_pahma_audio_series(data_set)
    series_grp = data_set[PAHMAObjectData::AUDIO_SERIES_GRP.name]
    if series_grp
      # Some search test data sets could have an array of audio series or an individual one.
      if series_grp.instance_of? Array
        series_grp.each_with_index do |series, index|
          logger.debug "Entering #{series} at index #{index}"
          wait_for_element_and_click pahma_audio_series_add_btn unless index.zero?
          wait_for_options_and_select(pahma_audio_series_input(index), pahma_audio_series_options(index), series[PAHMAObjectData::AUDIO_SERIES.name])
        end
      else
        wait_for_options_and_select(pahma_audio_series_input(index), pahma_audio_series_options(index), series_grp)
      end
    end
  end

  # PAHMA_COLLECTION

  def pahma_collection_input(index); input_locator [fieldset(PAHMAObjectData::PAHMA_COLLECTION.name, index)] end
  def pahma_collection_options(index); input_options_locator [fieldset(PAHMAObjectData::PAHMA_COLLECTION.name, index)] end
  def pahma_collection_add_btn; add_button_locator [fieldset(PAHMAObjectData::PAHMA_COLLECTION.name)] end

  def enter_pahma_collections(data_set)
    pahma_collections = data_set[PAHMAObjectData::PAHMA_COLLECTION_LIST.name]
    pahma_collections && pahma_collections.each_with_index do |coll, index|
      logger.debug "Entering #{coll} at index #{index}"
      wait_for_element_and_click pahma_collection_add_btn unless index.zero?
      wait_for_options_and_select(pahma_collection_input(index), pahma_collection_options(index), coll[PAHMAObjectData::PAHMA_COLLECTION.name])
    end
  end

  # LEGACY DEPARTMENT

  def pahma_legacy_dept_input(index); input_locator [fieldset(PAHMAObjectData::LEGACY_DEPT.name, index)] end
  def pahma_legacy_dept_options(index); input_options_locator [fieldset(PAHMAObjectData::LEGACY_DEPT.name, index)] end
  def pahma_legacy_dept_add_btn; add_button_locator [fieldset(PAHMAObjectData::LEGACY_DEPT.name)] end

  def enter_pahma_legacy_depts(data_set)
    legacy_depts = data_set[PAHMAObjectData::LEGACY_DEPT_GRP.name]
    legacy_depts && legacy_depts.each_with_index do |dept, index|
      logger.debug "Entering #{dept} at index #{index}"
      wait_for_element_and_click pahma_legacy_dept_add_btn unless index.zero?
      wait_for_options_and_select(pahma_legacy_dept_input(index), pahma_legacy_dept_options(index), dept[PAHMAObjectData::LEGACY_DEPT.name])
    end
  end

  # Using a single set of test data, enters search parameters in the advanced search form
  # @param [Hash] data_set
  def enter_pahma_object_id_search_data(data_set)
    hide_notifications_bar
    # The first input on the form occasionally vanishes when leaving the field, so click through several fields before entering
    # any values.
    wait_for_element_and_click(object_num_input 0)
    wait_for_element_and_click(pahma_alt_num_input 0)
    wait_for_element_and_click(pahma_is_component_input 0)

    enter_pahma_object_nums data_set
    enter_pahma_alt_nums data_set
    enter_pahma_is_component data_set
    enter_pahma_object_statuses data_set
    enter_pahma_object_names data_set
    enter_pahma_resp_collection_mgr data_set
    enter_pahma_object_types data_set
    enter_pahma_assoc_cult_grps data_set
    enter_pahma_materials data_set
    enter_pahma_titles data_set
    enter_pahma_audio_series data_set
    enter_pahma_collections data_set
    enter_pahma_legacy_depts data_set
  end

  # Enters object search criteria and hits search.
  # @param [Hash] data_set
  # @return [Array<Object>]
  def perform_pahma_adv_search_for_all(data_set)
    click_clear_button
    select_adv_search_all_option
    enter_pahma_object_id_search_data data_set
    click_search_button
  end

end
