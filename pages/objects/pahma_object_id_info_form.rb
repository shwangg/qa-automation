module PAHMAObjectIdInfoForm

  include Logging
  include Page
  include CollectionSpacePages
  include CoreObjectIdInfoForm

  # MUSEUM NUMBER

  def enter_pahma_museum_number(data)
    wait_for_element_and_type(object_num_input, data[PAHMAObjectData::OBJECT_NUM.name])
  end

  # LEGACY DEPT

  def pahma_legacy_dept_input; input_locator([], PAHMAObjectData::LEGACY_DEPT.name) end
  def pahma_legacy_dept_options; input_options_locator([], PAHMAObjectData::LEGACY_DEPT.name) end

  def select_pahma_legacy_dept(data)
    logger.debug "Entering legacy dept '#{data[PAHMAObjectData::LEGACY_DEPT.name]}'"
    wait_for_options_and_select(pahma_legacy_dept_input, pahma_legacy_dept_options, data[PAHMAObjectData::LEGACY_DEPT.name])
  end

  # NUMBER OF PIECES
  def enter_pahma_num_pieces(data)
    enter_num_objects data
  end

  # COUNT NOTE

  def pahma_count_note_input; input_locator([], PAHMAObjectData::INVENTORY_COUNT.name) end

  def enter_pahma_count_note(data)
    logger.debug "Entering count note '#{data[PAHMAObjectData::INVENTORY_COUNT.name]}'"
    wait_for_element_and_type(pahma_count_note_input, data[PAHMAObjectData::INVENTORY_COUNT.name])
  end

  # IS COMPONENT

  def pahma_is_component_input; input_locator([], PAHMAObjectData::IS_COMPONENT.name) end
  def pahma_is_component_options; input_options_locator([], PAHMAObjectData::IS_COMPONENT.name) end

  def select_pahma_is_component(data)
    logger.debug "Entering is-component '#{data[PAHMAObjectData::IS_COMPONENT.name]}'"
    wait_for_options_and_select(pahma_is_component_input, pahma_is_component_options, data[PAHMAObjectData::IS_COMPONENT.name])
  end

  # OBJECT STATUS

  def pahma_obj_status_input(index); input_locator([fieldset(PAHMAObjectData::OBJ_STATUS_LIST.name, index)]) end
  def pahma_obj_status_options(index); input_options_locator([fieldset(PAHMAObjectData::OBJ_STATUS_LIST.name, index)]) end

  def select_pahma_object_statuses(data)
    obj_statuses = data[PAHMAObjectData::OBJ_STATUS_LIST.name] ? data[PAHMAObjectData::OBJ_STATUS_LIST.name] : []
    prep_fieldsets_for_test_data([fieldset(PAHMAObjectData::OBJ_STATUS_LIST.name)], obj_statuses)
    obj_statuses.each_with_index do |obj_status, index|
      logger.debug "Entering object status '#{obj_status}' at index #{index}"
      wait_for_options_and_select(pahma_obj_status_input(index), pahma_obj_status_options(index), obj_status[PAHMAObjectData::OBJ_STATUS.name])
    end
  end

  # ALTERNATE NUMBER

  def pahma_alt_num_input(index); input_locator([fieldset(PAHMAObjectData::ALT_NUM_GRP.name, index)], PAHMAObjectData::ALT_NUM.name) end
  def pahma_alt_num_type_input(index); input_locator([fieldset(PAHMAObjectData::ALT_NUM_GRP.name, index)], PAHMAObjectData::ALT_NUM_TYPE.name) end
  def pahma_alt_num_type_options(index); input_options_locator([fieldset(PAHMAObjectData::ALT_NUM_GRP.name, index)], PAHMAObjectData::ALT_NUM_TYPE.name) end
  def pahma_alt_num_note_input(index); input_locator([fieldset(PAHMAObjectData::ALT_NUM_GRP.name, index)], PAHMAObjectData::ALT_NUM_NOTE.name) end

  def enter_pahma_alt_num(data)
    alt_nums = data[PAHMAObjectData::ALT_NUM_GRP.name]
    prep_fieldsets_for_test_data([fieldset(PAHMAObjectData::ALT_NUM_GRP.name)], alt_nums)
    alt_nums && alt_nums.each_with_index do |alt_num, index|
      logger.debug "Entering alternate number '#{alt_num}' at index #{index}"
      wait_for_element_and_type(pahma_alt_num_input(index), alt_num[PAHMAObjectData::ALT_NUM.name])
      wait_for_options_and_select(pahma_alt_num_type_input(index), pahma_alt_num_type_options(index), alt_num[PAHMAObjectData::ALT_NUM_TYPE.name])
      wait_for_element_and_type(pahma_alt_num_note_input(index), alt_num[PAHMAObjectData::ALT_NUM_NOTE.name])
    end
  end

  # DESCRIPTION

  def enter_pahma_desc(data)
    enter_brief_description data
  end

  # CURRENT STORAGE LOCATION

  def pahma_current_storage_location; input_locator_by_label(PAHMAObjectData::CURRENT_LOCATION.label) end

  def wait_for_pahma_location(movt_data)
    wait_for_event_listener do
      sleep 1
      wait_until(3) { element_value(pahma_current_storage_location) == movt_data[PAHMAInventoryMovementData::CURRENT_LOCATION.name] }
    end
  end


  def wait_for_pahma_storage_location(data)
    wait_for_location data
  end

  # CURRENT CRATE

  def pahma_current_crate_input; input_locator_by_label(PAHMAObjectData::CURRENT_CRATE.label) end

  # OBJECT CLASS

  def pahma_obj_class_name_input(index); input_locator([fieldset(PAHMAObjectData::OBJ_CLASS_GRP.name, index)], PAHMAObjectData::OBJ_CLASS_NAME.name) end
  def pahma_obj_class_name_options(index); input_options_locator([fieldset(PAHMAObjectData::OBJ_CLASS_GRP.name, index)], PAHMAObjectData::OBJ_CLASS_NAME.name) end
  def pahma_obj_class_note_input(index); input_locator([fieldset(PAHMAObjectData::OBJ_CLASS_GRP.name, index)], PAHMAObjectData::OBJ_CLASS_NOTE.name) end

  def enter_pahma_object_classes(data)
    obj_classes = data[PAHMAObjectData::OBJ_CLASS_GRP.name]
    prep_fieldsets_for_test_data([fieldset(PAHMAObjectData::OBJ_CLASS_GRP.name)], obj_classes)
    obj_classes && obj_classes.each_with_index do |obj_class, index|
      logger.debug "Entering object class '#{obj_class}' at index #{index}"
      # TODO - handle creation of input options
      wait_for_element_and_type(pahma_obj_class_name_input(index), obj_class[PAHMAObjectData::OBJ_CLASS_NAME.name])
      wait_for_element_and_type(pahma_obj_class_note_input(index), obj_class[PAHMAObjectData::OBJ_CLASS_NOTE.name])
    end
  end

  # OBJECT NAME

  def enter_pahma_object_names(data)
    enter_object_names data
  end

  # RESPONSIBLE COLLECTION MANAGER

  def enter_pahma_resp_collection_mgr(data)
    enter_resp_depts data
  end

  # OBJECT TYPE

  def select_pahma_object_type(data)
    select_collection data
  end

  # ASSOCIATED CULTURAL GROUP

  def pahma_assoc_cult_grp_input(index);input_locator([fieldset(PAHMAObjectData::ASSOC_PPL_GRP.name, index)], PAHMAObjectData::ASSOC_PPL.name) end
  def pahma_assoc_cult_grp_type_input(index); input_locator([fieldset(PAHMAObjectData::ASSOC_PPL_GRP.name, index)], PAHMAObjectData::ASSOC_PPL_TYPE.name) end
  def pahma_assoc_cult_grp_type_options(index); input_options_locator([fieldset(PAHMAObjectData::ASSOC_PPL_GRP.name, index)], PAHMAObjectData::ASSOC_PPL_TYPE.name) end
  def pahma_assoc_cult_grp_note_input(index); input_locator([fieldset(PAHMAObjectData::ASSOC_PPL_GRP.name, index)], PAHMAObjectData::ASSOC_PPL_NOTE.name) end

  def enter_pahma_assoc_cult_grps(data)
    assoc_cult_grps = data[PAHMAObjectData::ASSOC_PPL_GRP.name]
    prep_fieldsets_for_test_data([fieldset(PAHMAObjectData::ASSOC_PPL_GRP.name)], assoc_cult_grps)
    assoc_cult_grps && assoc_cult_grps.each_with_index do |assoc_cult, index|
      logger.debug "Entering associated cultural group '#{assoc_cult}'"
      # TODO - handle creation of input options
      wait_for_element_and_type(pahma_assoc_cult_grp_input(index), assoc_cult[PAHMAObjectData::ASSOC_PPL.name])
      wait_for_options_and_select(pahma_assoc_cult_grp_type_input(index), pahma_assoc_cult_grp_type_options(index), assoc_cult[PAHMAObjectData::ASSOC_PPL_TYPE.name])
      wait_for_element_and_type(pahma_assoc_cult_grp_note_input(index), assoc_cult[PAHMAObjectData::ASSOC_PPL_NOTE.name])
    end
  end

  # ETHNOGRAPHIC FILE CODE

  def pahma_ethno_file_code_input(index); input_locator([fieldset(PAHMAObjectData::ETHNO_FILE_CODE_LIST.name, index)]) end
  def pahma_ethno_file_code_options(index); input_options_locator([fieldset(PAHMAObjectData::ETHNO_FILE_CODE_LIST.name, index)]) end

  def enter_pahma_enthno_file_codes(data)
    ethno_file_codes = data[PAHMAObjectData::ETHNO_FILE_CODE_LIST.name]
    prep_fieldsets_for_test_data([fieldset(PAHMAObjectData::ETHNO_FILE_CODE_LIST.name)], ethno_file_codes)
    ethno_file_codes && ethno_file_codes.each_with_index do |code, index|
      logger.debug "Entering ethnographic file code '#{code}'"
      # TODO - handle creation of input options
      wait_for_element_and_type(pahma_ethno_file_code_input(index), code[PAHMAObjectData::ETHNO_FILE_CODE.name])
    end
  end

  # COMMENT

  def enter_pahma_comments(data)
    enter_comments data
  end

  # TODO - ABBREVIATED DESCRIPTION

  # ANNOTATIONS

  def pahma_annot_type_input(index); input_locator([fieldset(PAHMAObjectData::ANNOT_GRP.name, index)], PAHMAObjectData::ANNOT_TYPE.name) end
  def pahma_annot_type_options(index); input_options_locator([fieldset(PAHMAObjectData::ANNOT_GRP.name, index)], PAHMAObjectData::ANNOT_TYPE.name) end
  def pahma_annot_note_input(index); input_locator([fieldset(PAHMAObjectData::ANNOT_GRP.name, index)], PAHMAObjectData::ANNOT_NOTE.name) end
  def pahma_annot_date_input(index); input_locator([fieldset(PAHMAObjectData::ANNOT_GRP.name, index)], PAHMAObjectData::ANNOT_DATE.name) end
  def pahma_annot_author_input(index); input_locator([fieldset(PAHMAObjectData::ANNOT_GRP.name, index)], PAHMAObjectData::ANNOT_AUTHOR.name) end

  def enter_pahma_annotations(data)
    annotations = data[PAHMAObjectData::ANNOT_GRP.name]
    prep_fieldsets_for_test_data([fieldset(PAHMAObjectData::ANNOT_GRP.name)], annotations)
    annotations && annotations.each_with_index do |annot, index|
      logger.debug "Entering annotation '#{annot}' at index #{index}"
      wait_for_options_and_select(pahma_annot_type_input(index), pahma_annot_type_options(index), annot[PAHMAObjectData::ANNOT_TYPE.name])
      wait_for_element_and_type(pahma_annot_note_input(index), annot[PAHMAObjectData::ANNOT_NOTE.name])
      enter_simple_date(pahma_annot_date_input(index), annot[PAHMAObjectData::ANNOT_DATE.name])
      # TODO - handle creation of input options
      wait_for_element_and_type(pahma_annot_author_input(index), annot[PAHMAObjectData::ANNOT_AUTHOR.name])
    end
  end

  # DIMENSIONS

  def pahma_part_measured_input(index); input_locator([fieldset(PAHMAObjectData::MEASURE_PART_GRP.name, index)], PAHMAObjectData::MEASURE_PART.name) end
  def pahma_measure_dimen_add_btn(index); add_button_locator [fieldset(PAHMAObjectData::MEASURE_PART_GRP.name, index), fieldset(PAHMAObjectData::MEASURE_DIMEN_GRP.name)] end
  def pahma_measure_dimen_input(indices); input_locator([fieldset(PAHMAObjectData::MEASURE_PART_GRP.name, indices[0]), fieldset(PAHMAObjectData::MEASURE_DIMEN_GRP.name, indices[1])], PAHMAObjectData::MEASURE_DIMENSION.name) end
  def pahma_measure_dimen_options(indices); input_options_locator([fieldset(PAHMAObjectData::MEASURE_PART_GRP.name, indices[0]), fieldset(PAHMAObjectData::MEASURE_DIMEN_GRP.name, indices[1])], PAHMAObjectData::MEASURE_DIMENSION.name) end
  def pahma_measure_by_input(indices); input_locator([fieldset(PAHMAObjectData::MEASURE_PART_GRP.name, indices[0]), fieldset(PAHMAObjectData::MEASURE_DIMEN_GRP.name, indices[1])], PAHMAObjectData::MEASURE_BY.name) end
  def pahma_measure_value_input(indices); input_locator([fieldset(PAHMAObjectData::MEASURE_PART_GRP.name, indices[0]), fieldset(PAHMAObjectData::MEASURE_DIMEN_GRP.name, indices[1])], PAHMAObjectData::MEASURE_VALUE.name) end
  def pahma_measure_unit_input(indices); input_locator([fieldset(PAHMAObjectData::MEASURE_PART_GRP.name, indices[0]), fieldset(PAHMAObjectData::MEASURE_DIMEN_GRP.name, indices[1])], PAHMAObjectData::MEASURE_UNIT.name) end
  def pahma_measure_unit_options(indices); input_options_locator([fieldset(PAHMAObjectData::MEASURE_PART_GRP.name, indices[0]), fieldset(PAHMAObjectData::MEASURE_DIMEN_GRP.name, indices[1])], PAHMAObjectData::MEASURE_UNIT.name) end
  def pahma_measure_qualifier_input(indices); input_locator([fieldset(PAHMAObjectData::MEASURE_PART_GRP.name, indices[0]), fieldset(PAHMAObjectData::MEASURE_DIMEN_GRP.name, indices[1])], PAHMAObjectData::MEASURE_QUALIFIER.name) end
  def pahma_measure_date_input(indices); input_locator([fieldset(PAHMAObjectData::MEASURE_PART_GRP.name, indices[0]), fieldset(PAHMAObjectData::MEASURE_DIMEN_GRP.name, indices[1])], PAHMAObjectData::MEASURE_DATE.name) end
  def pahma_measure_note_input(indices); input_locator([fieldset(PAHMAObjectData::MEASURE_PART_GRP.name, indices[0]), fieldset(PAHMAObjectData::MEASURE_DIMEN_GRP.name, indices[1])], PAHMAObjectData::MEASURE_NOTE.name) end

  def enter_pahma_dimensions(data)
    dimensions = data[PAHMAObjectData::MEASURE_PART_GRP.name]
    prep_fieldsets_for_test_data([fieldset(PAHMAObjectData::MEASURE_PART_GRP.name)], dimensions)
    dimensions && dimensions.each_with_index do |dim, index|
      logger.debug "Entering dimension '#{dim}' at index #{index}"
      wait_for_element_and_type(pahma_part_measured_input(index), dim[PAHMAObjectData::MEASURE_PART.name])

      measures = dim[PAHMAObjectData::MEASURE_DIMEN_GRP.name]
      prep_fieldsets_for_test_data([fieldset(PAHMAObjectData::MEASURE_PART_GRP.name, index), fieldset(PAHMAObjectData::MEASURE_DIMEN_GRP.name)], measures)
      measures && measures.each_with_index do |meas, sub_index|
        indices = [index, sub_index]
        logger.debug "Entering dimension measurement '#{meas}' at indices #{indices}"
        wait_for_options_and_select(pahma_measure_dimen_input(indices), pahma_measure_dimen_options(indices), meas[PAHMAObjectData::MEASURE_DIMENSION.name])
        # TODO - handle creation of input options
        wait_for_element_and_type(pahma_measure_by_input(indices), meas[PAHMAObjectData::MEASURE_BY.name])
        wait_for_element_and_type(pahma_measure_value_input(indices), meas[PAHMAObjectData::MEASURE_VALUE.name])
        wait_for_options_and_select(pahma_measure_unit_input(indices), pahma_measure_unit_options(indices), meas[PAHMAObjectData::MEASURE_UNIT.name])
        wait_for_element_and_type(pahma_measure_qualifier_input(indices), meas[PAHMAObjectData::MEASURE_QUALIFIER.name])
        enter_simple_date(pahma_measure_date_input(indices), meas[PAHMAObjectData::MEASURE_DATE.name])
        wait_for_element_and_type(pahma_measure_note_input(indices), meas[PAHMAObjectData::MEASURE_NOTE.name])
      end
    end
  end

  # MATERIALS

  def pahma_material_input(index); input_locator([fieldset(PAHMAObjectData::MATERIAL_GRP.name, index)], PAHMAObjectData::MATERIAL.name) end
  def pahma_material_component_input(index); input_locator([fieldset(PAHMAObjectData::MATERIAL_GRP.name, index)], PAHMAObjectData::MATERIAL_COMPONENT.name) end
  def pahma_material_name_input(index); input_locator([fieldset(PAHMAObjectData::MATERIAL_GRP.name, index)], PAHMAObjectData::MATERIAL_NAME.name) end
  def pahma_material_source_input(index); input_locator([fieldset(PAHMAObjectData::MATERIAL_GRP.name, index)], PAHMAObjectData::MATERIAL_SOURCE.name) end
  def pahma_material_note_input(index); input_locator([fieldset(PAHMAObjectData::MATERIAL_GRP.name, index)], PAHMAObjectData::MATERIAL_NOTE.name) end

  def enter_pahma_materials(data_set)
    materials = data_set[PAHMAObjectData::MATERIAL_GRP.name]
    prep_fieldsets_for_test_data([fieldset(PAHMAObjectData::MATERIAL_GRP.name)], materials)
    materials && materials.each_with_index do |mat, index|
      logger.debug "Entering material '#{mat}' at index #{index}"
      # TODO - handle creation of input options
      wait_for_element_and_type(pahma_material_input(index), mat[PAHMAObjectData::MATERIAL.name])
      wait_for_element_and_type(pahma_material_component_input(index), mat[PAHMAObjectData::MATERIAL_COMPONENT.name])
      wait_for_element_and_type(pahma_material_name_input(index), mat[PAHMAObjectData::MATERIAL_NAME.name])
      attempt_action(data_input_errors, mat) { wait_for_element_and_type(pahma_material_source_input(index), mat[PAHMAObjectData::MATERIAL_SOURCE.name]) }
      attempt_action(data_input_errors, mat) { wait_for_element_and_type(pahma_material_note_input(index), mat[PAHMAObjectData::MATERIAL_NOTE.name]) }
    end
  end

  # TAXONOMIC INFORMATION

  def enter_pahma_taxonomics(data)
    enter_taxonomics(data, "PAHMA")
  end

  # TITLE

  def enter_pahma_titles(data)
    enter_titles data
  end

  # CONTEXT OF USE

  def pahma_usage_input(index); text_area_locator([fieldset(PAHMAObjectData::USAGE_GRP.name, index)], PAHMAObjectData::USAGE.name) end
  def pahma_usage_note_input(index); text_area_locator([fieldset(PAHMAObjectData::USAGE_GRP.name, index)], PAHMAObjectData::USAGE_NOTE.name) end

  def enter_pahma_usages(data)
    usages = data[PAHMAObjectData::USAGE_GRP.name]
    prep_fieldsets_for_test_data([fieldset(PAHMAObjectData::USAGE_GRP.name)], usages)
    usages && usages.each_with_index do |usage, index|
      logger.debug "Entering usage '#{usage}' at index #{index}"
      wait_for_element_and_type(pahma_usage_input(index), usage[PAHMAObjectData::USAGE.name])
      wait_for_element_and_type(pahma_usage_note_input(index), usage[PAHMAObjectData::USAGE_NOTE.name])
    end
  end

  # SERIES

  def pahma_series_input; input_locator([], PAHMAObjectData::AUDIO_SERIES.name) end
  def pahma_series_options; input_options_locator([], PAHMAObjectData::AUDIO_SERIES.name) end

  def select_pahma_series(data)
    logger.debug "Selecting series '#{data[PAHMAObjectData::AUDIO_SERIES.name]}'"
    wait_for_options_and_select(pahma_series_input, pahma_series_options, data[PAHMAObjectData::AUDIO_SERIES.name])
  end

  # COLLECTIONS

  def pahma_collection_input(index); input_locator([fieldset(PAHMAObjectData::PAHMA_COLLECTION_LIST.name, index)]) end
  def pahma_collection_options(index); input_options_locator([fieldset(PAHMAObjectData::PAHMA_COLLECTION_LIST.name, index)]) end

  def select_pahma_collections(data)
    collections = data_set[PAHMAObjectData::PAHMA_COLLECTION_LIST.name]
    prep_fieldsets_for_test_data([fieldset(PAHMAObjectData::PAHMA_COLLECTION_LIST.name)], collections)
    collections && collections.each_with_index do |collect, index|
      logger.debug "Entering collection '#{collect}' at index #{index}"
      wait_for_options_and_select(pahma_collection_input(index), pahma_collection_options(index), collect[PAHMAObjectData::PAHMA_COLLECTION.name])
    end
  end

  # TMS SOURCE

  def pahma_tms_data_source_input; input_locator([], PAHMAObjectData::TMS_DATA_SRC.name) end
  def pahma_tms_data_source_options; input_options_locator([], PAHMAObjectData::TMS_DATA_SRC.name) end

  def select_pahma_tms_source(data)
    logger.debug "Selecting TMS data source '#{data[PAHMAObjectData::TMS_DATA_SRC.name]}'"
    wait_for_options_and_select(pahma_tms_data_source_input, pahma_tms_data_source_options, data[PAHMAObjectData::TMS_DATA_SRC.name])
  end

end
