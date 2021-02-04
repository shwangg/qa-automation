require_relative '../../../spec_helper'

module PAHMAObjectIdInfoForm

  include Logging
  include Page
  include CollectionSpacePages

  DEPLOYMENT = Deployment::PAHMA

  def legacy_dept_input; input_locator([], PAHMAObjectData::LEGACY_DEPT.name) end
  def legacy_dept_options; input_options_locator([], PAHMAObjectData::LEGACY_DEPT.name) end

  def num_pieces_input; input_locator([], PAHMAObjectData::NUM_OBJECTS.name) end

  def count_note_input; input_locator([], PAHMAObjectData::INVENTORY_COUNT.name) end

  def is_component_input; input_locator([], PAHMAObjectData::IS_COMPONENT.name) end
  def is_component_options; input_options_locator([], PAHMAObjectData::IS_COMPONENT.name) end

  def obj_status_input(index); input_locator([fieldset(PAHMAObjectData::OBJ_STATUS_LIST.name, index)]) end
  def obj_status_options(index); input_options_locator([fieldset(PAHMAObjectData::OBJ_STATUS_LIST.name, index)]) end

  def alt_num_input(index); input_locator([fieldset(PAHMAObjectData::ALT_NUM_GRP.name, index)], PAHMAObjectData::ALT_NUM.name) end
  def alt_num_type_input(index); input_locator([fieldset(PAHMAObjectData::ALT_NUM_GRP.name, index)], PAHMAObjectData::ALT_NUM_TYPE.name) end
  def alt_num_type_options(index); input_options_locator([fieldset(PAHMAObjectData::ALT_NUM_GRP.name, index)], PAHMAObjectData::ALT_NUM_TYPE.name) end
  def alt_num_note_input(index); input_locator([fieldset(PAHMAObjectData::ALT_NUM_GRP.name, index)], PAHMAObjectData::ALT_NUM_NOTE.name) end

  def desc_text_area(index); text_area_locator([fieldset(PAHMAObjectData::BRIEF_DESCRIP.name, index)]) end

  def current_location_input; input_locator_by_label(PAHMAObjectData::CURRENT_STORAGE_LOCATION.label) end
  def current_crate_input; input_locator_by_label(PAHMAObjectData::CURRENT_CRATE.label) end

  def obj_class_name_input(index); input_locator([fieldset(PAHMAObjectData::OBJ_CLASS_GRP.name, index)], PAHMAObjectData::OBJ_CLASS_NAME.name) end
  def obj_class_name_options(index); input_options_locator([fieldset(PAHMAObjectData::OBJ_CLASS_GRP.name, index)], PAHMAObjectData::OBJ_CLASS_NAME.name) end
  def obj_class_note_input(index); input_locator([fieldset(PAHMAObjectData::OBJ_CLASS_GRP.name, index)], PAHMAObjectData::OBJ_CLASS_NOTE.name) end

  def object_name_input(index); input_locator([fieldset(PAHMAObjectData::OBJ_NAME_GRP.name, index)], PAHMAObjectData::OBJ_NAME_NAME.name) end
  def object_name_level_input(index); input_locator([fieldset(PAHMAObjectData::OBJ_NAME_GRP.name, index)], PAHMAObjectData::OBJ_NAME_LEVEL.name) end
  def object_name_level_options(index); input_options_locator([fieldset(PAHMAObjectData::OBJ_NAME_GRP.name, index)], PAHMAObjectData::OBJ_NAME_LEVEL.name) end
  def object_name_currency_input(index); input_locator([fieldset(PAHMAObjectData::OBJ_NAME_GRP.name, index)], PAHMAObjectData::OBJ_NAME_CURRENCY.name) end
  def object_name_currency_options(index); input_options_locator([fieldset(PAHMAObjectData::OBJ_NAME_GRP.name, index)], PAHMAObjectData::OBJ_NAME_CURRENCY.name) end
  def object_name_system_input(index); input_locator([fieldset(PAHMAObjectData::OBJ_NAME_GRP.name, index)], PAHMAObjectData::OBJ_NAME_SYSTEM.name) end
  def object_name_system_options(index); input_options_locator([fieldset(PAHMAObjectData::OBJ_NAME_GRP.name, index)], PAHMAObjectData::OBJ_NAME_SYSTEM.name) end
  def object_name_type_input(index); input_locator([fieldset(PAHMAObjectData::OBJ_NAME_GRP.name, index)], PAHMAObjectData::OBJ_NAME_TYPE.name) end
  def object_name_type_options(index); input_options_locator([fieldset(PAHMAObjectData::OBJ_NAME_GRP.name, index)], PAHMAObjectData::OBJ_NAME_TYPE.name) end
  def object_name_lang_input(index); input_locator([fieldset(PAHMAObjectData::OBJ_NAME_GRP.name, index)], PAHMAObjectData::OBJ_NAME_LANG.name) end
  def object_name_lang_options(index); input_options_locator([fieldset(PAHMAObjectData::OBJ_NAME_GRP.name, index)], PAHMAObjectData::OBJ_NAME_LANG.name) end
  def object_name_note_input(index); input_locator([fieldset(PAHMAObjectData::OBJ_NAME_GRP.name, index)], PAHMAObjectData::OBJ_NAME_NOTE.name) end

  def resp_coll_input(index); input_locator([fieldset(PAHMAObjectData::RESPONSIBLE_DEPTS.name, index)]) end
  def resp_coll_options(index); input_options_locator([fieldset(PAHMAObjectData::RESPONSIBLE_DEPTS.name, index)]) end

  def obj_type_input; input_locator([], PAHMAObjectData::COLLECTION.name) end
  def obj_type_options; input_options_locator([], PAHMAObjectData::COLLECTION.name) end

  def assoc_cult_grp_input(index);input_locator([fieldset(PAHMAObjectData::ASSOC_PPL_GRP.name, index)], PAHMAObjectData::ASSOC_PPL.name) end
  def assoc_cult_grp_type_input(index); input_locator([fieldset(PAHMAObjectData::ASSOC_PPL_GRP.name, index)], PAHMAObjectData::ASSOC_PPL_TYPE.name) end
  def assoc_cult_grp_type_options(index); input_options_locator([fieldset(PAHMAObjectData::ASSOC_PPL_GRP.name, index)], PAHMAObjectData::ASSOC_PPL_TYPE.name) end
  def assoc_cult_grp_note_input(index); input_locator([fieldset(PAHMAObjectData::ASSOC_PPL_GRP.name, index)], PAHMAObjectData::ASSOC_PPL_NOTE.name) end

  def ethno_file_code_input(index); input_locator([fieldset(PAHMAObjectData::ETHNO_FILE_CODE_LIST.name, index)]) end
  def ethno_file_code_options(index); input_options_locator([fieldset(PAHMAObjectData::ETHNO_FILE_CODE_LIST.name, index)]) end

  def obj_comment_text_area(index); text_area_locator([fieldset(PAHMAObjectData::COMMENT.name, index)]) end

  def annot_type_input(index); input_locator([fieldset(PAHMAObjectData::ANNOT_GRP.name, index)], PAHMAObjectData::ANNOT_TYPE.name) end
  def annot_type_options(index); input_options_locator([fieldset(PAHMAObjectData::ANNOT_GRP.name, index)], PAHMAObjectData::ANNOT_TYPE.name) end
  def annot_note_input(index); input_locator([fieldset(PAHMAObjectData::ANNOT_GRP.name, index)], PAHMAObjectData::ANNOT_NOTE.name) end
  def annot_date_input(index); input_locator([fieldset(PAHMAObjectData::ANNOT_GRP.name, index)], PAHMAObjectData::ANNOT_DATE.name) end
  def annot_author_input(index); input_locator([fieldset(PAHMAObjectData::ANNOT_GRP.name, index)], PAHMAObjectData::ANNOT_AUTHOR.name) end

  def part_measured_input(index); input_locator([fieldset(PAHMAObjectData::MEASURE_PART_GRP.name, index)], PAHMAObjectData::MEASURE_PART.name) end
  def measure_dimen_add_btn(index); add_button_locator [fieldset(PAHMAObjectData::MEASURE_PART_GRP.name, index), fieldset(PAHMAObjectData::MEASURE_DIMEN_GRP.name)] end
  def measure_dimen_input(indices); input_locator([fieldset(PAHMAObjectData::MEASURE_PART_GRP.name, indices[0]), fieldset(PAHMAObjectData::MEASURE_DIMEN_GRP.name, indices[1])], PAHMAObjectData::MEASURE_DIMENSION.name) end
  def measure_dimen_options(indices); input_options_locator([fieldset(PAHMAObjectData::MEASURE_PART_GRP.name, indices[0]), fieldset(PAHMAObjectData::MEASURE_DIMEN_GRP.name, indices[1])], PAHMAObjectData::MEASURE_DIMENSION.name) end
  def measure_by_input(indices); input_locator([fieldset(PAHMAObjectData::MEASURE_PART_GRP.name, indices[0]), fieldset(PAHMAObjectData::MEASURE_DIMEN_GRP.name, indices[1])], PAHMAObjectData::MEASURE_BY.name) end
  def measure_value_input(indices); input_locator([fieldset(PAHMAObjectData::MEASURE_PART_GRP.name, indices[0]), fieldset(PAHMAObjectData::MEASURE_DIMEN_GRP.name, indices[1])], PAHMAObjectData::MEASURE_VALUE.name) end
  def measure_unit_input(indices); input_locator([fieldset(PAHMAObjectData::MEASURE_PART_GRP.name, indices[0]), fieldset(PAHMAObjectData::MEASURE_DIMEN_GRP.name, indices[1])], PAHMAObjectData::MEASURE_UNIT.name) end
  def measure_unit_options(indices); input_options_locator([fieldset(PAHMAObjectData::MEASURE_PART_GRP.name, indices[0]), fieldset(PAHMAObjectData::MEASURE_DIMEN_GRP.name, indices[1])], PAHMAObjectData::MEASURE_UNIT.name) end
  def measure_qualifier_input(indices); input_locator([fieldset(PAHMAObjectData::MEASURE_PART_GRP.name, indices[0]), fieldset(PAHMAObjectData::MEASURE_DIMEN_GRP.name, indices[1])], PAHMAObjectData::MEASURE_QUALIFIER.name) end
  def measure_date_input(indices); input_locator([fieldset(PAHMAObjectData::MEASURE_PART_GRP.name, indices[0]), fieldset(PAHMAObjectData::MEASURE_DIMEN_GRP.name, indices[1])], PAHMAObjectData::MEASURE_DATE.name) end
  def measure_note_input(indices); input_locator([fieldset(PAHMAObjectData::MEASURE_PART_GRP.name, indices[0]), fieldset(PAHMAObjectData::MEASURE_DIMEN_GRP.name, indices[1])], PAHMAObjectData::MEASURE_NOTE.name) end

  def material_input(index); input_locator([fieldset(PAHMAObjectData::MATERIAL_GRP.name, index)], PAHMAObjectData::MATERIAL.name) end
  def material_component_input(index); input_locator([fieldset(PAHMAObjectData::MATERIAL_GRP.name, index)], PAHMAObjectData::MATERIAL_COMPONENT.name) end
  def material_name_input(index); input_locator([fieldset(PAHMAObjectData::MATERIAL_GRP.name, index)], PAHMAObjectData::MATERIAL_NAME.name) end
  def material_source_input(index); input_locator([fieldset(PAHMAObjectData::MATERIAL_GRP.name, index)], PAHMAObjectData::MATERIAL_SOURCE.name) end
  def material_note_input(index); input_locator([fieldset(PAHMAObjectData::MATERIAL_GRP.name, index)], PAHMAObjectData::MATERIAL_NOTE.name) end

  def taxon_name_input(index); input_locator([fieldset(PAHMAObjectData::TAXON_IDENT_GRP.name, index)], PAHMAObjectData::TAXON_NAME.name) end
  def taxon_qualifier_input(index); input_locator([fieldset(PAHMAObjectData::TAXON_IDENT_GRP.name, index)], PAHMAObjectData::TAXON_QUALIFIER.name) end
  def taxon_qualifier_options(index); input_options_locator([fieldset(PAHMAObjectData::TAXON_IDENT_GRP.name, index)], PAHMAObjectData::TAXON_QUALIFIER.name) end
  def taxon_by_input(index); input_locator([fieldset(PAHMAObjectData::TAXON_IDENT_GRP.name, index)], PAHMAObjectData::TAXON_BY.name) end
  def taxon_date_input(index); structured_date_input_locator([fieldset(PAHMAObjectData::TAXON_IDENT_GRP.name, index)]) end
  def taxon_institution_input(index); input_locator([fieldset(PAHMAObjectData::TAXON_IDENT_GRP.name, index)], PAHMAObjectData::TAXON_INSTITUTION.name) end
  def taxon_kind_input(index); input_locator([fieldset(PAHMAObjectData::TAXON_IDENT_GRP.name, index)], PAHMAObjectData::TAXON_KIND.name) end
  def taxon_kind_options(index); input_options_locator([fieldset(PAHMAObjectData::TAXON_IDENT_GRP.name, index)], PAHMAObjectData::TAXON_KIND.name) end
  def taxon_ref_input(index); input_locator([fieldset(PAHMAObjectData::TAXON_IDENT_GRP.name, index)], PAHMAObjectData::TAXON_REF.name) end
  def taxon_page_input(index); input_locator([fieldset(PAHMAObjectData::TAXON_IDENT_GRP.name, index)], PAHMAObjectData::TAXON_PAGE.name) end
  def taxon_note_input(index); input_locator([fieldset(PAHMAObjectData::TAXON_IDENT_GRP.name, index)], PAHMAObjectData::TAXON_NOTE.name) end

  def title_input(index); input_locator([fieldset(PAHMAObjectData::TITLE_GRP.name, index)], PAHMAObjectData::TITLE.name) end
  def title_type_input(index); input_locator([fieldset(PAHMAObjectData::TITLE_GRP.name, index)], PAHMAObjectData::TITLE_TYPE.name) end
  def title_type_options(index); input_options_locator([fieldset(PAHMAObjectData::TITLE_GRP.name, index)], PAHMAObjectData::TITLE_TYPE.name) end
  def title_lang_input(index); input_locator([fieldset(PAHMAObjectData::TITLE_GRP.name, index)], PAHMAObjectData::TITLE_LANG.name) end
  def title_lang_options(index); input_options_locator([fieldset(PAHMAObjectData::TITLE_GRP.name, index)], PAHMAObjectData::TITLE_LANG.name) end
  def title_translation_input(indices); input_locator([fieldset(PAHMAObjectData::TITLE_GRP.name, indices[0]), fieldset(PAHMAObjectData::TITLE_TRANSLATION_SUB_GRP.name, indices[1])], PAHMAObjectData::TITLE_TRANSLATION.name) end
  def title_translation_lang_input(indices); input_locator([fieldset(PAHMAObjectData::TITLE_GRP.name, indices[0]), fieldset(PAHMAObjectData::TITLE_TRANSLATION_SUB_GRP.name, indices[1])], PAHMAObjectData::TITLE_TRANSLATION_LANG.name) end
  def title_translation_lang_options(indices); input_options_locator([fieldset(PAHMAObjectData::TITLE_GRP.name, indices[0]), fieldset(PAHMAObjectData::TITLE_TRANSLATION_SUB_GRP.name, indices[1])], PAHMAObjectData::TITLE_TRANSLATION_LANG.name) end

  def usage_input(index); text_area_locator([fieldset(PAHMAObjectData::USAGE_GRP.name, index)], PAHMAObjectData::USAGE.name) end
  def usage_note_input(index); text_area_locator([fieldset(PAHMAObjectData::USAGE_GRP.name, index)], PAHMAObjectData::USAGE_NOTE.name) end

  def series_input; input_locator([], PAHMAObjectData::AUDIO_SERIES.name) end
  def series_options; input_options_locator([], PAHMAObjectData::AUDIO_SERIES.name) end

  def collection_input(index); input_locator([fieldset(PAHMAObjectData::PAHMA_COLLECTION_LIST.name, index)]) end
  def collection_options(index); input_options_locator([fieldset(PAHMAObjectData::PAHMA_COLLECTION_LIST.name, index)]) end

  def tms_data_source_input; input_locator([], PAHMAObjectData::TMS_DATA_SRC.name) end
  def tms_data_source_options; input_options_locator([], PAHMAObjectData::TMS_DATA_SRC.name) end

  # OBJECT NUM

  def enter_object_number(data)
    logger.debug "Entering object number '#{data[PAHMAObjectData::OBJECT_NUM.name]}'"
    wait_for_element_and_type(object_num_input, data[PAHMAObjectData::OBJECT_NUM.name])
  end

  def verify_object_number(data)
    tex
  end

  # LEGACY DEPT

  def select_legacy_dept(data)
    logger.debug "Entering legacy dept '#{data[PAHMAObjectData::LEGACY_DEPT.name]}'"
    wait_for_options_and_select(legacy_dept_input, legacy_dept_options, data[PAHMAObjectData::LEGACY_DEPT.name])
  end

  # NUM PIECES

  def enter_num_pieces(data)
    logger.debug "Entering number of pieces '#{data[PAHMAObjectData::NUM_OBJECTS.name]}'"
    wait_for_element_and_type(num_pieces_input, data[PAHMAObjectData::NUM_OBJECTS.name])
  end

  # COUNT NOTE

  def enter_count_note(data)
    logger.debug "Entering count note '#{data[PAHMAObjectData::INVENTORY_COUNT.name]}'"
    wait_for_element_and_type(count_note_input, data[PAHMAObjectData::INVENTORY_COUNT.name])
  end

  # IS COMPONENT

  def select_is_component(data)
    logger.debug "Entering is-component '#{data[PAHMAObjectData::IS_COMPONENT.name]}'"
    wait_for_options_and_select(is_component_input, is_component_options, data[PAHMAObjectData::IS_COMPONENT.name])
  end

  # OBJECT STATUS

  def select_object_statuses(data)
    obj_statuses = data[PAHMAObjectData::OBJ_STATUS_LIST.name] ? data[PAHMAObjectData::OBJ_STATUS_LIST.name] : []
    prep_fieldsets_for_test_data([fieldset(PAHMAObjectData::OBJ_STATUS_LIST.name)], obj_statuses)
    obj_statuses.each_with_index do |obj_status, index|
      logger.debug "Entering object status '#{obj_status}' at index #{index}"
      wait_for_options_and_select(obj_status_input(index), obj_status_options(index), obj_status[PAHMAObjectData::OBJ_STATUS.name])
    end
  end

  # ALTERNATE NUMBER

  def enter_alt_num(data)
    alt_nums = data[PAHMAObjectData::ALT_NUM_GRP.name]
    prep_fieldsets_for_test_data([fieldset(PAHMAObjectData::ALT_NUM_GRP.name)], alt_nums)
    alt_nums && alt_nums.each_with_index do |alt_num, index|
      logger.debug "Entering alternate number '#{alt_num}' at index #{index}"
      wait_for_element_and_type(alt_num_input(index), alt_num[PAHMAObjectData::ALT_NUM.name])
      wait_for_options_and_select(alt_num_type_input(index), alt_num_type_options(index), alt_num[PAHMAObjectData::ALT_NUM_TYPE.name])
      wait_for_element_and_type(alt_num_note_input(index), alt_num[PAHMAObjectData::ALT_NUM_NOTE.name])
    end
  end

  # DESCRIPTION

  def enter_description(data)
    descrips = data[PAHMAObjectData::BRIEF_DESCRIPS.name]
    prep_fieldsets_for_test_data([fieldset(PAHMAObjectData::BRIEF_DESCRIPS.name)], data)
    descrips && descrips.each_with_index do |descrip, index|
      logger.debug "Entering description '#{descrip}' at index #{index}"
      wait_for_element_and_type(desc_text_area(index), descrip[PAHMAObjectData::BRIEF_DESCRIP.name])
    end
  end

  def wait_for_location(data)
    wait_for_event_listener do
      wait_until(Config.short_wait) do
        when_exists(current_location_input, Config.short_wait)
        logger.debug "Current location is '#{element_value current_location_input}'"
        element_value(current_location_input) == data[PAHMAInventoryMovementData::CURRENT_LOCATION.name]
        element_value(current_crate_input) == data[PAHMAInventoryMovementData::CRATE.name]
      end
    end
  end

  # OBJECT CLASS

  def enter_object_classes(data)
    obj_classes = data[PAHMAObjectData::OBJ_CLASS_GRP.name]
    prep_fieldsets_for_test_data([fieldset(PAHMAObjectData::OBJ_CLASS_GRP.name)], obj_classes)
    obj_classes && obj_classes.each_with_index do |obj_class, index|
      logger.debug "Entering object class '#{obj_class}' at index #{index}"
      # TODO - handle creation of input options
      wait_for_element_and_type(obj_class_name_input(index), obj_class[PAHMAObjectData::OBJ_CLASS_NAME.name])
      wait_for_element_and_type(obj_class_note_input(index), obj_class[PAHMAObjectData::OBJ_CLASS_NOTE.name])
    end
  end

  # OBJECT NAME

  def enter_object_names(data)
    obj_names = data[PAHMAObjectData::OBJ_NAME_GRP.name]
    prep_fieldsets_for_test_data([fieldset(PAHMAObjectData::OBJ_NAME_GRP.name)], obj_names)
    obj_names && obj_names.each_with_index do |name, index|
      logger.debug "Entering object name '#{name}' at index #{index}"
      wait_for_element_and_type(object_name_input(index), name[PAHMAObjectData::OBJ_NAME_NAME.name])
      wait_for_options_and_select(object_name_level_input(index), object_name_level_options(index), name[PAHMAObjectData::OBJ_NAME_LEVEL.name])
      wait_for_options_and_select(object_name_currency_input(index), object_name_currency_options(index), name[PAHMAObjectData::OBJ_NAME_CURRENCY.name])
      wait_for_options_and_select(object_name_system_input(index), object_name_system_options(index), name[PAHMAObjectData::OBJ_NAME_SYSTEM.name])
      wait_for_options_and_select(object_name_type_input(index), object_name_type_options(index), name[PAHMAObjectData::OBJ_NAME_TYPE.name])
      wait_for_options_and_select(object_name_lang_input(index), object_name_lang_options(index), name[PAHMAObjectData::OBJ_NAME_LANG.name])
      wait_for_element_and_type(object_name_note_input(index), name[PAHMAObjectData::OBJ_NAME_NOTE.name])
    end
  end

  # RESPONSIBLE COLLECTIONS

  def select_resp_colls(data)
    resp_colls = data[PAHMAObjectData::RESPONSIBLE_DEPTS.name]
    prep_fieldsets_for_test_data([fieldset(PAHMAObjectData::RESPONSIBLE_DEPTS.name)], resp_colls)
    resp_colls && resp_colls.each_with_index do |resp_coll, index|
      logger.debug "Entering responsible manager '#{resp_coll}' at index #{index}"
      wait_for_options_and_select(resp_coll_input(index), resp_coll_options(index), resp_coll[PAHMAObjectData::RESPONSIBLE_DEPT.name])
    end
  end

  # OBJECT TYPE

  def enter_object_type(data)
    logger.debug "Entering object type '#{data[PAHMAObjectData::COLLECTION.name]}'"
    wait_for_options_and_select(obj_type_input, obj_type_options, data[PAHMAObjectData::COLLECTION.name])
  end

  # ASSOCIATED CULTURAL GROUP

  def enter_assoc_cult_grps(data)
    assoc_cult_grps = data[PAHMAObjectData::ASSOC_PPL_GRP.name]
    prep_fieldsets_for_test_data([fieldset(PAHMAObjectData::ASSOC_PPL_GRP.name)], assoc_cult_grps)
    assoc_cult_grps && assoc_cult_grps.each_with_index do |assoc_cult, index|
      logger.debug "Entering associated cultural group '#{assoc_cult}'"
      # TODO - handle creation of input options
      wait_for_element_and_type(assoc_cult_grp_input(index), assoc_cult[PAHMAObjectData::ASSOC_PPL.name])
      wait_for_options_and_select(assoc_cult_grp_type_input(index), assoc_cult_grp_type_options(index), assoc_cult[PAHMAObjectData::ASSOC_PPL_TYPE.name])
      wait_for_element_and_type(assoc_cult_grp_note_input(index), assoc_cult[PAHMAObjectData::ASSOC_PPL_NOTE.name])
    end
  end

  # ETHNOGRAPHIC FILE CODE

  def enter_enthno_file_codes(data)
    ethno_file_codes = data[PAHMAObjectData::ETHNO_FILE_CODE_LIST.name]
    prep_fieldsets_for_test_data([fieldset(PAHMAObjectData::ETHNO_FILE_CODE_LIST.name)], ethno_file_codes)
    ethno_file_codes && ethno_file_codes.each_with_index do |code, index|
      logger.debug "Entering ethnographic file code '#{code}'"
      # TODO - handle creation of input options
      wait_for_element_and_type(ethno_file_code_input(index), code[PAHMAObjectData::ETHNO_FILE_CODE.name])
    end
  end

  # OBJECT COMMENT

  def enter_object_comments(data)
    obj_comments = data[PAHMAObjectData::COMMENTS.name]
    prep_fieldsets_for_test_data([fieldset(PAHMAObjectData::COMMENTS.name)], obj_comments)
    obj_comments && obj_comments.each_with_index do |comment, index|
      logger.debug "Entering object comment '#{comment}' at index #{index}"
      wait_for_element_and_type(obj_comment_text_area(index), comment[PAHMAObjectData::COMMENT.name])
    end
  end

  # ANNOTATIONS

  def enter_annotations(data)
    annotations = data[PAHMAObjectData::ANNOT_GRP.name]
    prep_fieldsets_for_test_data([fieldset(PAHMAObjectData::ANNOT_GRP.name)], annotations)
    annotations && annotations.each_with_index do |annot, index|
      logger.debug "Entering annotation '#{annot}' at index #{index}"
      wait_for_options_and_select(annot_type_input(index), annot_type_options(index), annot[PAHMAObjectData::ANNOT_TYPE.name])
      wait_for_element_and_type(annot_note_input(index), annot[PAHMAObjectData::ANNOT_NOTE.name])
      enter_simple_date(annot_date_input(index), annot[PAHMAObjectData::ANNOT_DATE.name])
      # TODO - handle creation of input options
      wait_for_element_and_type(annot_author_input(index), annot[PAHMAObjectData::ANNOT_AUTHOR.name])
    end
  end

  # DIMENSIONS

  def enter_dimensions(data)
    dimensions = data[PAHMAObjectData::MEASURE_PART_GRP.name]
    prep_fieldsets_for_test_data([fieldset(PAHMAObjectData::MEASURE_PART_GRP.name)], dimensions)
    dimensions && dimensions.each_with_index do |dim, index|
      logger.debug "Entering dimension '#{dim}' at index #{index}"
      wait_for_element_and_type(part_measured_input(index), dim[PAHMAObjectData::MEASURE_PART.name])

      measures = dim[PAHMAObjectData::MEASURE_DIMEN_GRP.name]
      prep_fieldsets_for_test_data([fieldset(PAHMAObjectData::MEASURE_PART_GRP.name, index), fieldset(PAHMAObjectData::MEASURE_DIMEN_GRP.name)], measures)
      measures && measures.each_with_index do |meas, sub_index|
        indices = [index, sub_index]
        logger.debug "Entering dimension measurement '#{meas}' at indices #{indices}"
        wait_for_options_and_select(measure_dimen_input(indices), measure_dimen_options(indices), meas[PAHMAObjectData::MEASURE_DIMENSION.name])
        # TODO - handle creation of input options
        wait_for_element_and_type(measure_by_input(indices), meas[PAHMAObjectData::MEASURE_BY.name])
        wait_for_element_and_type(measure_value_input(indices), meas[PAHMAObjectData::MEASURE_VALUE.name])
        wait_for_options_and_select(measure_unit_input(indices), measure_unit_options(indices), meas[PAHMAObjectData::MEASURE_UNIT.name])
        wait_for_element_and_type(measure_qualifier_input(indices), meas[PAHMAObjectData::MEASURE_QUALIFIER.name])
        enter_simple_date(measure_date_input(indices), meas[PAHMAObjectData::MEASURE_DATE.name])
        wait_for_element_and_type(measure_note_input(indices), meas[PAHMAObjectData::MEASURE_NOTE.name])
      end
    end
  end

  # MATERIALS

  def enter_materials(data)
    materials = data_set[PAHMAObjectData::MATERIAL_GRP.name]
    prep_fieldsets_for_test_data([fieldset(PAHMAObjectData::MATERIAL_GRP.name)], materials)
    materials && materials.each_with_index do |mat, index|
      logger.debug "Entering material '#{mat}' at index #{index}"
      # TODO - handle creation of input options
      wait_for_element_and_type(material_input(index), mat[PAHMAObjectData::MATERIAL.name])
      wait_for_element_and_type(material_component_input(index), mat[PAHMAObjectData::MATERIAL_COMPONENT.name])
      wait_for_element_and_type(material_name_input(index), mat[PAHMAObjectData::MATERIAL_NAME.name])
      attempt_action(data_input_errors, mat) { wait_for_element_and_type(material_source_input(index), mat[PAHMAObjectData::MATERIAL_SOURCE.name]) }
      attempt_action(data_input_errors, mat) { wait_for_element_and_type(material_note_input(index), mat[PAHMAObjectData::MATERIAL_NOTE.name]) }
    end
  end

  # TAXONOMIC INFORMATION

  def enter_taxonomics(data)
    taxonomics = data[PAHMAObjectData::TAXON_IDENT_GRP.name]
    prep_fieldsets_for_test_data([fieldset(PAHMAObjectData::TAXON_IDENT_GRP.name)], taxonomics)
    taxonomics && taxonomics.each_with_index do |tax, index|
      logger.debug "Entering taxonomic information '#{tax}' at index #{index}"
      # TODO - handle creation of input options
      wait_for_element_and_type(taxon_name_input(index), tax[PAHMAObjectData::TAXON_NAME.name])
      wait_for_options_and_select(taxon_qualifier_input(index), taxon_qualifier_options(index), tax[PAHMAObjectData::TAXON_QUALIFIER.name])
      # TODO - handle creation of input options
      wait_for_element_and_type(taxon_by_input(index), tax[PAHMAObjectData::TAXON_BY.name])
      # TODO - taxon date input
      # TODO - handle creation of input options
      wait_for_element_and_type(taxon_institution_input(index), tax[PAHMAObjectData::TAXON_INSTITUTION.name])
      wait_for_options_and_select(taxon_kind_input(index), taxon_kind_options(index), tax[PAHMAObjectData::TAXON_KIND.name])
      # TODO - handle creation of input options
      wait_for_element_and_type(taxon_ref_input(index), tax[PAHMAObjectData::TAXON_REF.name])
      wait_for_element_and_type(taxon_page_input(index), tax[PAHMAObjectData::TAXON_PAGE.name])
      wait_for_element_and_type(taxon_note_input(index), tax[PAHMAObjectData::TAXON_NOTE.name])
    end
  end

  # TITLE

  def enter_titles(data)
    titles = data[PAHMAObjectData::TITLE_GRP.name]
    prep_fieldsets_for_test_data([fieldset(PAHMAObjectData::TITLE_GRP.name)], titles)
    titles && titles.each_with_index do |title, index|
      logger.debug "Entering title data #{title} at index #{index}"
      wait_for_element_and_type(title_input(index), title[PAHMAObjectData::TITLE.name])
      wait_for_options_and_select(title_type_input(index), title_type_options(index), title[PAHMAObjectData::TITLE_TYPE.name])
      wait_for_options_and_select(title_lang_input(index), title_lang_options(index), title[PAHMAObjectData::TITLE_LANG.name])

      translations = title[PAHMAObjectData::TITLE_TRANSLATION_SUB_GRP.name]
      prep_fieldsets_for_test_data([fieldset(PAHMAObjectData::TITLE_GRP.name, index), fieldset(PAHMAObjectData::TITLE_TRANSLATION_SUB_GRP.name)], translations)
      translations && translations.each_with_index do |trans, sub_index|
        logger.debug "Entering translation data #{trans} at sub-index #{sub_index}"
        wait_for_element_and_type(title_translation_input([index, sub_index]), trans[PAHMAObjectData::TITLE_TRANSLATION.name])
        wait_for_options_and_select(title_translation_lang_input([index, sub_index]), title_translation_lang_options([index, sub_index]), trans[PAHMAObjectData::TITLE_TRANSLATION_LANG.name])
      end
    end
  end

  # USAGE

  def enter_usages(data)
    usages = data[PAHMAObjectData::USAGE_GRP.name]
    prep_fieldsets_for_test_data([fieldset(PAHMAObjectData::USAGE_GRP.name)], usages)
    usages && usages.each_with_index do |usage, index|
      logger.debug "Entering usage '#{usage}' at index #{index}"
      wait_for_element_and_type(usage_input(index), usage[PAHMAObjectData::USAGE.name])
      wait_for_element_and_type(usage_note_input(index), usage[PAHMAObjectData::USAGE_NOTE.name])
    end
  end

  # SERIES

  def select_series(data)
    logger.debug "Selecting series '#{data[PAHMAObjectData::AUDIO_SERIES.name]}'"
    wait_for_options_and_select(series_input, series_options, data[PAHMAObjectData::AUDIO_SERIES.name])
  end

  # COLLECTIONS

  def select_collections(data)
    collections = data_set[PAHMAObjectData::PAHMA_COLLECTION_LIST.name]
    prep_fieldsets_for_test_data([fieldset(PAHMAObjectData::PAHMA_COLLECTION_LIST.name)], collections)
    collections && collections.each_with_index do |collect, index|
      logger.debug "Entering collection '#{collect}' at index #{index}"
      wait_for_options_and_select(collection_input(index), collection_options(index), collect[PAHMAObjectData::PAHMA_COLLECTION.name])
    end
  end

  # TMS SOURCE

  def select_tms_source(data)
    logger.debug "Selecting TMS data source '#{data[PAHMAObjectData::TMS_DATA_SRC.name]}'"
    wait_for_options_and_select(tms_data_source_input, tms_data_source_options, data[PAHMAObjectData::TMS_DATA_SRC.name])
  end

  def verify_object_info_data(data_set)
    logger.debug "Checking object number #{data_set[PAHMAObjectData::OBJECT_NUM.name]}"
    object_data_errors = []
    text_values_match?(data_set[PAHMAObjectData::OBJECT_NUM.name], element_value(object_num_input), object_data_errors)

    legacy_dept = data_set[PAHMAObjectData::LEGACY_DEPT.name]
    legacy_dept && text_values_match?(legacy_dept, element_value(legacy_dept_input), object_data_errors)

    num_pieces = data_set[PAHMAObjectData::NUM_OBJECTS.name]
    num_pieces && text_values_match?(num_pieces, element_value(num_pieces_input), object_data_errors)

    count_note = data_set[PAHMAObjectData::INVENTORY_COUNT.name]
    count_note && text_values_match?(count_note, element_value(count_note_input), object_data_errors)

    is_component = data_set[PAHMAObjectData::IS_COMPONENT.name]
    is_component && text_values_match?(is_component, element_value(is_component_input), object_data_errors)

    obj_statuses = data_set[PAHMAObjectData::OBJ_STATUS_LIST.name]
    obj_statuses && obj_statuses.each do |obj_status|
      index = obj_statuses.index obj_status
      text_values_match?(obj_status[PAHMAObjectData::OBJ_STATUS.name], element_value(obj_status_input index), object_data_errors)
    end

    alt_nums = data_set[PAHMAObjectData::ALT_NUM_GRP.name]
    alt_nums && alt_nums.each do |alt_num|
      index = alt_nums.index alt_num
      text_values_match?(alt_num[PAHMAObjectData::ALT_NUM.name], element_value(alt_num_input(index)), object_data_errors)
      text_values_match?(alt_num[PAHMAObjectData::ALT_NUM_TYPE.name], element_value(alt_num_type_input(index)), object_data_errors)
      text_values_match?(alt_num[PAHMAObjectData::ALT_NUM_NOTE.name], element_value(alt_num_note_input(index)), object_data_errors)
    end

    descrips = data_set[PAHMAObjectData::BRIEF_DESCRIPS.name]
    descrips && descrips.each do |descrip|
      index = descrips.index descrip
      text_values_match?(descrip[PAHMAObjectData::BRIEF_DESCRIP.name], element_value(desc_text_area(index)), object_data_errors)
    end

    obj_classes = data_set[PAHMAObjectData::OBJ_CLASS_GRP.name]
    obj_classes && obj_classes.each do |obj_class|
      index = obj_classes.index obj_class
      text_values_match?(obj_class[PAHMAObjectData::OBJ_CLASS_NAME.name], element_value(obj_class_name_input(index)), object_data_errors)
    end

    obj_names = data_set[PAHMAObjectData::OBJ_NAME_GRP.name]
    obj_names && obj_names.each do |name|
      index = obj_names.index name
      text_values_match?(name[PAHMAObjectData::OBJ_NAME_NAME.name], element_value(object_name_input index), object_data_errors)
      text_values_match?(name[PAHMAObjectData::OBJ_NAME_CURRENCY.name], element_value(object_name_currency_input index), object_data_errors)
      text_values_match?(name[PAHMAObjectData::OBJ_NAME_LEVEL.name], element_value(object_name_level_input index), object_data_errors)
      text_values_match?(name[PAHMAObjectData::OBJ_NAME_SYSTEM.name], element_value(object_name_system_input index), object_data_errors)
      text_values_match?(name[PAHMAObjectData::OBJ_NAME_TYPE.name], element_value(object_name_type_input index), object_data_errors)
      text_values_match?(name[PAHMAObjectData::OBJ_NAME_LANG.name], element_value(object_name_lang_input index), object_data_errors)
      text_values_match?(name[PAHMAObjectData::OBJ_NAME_NOTE.name], element_value(object_name_note_input index), object_data_errors)
    end

    resp_colls = data_set[PAHMAObjectData::RESPONSIBLE_DEPTS.name]
    resp_colls && resp_colls.each do |resp_coll|
      index = resp_colls.index resp_coll
      text_values_match?(resp_coll[PAHMAObjectData::RESPONSIBLE_DEPT.name], element_value(resp_coll_input index), object_data_errors)
    end

    obj_type = data_set[PAHMAObjectData::COLLECTION.name]
    obj_type && text_values_match?(obj_type, element_value(obj_type_input), object_data_errors)

    assoc_cult_grps = data_set[PAHMAObjectData::ASSOC_PPL_GRP.name]
    assoc_cult_grps && assoc_cult_grps.each do |assoc_cult|
      index = assoc_cult_grps.index assoc_cult
      text_values_match?(assoc_cult[PAHMAObjectData::ASSOC_PPL.name], element_value(assoc_cult_grp_input index), object_data_errors)
      text_values_match?(assoc_cult[PAHMAObjectData::ASSOC_PPL_TYPE.name], element_value(assoc_cult_grp_type_input index), object_data_errors)
      text_values_match?(assoc_cult[PAHMAObjectData::ASSOC_PPL_NOTE.name], element_value(assoc_cult_grp_note_input index), object_data_errors)
    end

    ethno_file_codes = data_set[PAHMAObjectData::ETHNO_FILE_CODE_LIST.name]
    ethno_file_codes && ethno_file_codes.each do |code|
      index = ethno_file_codes.index code
      text_values_match?(code[PAHMAObjectData::ETHNO_FILE_CODE.name], element_value(ethno_file_code_input index), object_data_errors)
    end

    obj_comments = data_set[PAHMAObjectData::COMMENTS.name]
    obj_comments && obj_comments.each do |comment|
      index = obj_comments.index comment
      text_values_match?(comment[PAHMAObjectData::COMMENT.name], element_value(obj_comment_text_area index), object_data_errors)
    end

    annotations = data_set[PAHMAObjectData::ANNOT_GRP.name]
    annotations && annotations.each do |annot|
      index = annotations.index annot
      text_values_match?(annot[PAHMAObjectData::ANNOT_TYPE.name], element_value(annot_type_input index), object_data_errors)
      text_values_match?(annot[PAHMAObjectData::ANNOT_NOTE.name], element_value(annot_note_input index), object_data_errors)
      text_values_match?(annot[PAHMAObjectData::ANNOT_DATE.name], element_value(annot_date_input index), object_data_errors)
      text_values_match?(annot[PAHMAObjectData::ANNOT_AUTHOR.name], element_value(annot_author_input index), object_data_errors)
    end

    dimensions = data_set[PAHMAObjectData::MEASURE_PART_GRP.name]
    dimensions && dimensions.each do |dim|
      index = dimensions.index dim
      text_values_match?(dim[PAHMAObjectData::MEASURE_PART.name], element_value(part_measured_input index), object_data_errors)
      measures = dim[PAHMAObjectData::MEASURE_DIMEN_GRP.name]
      measures && measures.each do |meas|
        sub_index = measures.index meas
        indices = [index, sub_index]
        text_values_match?(meas[PAHMAObjectData::MEASURE_DIMENSION.name], element_value(measure_dimen_input indices), object_data_errors)
        text_values_match?(meas[PAHMAObjectData::MEASURE_BY.name], element_value(measure_by_input indices), object_data_errors)
        text_values_match?(meas[PAHMAObjectData::MEASURE_VALUE.name], element_value(measure_value_input indices), object_data_errors)
        text_values_match?(meas[PAHMAObjectData::MEASURE_UNIT.name], element_value(measure_unit_input indices), object_data_errors)
        text_values_match?(meas[PAHMAObjectData::MEASURE_QUALIFIER.name], element_value(measure_qualifier_input indices), object_data_errors)
        text_values_match?(meas[PAHMAObjectData::MEASURE_DATE.name], element_value(measure_date_input indices), object_data_errors)
        text_values_match?(meas[PAHMAObjectData::MEASURE_NOTE.name], element_value(measure_note_input indices), object_data_errors)
      end
    end

    materials = data_set[PAHMAObjectData::MATERIAL_GRP.name]
    materials && materials.each do |mat|
      index = materials.index mat
      text_values_match?(mat[PAHMAObjectData::MATERIAL.name], element_value(material_input index), object_data_errors)
      text_values_match?(mat[PAHMAObjectData::MATERIAL_COMPONENT.name], element_value(material_component_input index), object_data_errors)
      text_values_match?(mat[PAHMAObjectData::MATERIAL_NAME.name], element_value(material_name_input index), object_data_errors)
      text_values_match?(mat[PAHMAObjectData::MATERIAL_SOURCE.name], element_value(material_source_input index), object_data_errors)
      text_values_match?(mat[PAHMAObjectData::MATERIAL_NOTE.name], element_value(material_note_input index), object_data_errors)
    end

    taxonomics = data_set[PAHMAObjectData::TAXON_IDENT_GRP.name]
    taxonomics && taxonomics.each do |tax|
      index = taxonomics.index tax
      text_values_match?(tax[PAHMAObjectData::TAXON_NAME.name], element_value(taxon_name_input index), object_data_errors)
      text_values_match?(tax[PAHMAObjectData::TAXON_QUALIFIER.name], element_value(taxon_qualifier_input index), object_data_errors)
      text_values_match?(tax[PAHMAObjectData::TAXON_BY.name], element_value(taxon_by_input index), object_data_errors)
      text_values_match?(tax[PAHMAObjectData::TAXON_INSTITUTION.name], element_value(taxon_institution_input index), object_data_errors)
      text_values_match?(tax[PAHMAObjectData::TAXON_KIND.name], element_value(taxon_kind_input index), object_data_errors)
      text_values_match?(tax[PAHMAObjectData::TAXON_REF.name], element_value(taxon_ref_input index), object_data_errors)
      text_values_match?(tax[PAHMAObjectData::TAXON_PAGE.name], element_value(taxon_page_input index), object_data_errors)
      text_values_match?(tax[PAHMAObjectData::TAXON_NOTE.name], element_value(taxon_note_input index), object_data_errors)
    end

    titles = data_set[PAHMAObjectData::TITLE_GRP.name]
    titles && titles.each do |title|
      index = titles.index title
      text_values_match?(title[PAHMAObjectData::TITLE.name], element_value(title_input index), object_data_errors)
      text_values_match?(title[PAHMAObjectData::TITLE_TYPE.name], element_value(title_type_input index), object_data_errors)
      text_values_match?(title[PAHMAObjectData::TITLE_LANG.name], element_value(title_lang_input index), object_data_errors)

      translations = title[PAHMAObjectData::TITLE_TRANSLATION_SUB_GRP.name]
      translations && translations.each do |trans|
        sub_index = translations.index trans
        text_values_match?(trans[PAHMAObjectData::TITLE_TRANSLATION.name], element_value(title_translation_input [index, sub_index]), object_data_errors)
        text_values_match?(trans[PAHMAObjectData::TITLE_TRANSLATION_LANG.name], element_value(title_translation_lang_input [index, sub_index]), object_data_errors)
      end
    end

    usages = data_set[PAHMAObjectData::USAGE_GRP.name]
    usages && usages.each do |usage|
      index = usages.index usage
      text_values_match?(usage[PAHMAObjectData::USAGE.name], element_value(usage_input index), object_data_errors)
      text_values_match?(usage[PAHMAObjectData::USAGE_NOTE.name], element_value(usage_note_input index), object_data_errors)
    end

    series = data_set[PAHMAObjectData::AUDIO_SERIES.name]
    series && text_values_match?(series, element_value(series_input), object_data_errors)

    collections = data_set[PAHMAObjectData::PAHMA_COLLECTION_LIST.name]
    collections && collections.each do |collect|
      index = collections.index collect
      text_values_match?(collect[PAHMAObjectData::PAHMA_COLLECTION.name], element_value(collection_input index), object_data_errors)
    end

    tms_source = data_set[PAHMAObjectData::TMS_DATA_SRC.name]
    tms_source && text_values_match?(tms_source, element_value(tms_data_source_input), object_data_errors)

    logger.warn "Object data errors: #{object_data_errors}"
    object_data_errors
  end

end
