require_relative '../../spec_helper'

module PAHMAObjectIdInfoForm

  include Logging
  include Page
  include CollectionSpacePages

  DEPLOYMENT = Deployment::PAHMA

  # LEGACY DEPT

  def legacy_dept_input
    input_locator([], PAHMAObjectData::LEGACY_DEPT.name)
  end

  def legacy_dept_options
    input_options_locator([], PAHMAObjectData::LEGACY_DEPT.name)
  end

  # NUMBER OF PIECES

  def num_pieces_input
    input_locator([], PAHMAObjectData::NUM_OBJECTS.name)
  end

  # COUNT NOTE

  def count_note_input
    input_locator([], PAHMAObjectData::INVENTORY_COUNT.name)
  end

  # IS COMPONENT?

  def is_component_input
    input_locator([], PAHMAObjectData::IS_COMPONENT.name)
  end

  def is_component_options
    input_options_locator([], PAHMAObjectData::IS_COMPONENT.name)
  end

  # OBJECT STATUS

  def obj_status_input(index)
    input_locator([fieldset(PAHMAObjectData::OBJ_STATUS_LIST.name, index)], PAHMAObjectData::OBJ_STATUS.name)
  end

  def obj_status_options(index)
    input_options_locator([fieldset(PAHMAObjectData::OBJ_STATUS_LIST.name, index)], PAHMAObjectData::OBJ_STATUS.name)
  end

  def obj_status_move_top_btn(index)
    move_top_button_locator [fieldset(PAHMAObjectData::OBJ_STATUS_LIST.name, index)]
  end

  def obj_status_delete_btn(index)
    delete_button_locator [fieldset(PAHMAObjectData::OBJ_STATUS_LIST.name, index)]
  end

  def obj_status_add_btn
    add_button_locator [fieldset(PAHMAObjectData::OBJ_STATUS_LIST.name)]
  end

  # ALTERNATE NUMBER

  def alt_num_input(index)
    input_locator([fieldset(PAHMAObjectData::ALT_NUM_GRP.name, index)], PAHMAObjectData::ALT_NUM.name)
  end

  def alt_num_type_input(index)
    input_locator([fieldset(PAHMAObjectData::ALT_NUM_GRP.name, index)], PAHMAObjectData::ALT_NUM_TYPE.name)
  end

  def alt_num_type_options(index)
    input_options_locator([fieldset(PAHMAObjectData::ALT_NUM_GRP.name, index)], PAHMAObjectData::ALT_NUM_TYPE.name)
  end

  def alt_num_note_input(index)
    input_locator([fieldset(PAHMAObjectData::ALT_NUM_GRP.name, index)], PAHMAObjectData::ALT_NUM_NOTE.name)
  end

  def alt_num_move_top_btn(index)
    move_top_button_locator [fieldset(PAHMAObjectData::ALT_NUM_GRP.name, index)]
  end

  def alt_num_delete_btn(index)
    delete_button_locator [fieldset(PAHMAObjectData::ALT_NUM_GRP.name, index)]
  end

  def alt_num_add_btn
    add_button_locator [fieldset(PAHMAObjectData::ALT_NUM_GRP.name)]
  end

  # DESCRIPTION

  def desc_text_area(index)
    text_area_locator([fieldset(PAHMAObjectData::BRIEF_DESCRIP.name, index)])
  end

  def desc_move_top_btn(index)
    move_top_button_locator([fieldset(PAHMAObjectData::BRIEF_DESCRIP.name, index)])
  end

  def desc_delete_btn(index)
    delete_button_locator([fieldset(PAHMAObjectData::BRIEF_DESCRIP.name, index)])
  end

  def desc_add_btn
    add_button_locator [fieldset(PAHMAObjectData::BRIEF_DESCRIP.name)]
  end

  # OBJECT CLASS

  def obj_class_name_input(index)
    input_locator([fieldset(PAHMAObjectData::OBJ_CLASS_GRP.name, index)], PAHMAObjectData::OBJ_CLASS_NAME.name)
  end

  def obj_class_name_options(index)
    input_options_locator([fieldset(PAHMAObjectData::OBJ_CLASS_GRP.name, index)], PAHMAObjectData::OBJ_CLASS_NAME.name)
  end

  def obj_class_note_input(index)
    input_locator([fieldset(PAHMAObjectData::OBJ_CLASS_GRP.name, index)], PAHMAObjectData::OBJ_CLASS_NOTE.name)
  end

  def obj_class_move_top_btn(index)
    move_top_button_locator [fieldset(PAHMAObjectData::OBJ_CLASS_GRP.name, index)]
  end

  def obj_class_delete_btn(index)
    delete_button_locator [fieldset(PAHMAObjectData::OBJ_CLASS_GRP.name, index)]
  end

  def obj_class_add_btn
    add_button_locator [fieldset(PAHMAObjectData::OBJ_CLASS_GRP.name)]
  end

  # OBJECT NAME

  def object_name_input(index)
    input_locator([fieldset(PAHMAObjectData::OBJ_NAME_GRP.name, index)], PAHMAObjectData::OBJ_NAME_NAME.name)
  end

  def object_name_level_input(index)
    input_locator([fieldset(PAHMAObjectData::OBJ_NAME_GRP.name, index)], PAHMAObjectData::OBJ_NAME_LEVEL.name)
  end

  def object_name_level_options(index)
    input_options_locator([fieldset(PAHMAObjectData::OBJ_NAME_GRP.name, index)], PAHMAObjectData::OBJ_NAME_LEVEL.name)
  end

  def object_name_currency_input(index)
    input_locator([fieldset(PAHMAObjectData::OBJ_NAME_GRP.name, index)], PAHMAObjectData::OBJ_NAME_CURRENCY.name)
  end

  def object_name_currency_options(index)
    input_options_locator([fieldset(PAHMAObjectData::OBJ_NAME_GRP.name, index)], PAHMAObjectData::OBJ_NAME_CURRENCY.name)
  end

  def object_name_system_input(index)
    input_locator([fieldset(PAHMAObjectData::OBJ_NAME_GRP.name, index)], PAHMAObjectData::OBJ_NAME_SYSTEM.name)
  end

  def object_name_system_options(index)
    input_options_locator([fieldset(PAHMAObjectData::OBJ_NAME_GRP.name, index)], PAHMAObjectData::OBJ_NAME_SYSTEM.name)
  end

  def object_name_type_input(index)
    input_locator([fieldset(PAHMAObjectData::OBJ_NAME_GRP.name, index)], PAHMAObjectData::OBJ_NAME_TYPE.name)
  end

  def object_name_type_options(index)
    input_options_locator([fieldset(PAHMAObjectData::OBJ_NAME_GRP.name, index)], PAHMAObjectData::OBJ_NAME_TYPE.name)
  end

  def object_name_lang_input(index)
    input_locator([fieldset(PAHMAObjectData::OBJ_NAME_GRP.name, index)], PAHMAObjectData::OBJ_NAME_LANG.name)
  end

  def object_name_lang_options(index)
    input_options_locator([fieldset(PAHMAObjectData::OBJ_NAME_GRP.name, index)], PAHMAObjectData::OBJ_NAME_LANG.name)
  end

  def object_name_note_input(index)
    input_locator([fieldset(PAHMAObjectData::OBJ_NAME_GRP.name, index)], PAHMAObjectData::OBJ_NAME_NOTE.name)
  end

  def object_name_add_btn
    add_button_locator([fieldset(PAHMAObjectData::OBJ_NAME_GRP.name)])
  end

  # RESPONSIBLE COLLECTION MGR

  def resp_coll_input(index)
    input_locator([fieldset(PAHMAObjectData::RESPONSIBLE_DEPT.name, index)])
  end

  def resp_coll_options(index)
    input_options_locator([fieldset(PAHMAObjectData::RESPONSIBLE_DEPT.name, index)])
  end

  def resp_coll_move_top_btn(index)
    move_top_button_locator([fieldset(PAHMAObjectData::RESPONSIBLE_DEPT.name, index)])
  end

  def resp_coll_delete_btn(index)
    delete_button_locator([fieldset(PAHMAObjectData::RESPONSIBLE_DEPT.name, index)])
  end

  def resp_coll_add_btn
    add_button_locator [fieldset(PAHMAObjectData::RESPONSIBLE_DEPT.name)]
  end

  # OBJECT TYPE

  def obj_type_input
    input_locator([], PAHMAObjectData::COLLECTION.name)
  end

  def obj_type_options
    input_options_locator([], PAHMAObjectData::COLLECTION.name)
  end

  # ASSOCIATED CULTURAL GROUP

  def assoc_cult_grp_input(index)
    input_locator([fieldset(PAHMAObjectData::ASSOC_PPL_GRP.name, index)], PAHMAObjectData::ASSOC_PPL.name)
  end

  def assoc_cult_grp_type_input(index)
    input_locator([fieldset(PAHMAObjectData::ASSOC_PPL_GRP.name, index)], PAHMAObjectData::ASSOC_PPL_TYPE.name)
  end

  def assoc_cult_grp_type_options(index)
    input_options_locator([fieldset(PAHMAObjectData::ASSOC_PPL_GRP.name, index)], PAHMAObjectData::ASSOC_PPL_TYPE.name)
  end

  def assoc_cult_grp_note_input(index)
    input_locator([fieldset(PAHMAObjectData::ASSOC_PPL_GRP.name, index)], PAHMAObjectData::ASSOC_PPL_NOTE.name)
  end

  def assoc_cult_grp_move_top_btn(index)
    move_top_button_locator [fieldset(PAHMAObjectData::ASSOC_PPL_GRP.name, index)]
  end

  def assoc_cult_grp_delete_btn(index)
    delete_button_locator [fieldset(PAHMAObjectData::ASSOC_PPL_GRP.name, index)]
  end

  def assoc_cult_grp_add_btn
    add_button_locator [fieldset(PAHMAObjectData::ASSOC_PPL_GRP.name)]
  end

  # ETHNOGRAPHIC FILE CODE

  def ethno_file_code_input(index)
    input_locator([fieldset(PAHMAObjectData::ETHNO_FILE_CODE_LIST.name, index)], PAHMAObjectData::ETHNO_FILE_CODE.name)
  end

  def ethno_file_code_options(index)
    input_options_locator([fieldset(PAHMAObjectData::ETHNO_FILE_CODE_LIST.name, index)], PAHMAObjectData::ETHNO_FILE_CODE.name)
  end

  def ethno_file_code_move_top_btn(index)
    move_top_button_locator [fieldset(PAHMAObjectData::ETHNO_FILE_CODE_LIST.name, index)]
  end

  def ethno_file_code_delete_btn(index)
    delete_button_locator [fieldset(PAHMAObjectData::ETHNO_FILE_CODE_LIST.name, index)]
  end

  def ethno_file_code_add_btn
    add_button_locator [fieldset(PAHMAObjectData::ETHNO_FILE_CODE_LIST.name)]
  end

  # OBJECT COMMENT

  def obj_comment_text_area(index)
    text_area_locator([fieldset(PAHMAObjectData::COMMENT.name, index)])
  end

  def obj_comment_move_top_btn(index)
    move_top_button_locator([fieldset(PAHMAObjectData::COMMENT.name, index)])
  end

  def obj_comment_delete_btn(index)
    delete_button_locator([fieldset(PAHMAObjectData::COMMENT.name, index)])
  end

  def obj_comment_add_btn
    add_button_locator([fieldset(PAHMAObjectData::COMMENT.name)])
  end

  # ANNOTATION

  def annot_type_input(index)
    input_locator([fieldset(PAHMAObjectData::ANNOT_GRP.name, index)], PAHMAObjectData::ANNOT_TYPE.name)
  end

  def annot_type_options(index)
    input_options_locator([fieldset(PAHMAObjectData::ANNOT_GRP.name, index)], PAHMAObjectData::ANNOT_TYPE.name)
  end

  def annot_note_input(index)
    input_locator([fieldset(PAHMAObjectData::ANNOT_GRP.name, index)], PAHMAObjectData::ANNOT_NOTE.name)
  end

  def annot_date_input(index)
    input_locator([fieldset(PAHMAObjectData::ANNOT_GRP.name, index)], PAHMAObjectData::ANNOT_DATE.name)
  end

  def annot_author_input(index)
    input_locator([fieldset(PAHMAObjectData::ANNOT_GRP.name, index)], PAHMAObjectData::ANNOT_AUTHOR.name)
  end

  def annot_move_top_btn(index)
    move_top_button_locator [fieldset(PAHMAObjectData::ANNOT_GRP.name, index)]
  end

  def annot_delete_btn(index)
    delete_button_locator [fieldset(PAHMAObjectData::ANNOT_GRP.name, index)]
  end

  def annot_add_btn
    add_button_locator [fieldset(PAHMAObjectData::ANNOT_GRP.name)]
  end

  # DIMENSIONS

  def dimension_add_btn
    add_button_locator [fieldset(PAHMAObjectData::MEASURE_PART_GRP.name)]
  end

  def part_measured_input(index)
    input_locator([fieldset(PAHMAObjectData::MEASURE_PART_GRP.name, index)], PAHMAObjectData::MEASURE_PART.name)
  end

  def measure_dimen_add_btn(index)
    add_button_locator [fieldset(PAHMAObjectData::MEASURE_PART_GRP.name, index), fieldset(PAHMAObjectData::MEASURE_DIMEN_GRP.name)]
  end

  def measure_dimen_input(indices)
    input_locator([fieldset(PAHMAObjectData::MEASURE_PART_GRP.name, indices[0]), fieldset(PAHMAObjectData::MEASURE_DIMEN_GRP.name, indices[1])], PAHMAObjectData::MEASURE_DIMENSION.name)
  end

  def measure_dimen_options(indices)
    input_options_locator([fieldset(PAHMAObjectData::MEASURE_PART_GRP.name, indices[0]), fieldset(PAHMAObjectData::MEASURE_DIMEN_GRP.name, indices[1])], PAHMAObjectData::MEASURE_DIMENSION.name)
  end

  def measure_by_input(indices)
    input_locator([fieldset(PAHMAObjectData::MEASURE_PART_GRP.name, indices[0]), fieldset(PAHMAObjectData::MEASURE_DIMEN_GRP.name, indices[1])], PAHMAObjectData::MEASURE_BY.name)
  end

  def measure_value_input(indices)
    input_locator([fieldset(PAHMAObjectData::MEASURE_PART_GRP.name, indices[0]), fieldset(PAHMAObjectData::MEASURE_DIMEN_GRP.name, indices[1])], PAHMAObjectData::MEASURE_VALUE.name)
  end

  def measure_unit_input(indices)
    input_locator([fieldset(PAHMAObjectData::MEASURE_PART_GRP.name, indices[0]), fieldset(PAHMAObjectData::MEASURE_DIMEN_GRP.name, indices[1])], PAHMAObjectData::MEASURE_VALUE.name)
  end

  def measure_unit_options(indices)
    input_options_locator([fieldset(PAHMAObjectData::MEASURE_PART_GRP.name, indices[0]), fieldset(PAHMAObjectData::MEASURE_DIMEN_GRP.name, indices[1])], PAHMAObjectData::MEASURE_UNIT.name)
  end

  def measure_qualifier_input(indices)
    input_locator([fieldset(PAHMAObjectData::MEASURE_PART_GRP.name, indices[0]), fieldset(PAHMAObjectData::MEASURE_DIMEN_GRP.name, indices[1])], PAHMAObjectData::MEASURE_QUALIFIER.name)
  end

  def measure_date_input(indices)
    input_locator([fieldset(PAHMAObjectData::MEASURE_PART_GRP.name, indices[0]), fieldset(PAHMAObjectData::MEASURE_DIMEN_GRP.name, indices[1])], PAHMAObjectData::MEASURE_DATE.name)
  end

  def measure_note_input(indices)
    input_locator([fieldset(PAHMAObjectData::MEASURE_PART_GRP.name, indices[0]), fieldset(PAHMAObjectData::MEASURE_DIMEN_GRP.name, indices[1])], PAHMAObjectData::MEASURE_NOTE.name)
  end

  # MATERIAL

  def material_input(index)
    input_locator([fieldset(PAHMAObjectData::MATERIAL_GRP.name, index)], PAHMAObjectData::MATERIAL.name)
  end

  def material_component_input(index)
    input_locator([fieldset(PAHMAObjectData::MATERIAL_GRP.name, index)], PAHMAObjectData::MATERIAL_COMPONENT.name)
  end

  def material_name_input(index)
    input_locator([fieldset(PAHMAObjectData::MATERIAL_GRP.name, index)], PAHMAObjectData::MATERIAL_NAME.name)
  end

  def material_source_input(index)
    input_locator([fieldset(PAHMAObjectData::MATERIAL_GRP.name, index)], PAHMAObjectData::MATERIAL_SOURCE.name)
  end

  def material_note_input(index)
    input_locator([fieldset(PAHMAObjectData::MATERIAL_GRP.name, index)], PAHMAObjectData::MATERIAL_NOTE.name)
  end

  def material_move_top_btn(index)
    move_top_button_locator [fieldset(PAHMAObjectData::MATERIAL_GRP.name, index)]
  end

  def material_delete_btn(index)
    delete_button_locator [fieldset(PAHMAObjectData::MATERIAL_GRP.name, index)]
  end

  def material_add_btn
    add_button_locator [fieldset(PAHMAObjectData::MATERIAL_GRP.name)]
  end

  # TAXONOMIC ID

  def taxon_name_input(index)
    input_locator([fieldset(PAHMAObjectData::TAXON_IDENT_GRP.name, index)], PAHMAObjectData::TAXON_NAME.name)
  end

  def taxon_qualifier_input(index)
    input_locator([fieldset(PAHMAObjectData::TAXON_IDENT_GRP.name, index)], PAHMAObjectData::TAXON_QUALIFIER.name)
  end

  def taxon_qualifier_options(index)
    input_options_locator([fieldset(PAHMAObjectData::TAXON_IDENT_GRP.name, index)], PAHMAObjectData::TAXON_QUALIFIER.name)
  end

  def taxon_by_input(index)
    input_locator([fieldset(PAHMAObjectData::TAXON_IDENT_GRP.name, index)], PAHMAObjectData::TAXON_BY.name)
  end

  # TODO - taxon_date_input

  def taxon_institution_input(index)
    input_locator([fieldset(PAHMAObjectData::TAXON_IDENT_GRP.name, index)], PAHMAObjectData::TAXON_INSTITUTION.name)
  end

  def taxon_kind_input(index)
    input_locator([fieldset(PAHMAObjectData::TAXON_IDENT_GRP.name, index)], PAHMAObjectData::TAXON_KIND.name)
  end

  def taxon_kind_options(index)
    input_options_locator([fieldset(PAHMAObjectData::TAXON_IDENT_GRP.name, index)], PAHMAObjectData::TAXON_KIND.name)
  end

  def taxon_ref_input(index)
    input_locator([fieldset(PAHMAObjectData::TAXON_IDENT_GRP.name, index)], PAHMAObjectData::TAXON_REF.name)
  end

  def taxon_page_input(index)
    input_locator([fieldset(PAHMAObjectData::TAXON_IDENT_GRP.name, index)], PAHMAObjectData::TAXON_PAGE.name)
  end

  def taxon_note_input(index)
    input_locator([fieldset(PAHMAObjectData::TAXON_IDENT_GRP.name, index)], PAHMAObjectData::TAXON_NOTE.name)
  end

  def taxon_move_top_btn(index)
    move_top_button_locator [fieldset(PAHMAObjectData::TAXON_IDENT_GRP.name, index)]
  end

  def taxon_delete_btn(index)
    delete_button_locator [fieldset(PAHMAObjectData::TAXON_IDENT_GRP.name, index)]
  end

  def taxon_add_btn
    add_button_locator [fieldset(PAHMAObjectData::TAXON_IDENT_GRP.name)]
  end

  # TITLE

  def title_input(index)
    input_locator([fieldset(PAHMAObjectData::TITLE_GRP.name, index)], PAHMAObjectData::TITLE.name)
  end

  def title_type_input(index)
    input_locator([fieldset(PAHMAObjectData::TITLE_GRP.name, index)], PAHMAObjectData::TITLE_TYPE.name)
  end

  def title_type_options(index)
    input_options_locator([fieldset(PAHMAObjectData::TITLE_GRP.name, index)], PAHMAObjectData::TITLE_TYPE.name)
  end

  def title_lang_input(index)
    input_locator([fieldset(PAHMAObjectData::TITLE_GRP.name, index)], PAHMAObjectData::TITLE_LANG.name)
  end

  def title_lang_options(index)
    input_options_locator([fieldset(PAHMAObjectData::TITLE_GRP.name, index)], PAHMAObjectData::TITLE_LANG.name)
  end

  def title_translation_input(indices)
    input_locator([fieldset(PAHMAObjectData::TITLE_GRP.name, indices[0]), fieldset(PAHMAObjectData::TITLE_TRANSLATION_SUB_GRP.name, indices[1])], PAHMAObjectData::TITLE_TRANSLATION.name)
  end

  def title_translation_lang_input(indices)
    input_locator([fieldset(PAHMAObjectData::TITLE_GRP.name, indices[0]), fieldset(PAHMAObjectData::TITLE_TRANSLATION_SUB_GRP.name, indices[1])], PAHMAObjectData::TITLE_TRANSLATION_LANG.name)
  end

  def title_translation_lang_options(indices)
    input_options_locator([fieldset(PAHMAObjectData::TITLE_GRP.name, indices[0]), fieldset(PAHMAObjectData::TITLE_TRANSLATION_SUB_GRP.name, indices[1])], PAHMAObjectData::TITLE_TRANSLATION_LANG.name)
  end

  def title_translation_move_top_btn(indices)
    move_top_button_locator([fieldset(PAHMAObjectData::TITLE_GRP.name, indices[0]), fieldset(PAHMAObjectData::TITLE_TRANSLATION.name, indices[1])])
  end

  def title_translation_delete_btn(indices)
    move_top_button_locator([fieldset(PAHMAObjectData::TITLE_GRP.name, indices[0]), fieldset(PAHMAObjectData::TITLE_TRANSLATION.name, indices[1])])
  end

  def title_translation_add_btn(index)
    add_button_locator([fieldset(PAHMAObjectData::TITLE_GRP.name, index), fieldset(PAHMAObjectData::TITLE_TRANSLATION_SUB_GRP.name)])
  end

  def title_add_btn
    add_button_locator([fieldset(PAHMAObjectData::TITLE_GRP.name)])
  end

  # CONTEXT OF USE

  def usage_input(index)
    text_area_locator([fieldset(PAHMAObjectData::USAGE_GRP.name, index)], PAHMAObjectData::USAGE.name)
  end

  def usage_note_input(index)
    text_area_locator([fieldset(PAHMAObjectData::USAGE_GRP.name, index)], PAHMAObjectData::USAGE_NOTE.name)
  end

  def usage_move_top_btn(index)
    move_top_button_locator [fieldset(PAHMAObjectData::USAGE_GRP.name, index)]
  end

  def usage_delete_btn(index)
    delete_button_locator [fieldset(PAHMAObjectData::USAGE_GRP.name, index)]
  end

  def usage_add_btn
    add_button_locator [fieldset(PAHMAObjectData::USAGE_GRP.name)]
  end

  # AUDIO SERIES

  def series_input
    input_locator [fieldset(PAHMAObjectData::AUDIO_SERIES.name)]
  end

  def series_options
    input_options_locator [fieldset(PAHMAObjectData::AUDIO_SERIES.name)]
  end

  # COLLECTION

  def collection_input(index)
    input_locator([fieldset(PAHMAObjectData::PAHMA_COLLECTION_LIST.name, index)], PAHMAObjectData::PAHMA_COLLECTION.name)
  end

  def collection_options(index)
    input_options_locator([fieldset(PAHMAObjectData::PAHMA_COLLECTION_LIST.name, index)], PAHMAObjectData::PAHMA_COLLECTION.name)
  end

  def collection_add_btn
    add_button_locator [fieldset(PAHMAObjectData::PAHMA_COLLECTION_LIST.name)]
  end

  # TMS DATA SOURCE

  def tms_data_source_input
    input_locator([], PAHMAObjectData::TMS_DATA_SRC.name)
  end

  def tms_data_source_options
    input_options_locator([], PAHMAObjectData::TMS_DATA_SRC.name)
  end

  # Using a single set of test data, enters values in the new object ID info form
  # @param [Hash] data_set
  # @return [Array<Object>]
  def enter_object_id_data(data_set)
    data_input_errors = []
    hide_notifications_bar

    object_num = data_set[ObjectData::OBJECT_NUM.name]
    logger.debug "Entering object number '#{object_num}'"
    wait_for_options_and_type(object_num_input, object_num_options, object_num)

    legacy_dept = data_set[PAHMAObjectData::LEGACY_DEPT.name]
    if legacy_dept
      logger.debug "Entering legacy dept '#{legacy_dept}'"
      attempt_action(data_input_errors, legacy_dept) { wait_for_options_and_select(legacy_dept_input, legacy_dept_options, legacy_dept) }
    end

    num_pieces = data_set[PAHMAObjectData::NUM_OBJECTS.name]
    if num_pieces
      logger.debug "Entering number of pieces '#{num_pieces}'"
      attempt_action(data_input_errors, num_pieces) { wait_for_element_and_type(num_pieces_input, num_pieces) }
    end

    count_note = data_set[PAHMAObjectData::INVENTORY_COUNT.name]
    if count_note
      logger.debug "Entering count note '#{count_note}'"
      attempt_action(data_input_errors, count_note) { wait_for_element_and_type(count_note_input, count_note) }
    end

    is_component = data_set[PAHMAObjectData::IS_COMPONENT.name]
    if is_component
      logger.debug "Entering is-component '#{is_component}'"
      attempt_action(data_input_errors, is_component) { wait_for_options_and_select(is_component_input, is_component_options, is_component) }
    end

    obj_statuses = data_set[PAHMAObjectData::OBJ_STATUS_LIST.name]
    obj_statuses && obj_statuses.each do |obj_status|
      index = obj_statuses.index obj_status
      logger.debug "Entering object status '#{obj_status}' at index #{index}"
      wait_for_element_and_click obj_class_add_btn unless index.zero?
      attempt_action(data_input_errors, obj_status) { wait_for_options_and_select(obj_status_input(index), obj_status_options(index), obj_status[PAHMAObjectData::OBJ_STATUS.name]) if obj_status[PAHMAObjectData::OBJ_STATUS.name] }
    end

    alt_nums = data_set[PAHMAObjectData::ALT_NUM_GRP.name]
    alt_nums && alt_nums.each do |alt_num|
      index = alt_nums.index alt_num
      logger.debug "Entering alternate number '#{alt_num}' at index #{index}"
      wait_for_element_and_click alt_num_add_btn unless index.zero?
      attempt_action(data_input_errors, alt_num) { wait_for_element_and_type(alt_num_input(index), alt_num[PAHMAObjectData::ALT_NUM.name]) if alt_num[PAHMAObjectData::ALT_NUM.name] }
      attempt_action(data_input_errors, alt_num) { wait_for_options_and_select(alt_num_type_input(index), alt_num_type_options(index), alt_num[PAHMAObjectData::ALT_NUM_TYPE.name]) if alt_num[PAHMAObjectData::ALT_NUM_TYPE.name] }
      attempt_action(data_input_errors, alt_num) { wait_for_element_and_type(alt_num_note_input(index), alt_num[PAHMAObjectData::ALT_NUM_NOTE.name]) if alt_num[PAHMAObjectData::ALT_NUM_NOTE.name] }
    end

    descrips = data_set[PAHMAObjectData::BRIEF_DESCRIPS.name]
    descrips && descrips.each do |descrip|
      index = descrips.index descrip
      logger.debug "Entering description '#{descrip}' at index #{index}"
      wait_for_element_and_click desc_add_btn unless index.zero?
      attempt_action(data_input_errors, descrip) { wait_for_element_and_type(desc_text_area(index), descrip[PAHMAObjectData::BRIEF_DESCRIP.name]) if descrip[PAHMAObjectData::BRIEF_DESCRIP.name] }
    end

    obj_classes = data_set[PAHMAObjectData::OBJ_CLASS_GRP.name]
    obj_classes && obj_classes.each do |obj_class|
      index = obj_classes.index obj_class
      logger.debug "Entering object class '#{obj_class}' at index #{index}"
      wait_for_element_and_click obj_class_add_btn unless index.zero?
      # TODO - handle creation of input options
      attempt_action(data_input_errors, obj_class) { wait_for_element_and_type(obj_class_name_input(index), obj_class[PAHMAObjectData::OBJ_CLASS_NAME.name]) if obj_class[PAHMAObjectData::OBJ_CLASS_NAME.name] }
      attempt_action(data_input_errors, obj_class) { wait_for_element_and_type(obj_class_note_input(index), obj_class[PAHMAObjectData::OBJ_CLASS_NOTE.name]) if obj_class[PAHMAObjectData::OBJ_CLASS_NOTE.name] }
    end

    obj_names = data_set[PAHMAObjectData::OBJ_NAME_GRP.name]
    obj_names && obj_names.each do |name|
      index = obj_names.index name
      logger.debug "Entering object name '#{name}' at index #{index}"
      wait_for_element_and_click object_name_add_btn unless index.zero?
      attempt_action(data_input_errors, name) { wait_for_element_and_type(object_name_input(index), name[PAHMAObjectData::OBJ_NAME_NAME.name]) if name[PAHMAObjectData::OBJ_NAME_NAME.name] }
      attempt_action(data_input_errors, name) { wait_for_options_and_select(object_name_level_input(index), object_name_level_options(index), name[PAHMAObjectData::OBJ_NAME_LEVEL.name]) if name[PAHMAObjectData::OBJ_NAME_LEVEL.name] }
      attempt_action(data_input_errors, name) { wait_for_options_and_select(object_name_currency_input(index), object_name_currency_options(index), name[PAHMAObjectData::OBJ_NAME_CURRENCY.name]) if name[PAHMAObjectData::OBJ_NAME_CURRENCY.name] }
      attempt_action(data_input_errors, name) { wait_for_options_and_select(object_name_system_input(index), object_name_system_options(index), name[PAHMAObjectData::OBJ_NAME_SYSTEM.name]) if name[PAHMAObjectData::OBJ_NAME_SYSTEM.name] }
      attempt_action(data_input_errors, name) { wait_for_options_and_select(object_name_type_input(index), object_name_type_options(index), name[PAHMAObjectData::OBJ_NAME_TYPE.name]) if name[PAHMAObjectData::OBJ_NAME_TYPE.name] }
      attempt_action(data_input_errors, name) { wait_for_options_and_select(object_name_lang_input(index), object_name_lang_options(index), name[PAHMAObjectData::OBJ_NAME_LANG.name]) if name[PAHMAObjectData::OBJ_NAME_LANG.name] }
      attempt_action(data_input_errors, name) { wait_for_element_and_type(object_name_note_input(index), name[PAHMAObjectData::OBJ_NAME_NOTE.name]) }
    end

    resp_colls = data_set[PAHMAObjectData::RESPONSIBLE_DEPTS.name]
    resp_colls && resp_colls.each do |resp_coll|
      index = resp_colls.index resp_coll
      logger.debug "Entering responsible manager '#{resp_coll}' at index #{index}"
      wait_for_element_and_click resp_coll_add_btn unless index.zero?
      attempt_action(data_input_errors, resp_coll) { wait_for_options_and_select(resp_coll_input(index), resp_coll_options(index), resp_coll[PAHMAObjectData::RESPONSIBLE_DEPT.name]) if resp_coll[PAHMAObjectData::RESPONSIBLE_DEPT.name] }
    end

    obj_type = data_set[PAHMAObjectData::COLLECTION.name]
    if obj_type
      logger.debug "Entering object type '#{obj_type}'"
      attempt_action(data_input_errors, obj_type) { wait_for_options_and_select(obj_type_input, obj_type_options, obj_type) }
    end

    assoc_cult_grps = data_set[PAHMAObjectData::ASSOC_PPL_GRP.name]
    assoc_cult_grps && assoc_cult_grps.each do |assoc_cult|
      index = assoc_cult_grps.index assoc_cult
      logger.debug "Entering associated cultural group '#{assoc_cult}'"
      wait_for_element_and_click assoc_cult_grp_add_btn unless index.zero?
      # TODO - handle creation of input options
      attempt_action(data_input_errors, assoc_cult) { wait_for_element_and_type(assoc_cult_grp_input(index), assoc_cult[PAHMAObjectData::ASSOC_PPL.name]) if assoc_cult[PAHMAObjectData::ASSOC_PPL.name] }
      attempt_action(data_input_errors, assoc_cult) { wait_for_options_and_select(assoc_cult_grp_type_input(index), assoc_cult_grp_type_options(index), assoc_cult[PAHMAObjectData::ASSOC_PPL_TYPE.name]) if assoc_cult[PAHMAObjectData::ASSOC_PPL_TYPE.name] }
      attempt_action(data_input_errors, assoc_cult) { wait_for_element_and_type(assoc_cult_grp_note_input(index), assoc_cult[PAHMAObjectData::ASSOC_PPL_NOTE.name]) if assoc_cult[PAHMAObjectData::ASSOC_PPL_NOTE.name] }
    end

    ethno_file_codes = data_set[PAHMAObjectData::ETHNO_FILE_CODE_LIST.name]
    ethno_file_codes && ethno_file_codes.each do |code|
      index = ethno_file_codes.index code
      logger.debug "Entering ethnographic file code '#{code}'"
      wait_for_element_and_click ethno_file_code_add_btn unless index.zero?
      # TODO - handle creation of input options
      attempt_action(data_input_errors, code) { wait_for_element_and_type(ethno_file_code_input(index), code[PAHMAObjectData::ETHNO_FILE_CODE.name]) if code[PAHMAObjectData::ETHNO_FILE_CODE.name] }
    end

    obj_comments = data_set[PAHMAObjectData::COMMENTS.name]
    obj_comments && obj_comments.each do |comment|
      index = obj_comments.index comment
      logger.debug "Entering object comment '#{comment}' at index #{index}"
      wait_for_element_and_click obj_comment_add_btn unless index.zero?
      attempt_action(data_input_errors, comment) { wait_for_element_and_type(obj_comment_text_area(index), comment[PAHMAObjectData::COMMENT.name]) if comment[PAHMAObjectData::COMMENT.name] }
    end

    annotations = data_set[PAHMAObjectData::ANNOT_GRP.name]
    annotations && annotations.each do |annot|
      index = annotations.index annot
      logger.debug "Entering annotation '#{annot}' at index #{index}"
      wait_for_element_and_click annot_add_btn unless index.zero?
      attempt_action(data_input_errors, annot) { wait_for_options_and_select(annot_type_input(index), annot_type_options(index), annot[PAHMAObjectData::ANNOT_TYPE.name]) if annot[PAHMAObjectData::ANNOT_TYPE.name] }
      attempt_action(data_input_errors, annot) { wait_for_element_and_type(annot_note_input(index), annot[PAHMAObjectData::ANNOT_NOTE.name]) if annot[PAHMAObjectData::ANNOT_NOTE.name] }
      attempt_action(data_input_errors, annot) { wait_for_element_and_type(annot_date_input(index), annot[PAHMAObjectData::ANNOT_DATE.name]) if annot[PAHMAObjectData::ANNOT_DATE.name] }
      # TODO - handle creation of input options
      attempt_action(data_input_errors, annot) { wait_for_element_and_type(annot_author_input(index), annot[PAHMAObjectData::ANNOT_AUTHOR.name]) if annot[PAHMAObjectData::ANNOT_AUTHOR.name] }
    end

    dimensions = data_set[PAHMAObjectData::MEASURE_PART_GRP.name]
    dimensions && dimensions.each do |dim|
      index = dimensions.index dim
      logger.debug "Entering dimension '#{dim}' at index #{index}"
      wait_for_element_and_click dimension_add_btn unless index.zero?
      attempt_action(data_input_errors, dim) { wait_for_element_and_type(part_measured_input(index), dim[PAHMAObjectData::MEASURE_PART.name]) if dim[PAHMAObjectData::MEASURE_PART.name] }

      measures = dim[PAHMAObjectData::MEASURE_DIMEN_GRP.name]
      measures && measures.each do |meas|
        sub_index = measures.index meas
        indices = [index, sub_index]
        logger.debug "Entering dimension measurement '#{meas}' at index #{index}"
        wait_for_element_and_click measure_dimen_add_btn(index) unless sub_index.zero?
        attempt_action(data_input_errors, meas) { wait_for_options_and_select(measure_dimen_input(indices), measure_dimen_options(indices), meas[PAHMAObjectData::MEASURE_DIMENSION.name]) if meas[PAHMAObjectData::MEASURE_DIMENSION.name] }
        # TODO - handle creation of input options
        attempt_action(data_input_errors, meas) { wait_for_element_and_type(measure_by_input(indices), meas[PAHMAObjectData::MEASURE_BY.name]) if meas[PAHMAObjectData::MEASURE_BY.name] }
        attempt_action(data_input_errors, meas) { wait_for_element_and_type(measure_value_input(indices), meas[PAHMAObjectData::MEASURE_VALUE.name]) if meas[PAHMAObjectData::MEASURE_VALUE.name] }
        attempt_action(data_input_errors, meas) { wait_for_options_and_select(measure_unit_input(indices), measure_unit_options(indices), meas[PAHMAObjectData::MEASURE_UNIT.name]) if meas[PAHMAObjectData::MEASURE_UNIT.name] }
        attempt_action(data_input_errors, meas) { wait_for_element_and_type(measure_qualifier_input(indices), meas[PAHMAObjectData::MEASURE_QUALIFIER.name]) if meas[PAHMAObjectData::MEASURE_QUALIFIER.name] }
        attempt_action(data_input_errors, meas) { wait_for_element_and_type(measure_date_input(indices), meas[PAHMAObjectData::MEASURE_DATE.name]) if meas[PAHMAObjectData::MEASURE_DATE.name] }
        attempt_action(data_input_errors, meas) { wait_for_element_and_type(measure_note_input(indices), meas[PAHMAObjectData::MEASURE_NOTE.name]) if meas[PAHMAObjectData::MEASURE_NOTE.name] }
      end
    end

    materials = data_set[PAHMAObjectData::MATERIAL_GRP.name]
    materials && materials.each do |mat|
      index = materials.index mat
      logger.debug "Entering material '#{mat}' at index #{index}"
      wait_for_element_and_click material_add_btn unless index.zero?
      # TODO - handle creation of input options
      attempt_action(data_input_errors, mat) { wait_for_element_and_type(material_input(index), mat[PAHMAObjectData::MATERIAL.name]) if mat[PAHMAObjectData::MATERIAL.name] }
      attempt_action(data_input_errors, mat) { wait_for_element_and_type(material_component_input(index), mat[PAHMAObjectData::MATERIAL_COMPONENT.name]) if mat[PAHMAObjectData::MATERIAL_COMPONENT.name] }
      attempt_action(data_input_errors, mat) { wait_for_element_and_type(material_name_input(index), mat[PAHMAObjectData::MATERIAL_NAME.name]) if mat[PAHMAObjectData::MATERIAL_NAME.name] }
      attempt_action(data_input_errors, mat) { wait_for_element_and_type(material_source_input(index), mat[PAHMAObjectData::MATERIAL_SOURCE.name]) if mat[PAHMAObjectData::MATERIAL_SOURCE.name] }
      attempt_action(data_input_errors, mat) { wait_for_element_and_type(material_note_input(index), mat[PAHMAObjectData::MATERIAL_NOTE.name]) if mat[PAHMAObjectData::MATERIAL_NOTE.name] }
    end

    taxonomics = data_set[PAHMAObjectData::TAXON_IDENT_GRP.name]
    taxonomics && taxonomics.each do |tax|
      index = taxonomics.index tax
      logger.debug "Entering taxonomic information '#{tax}' at index #{index}"
      # TODO - handle creation of input options
      attempt_action(data_input_errors, tax) { wait_for_element_and_type(taxon_name_input(index), tax[PAHMAObjectData::TAXON_NAME.name]) if tax[PAHMAObjectData::TAXON_NAME.name] }
      attempt_action(data_input_errors, tax) { wait_for_options_and_select(taxon_qualifier_input(index), taxon_qualifier_options(index), tax[PAHMAObjectData::TAXON_QUALIFIER.name]) if tax[PAHMAObjectData::TAXON_QUALIFIER.name] }
      # TODO - handle creation of input options
      attempt_action(data_input_errors, tax) { wait_for_element_and_type(taxon_by_input(index), tax[PAHMAObjectData::TAXON_BY.name]) if tax[PAHMAObjectData::TAXON_BY.name] }
      # TODO - taxon date input
      # TODO - handle creation of input options
      attempt_action(data_input_errors, tax) { wait_for_element_and_type(taxon_institution_input(index), tax[PAHMAObjectData::TAXON_INSTITUTION.name]) if tax[PAHMAObjectData::TAXON_INSTITUTION.name] }
      attempt_action(data_input_errors, tax) { wait_for_options_and_select(taxon_kind_input(index), taxon_kind_options(index), tax[PAHMAObjectData::TAXON_KIND.name]) if tax[PAHMAObjectData::TAXON_KIND.name] }
      # TODO - handle creation of input options
      attempt_action(data_input_errors, tax) { wait_for_element_and_type(taxon_ref_input(index), tax[PAHMAObjectData::TAXON_REF.name]) if tax[PAHMAObjectData::TAXON_REF.name] }
      attempt_action(data_input_errors, tax) { wait_for_element_and_type(taxon_page_input(index), tax[PAHMAObjectData::TAXON_PAGE.name]) if tax[PAHMAObjectData::TAXON_PAGE.name] }
      attempt_action(data_input_errors, tax) { wait_for_element_and_type(taxon_note_input(index), tax[PAHMAObjectData::TAXON_NOTE.name]) if tax[PAHMAObjectData::TAXON_NOTE.name] }
    end

    titles = data_set[PAHMAObjectData::TITLE_GRP.name]
    titles && titles.each do |title|
      index = titles.index title
      logger.debug "Entering title data #{title} at index #{index}"
      wait_for_element_and_click title_add_btn unless index.zero?
      attempt_action(data_input_errors, title) { wait_for_element_and_type(title_input(index), title[PAHMAObjectData::TITLE.name]) if title[PAHMAObjectData::TITLE.name] }
      attempt_action(data_input_errors, title) { wait_for_options_and_select(title_type_input(index), title_type_options(index), title[PAHMAObjectData::TITLE_TYPE.name]) if title[PAHMAObjectData::TITLE_TYPE.name] }
      attempt_action(data_input_errors, title) { wait_for_options_and_select(title_lang_input(index), title_lang_options(index), title[PAHMAObjectData::TITLE_LANG.name]) if title[PAHMAObjectData::TITLE_LANG.name] }

      translations = title[CoreObjectData::TITLE_TRANSLATION_SUB_GRP.name]
      translations && translations.each do |trans|
        sub_index = translations.index trans
        logger.debug "Entering translation data #{trans} at sub-index #{sub_index}"
        wait_for_element_and_click title_translation_add_btn(sub_index) unless sub_index.zero?
        attempt_action(data_input_errors, trans) { wait_for_element_and_type(title_translation_input([index, sub_index]), trans[PAHMAObjectData::TITLE_TRANSLATION.name]) if trans[PAHMAObjectData::TITLE_TRANSLATION.name] }
        attempt_action(data_input_errors, trans) { wait_for_options_and_select(title_translation_lang_input([index, sub_index]), title_translation_lang_options([index, sub_index]), trans[PAHMAObjectData::TITLE_TRANSLATION_LANG.name]) if trans[PAHMAObjectData::TITLE_TRANSLATION_LANG.name] }
      end
    end

    usages = data_set[PAHMAObjectData::USAGE_GRP.name]
    usages && usages.each do |usage|
      index = usages.index usage
      logger.debug "Entering usage '#{usage}' at index #{index}"
      wait_for_element_and_click usage_add_btn unless index.zero?
      attempt_action(data_input_errors, usage) { wait_for_element_and_type(usage_input(index), usage[PAHMAObjectData::USAGE.name]) if usage[PAHMAObjectData::USAGE.name] }
      attempt_action(data_input_errors, usage) { wait_for_element_and_type(usage_note_input(index), usage[PAHMAObjectData::USAGE_NOTE.name]) if usage[PAHMAObjectData::USAGE_NOTE.name] }
    end

    series = data_set[PAHMAObjectData::AUDIO_SERIES.name]
    if series
      logger.debug "Selecting series '#{series}'"
      attempt_action(data_input_errors, series) { wait_for_options_and_select(series_input, series_options, series) }
    end

    collections = data_set[PAHMAObjectData::PAHMA_COLLECTION_LIST.name]
    collections && collections.each do |collect|
      index = collections.index collect
      logger.debug "Entering collection '#{collect}' at index #{index}"
      wait_for_element_and_click collection_add_btn unless index.zero?
      attempt_action(data_input_errors, collect) { wait_for_options_and_select(collection_input(index), collection_options(index), collect[PAHMAObjectData::PAHMA_COLLECTION.name]) if collect[PAHMAObjectData::PAHMA_COLLECTION.name] }
    end

    tms_source = data_set[PAHMAObjectData::TMS_DATA_SRC.name]
    if tms_source
      logger.debug "Selecting TMS data source '#{tms_source}'"
      wait_for_options_and_select(tms_data_source_input, tms_data_source_options, tms_source)
    end

    data_input_errors
  end

  def verify_object_info_data(data_set)
    logger.debug "Checking object number #{data_set[CoreObjectData::OBJECT_NUM.name]}"
    object_data_errors = []
    text_values_match?(data_set[CoreObjectData::OBJECT_NUM.name], element_value(object_num_input), object_data_errors)

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
      text_values_match?(alt_num[PAHMAObjectData::ALT_NUM.name], alt_num_input(index), object_data_errors)
      text_values_match?(alt_num[PAHMAObjectData::ALT_NUM_TYPE.name], alt_num_type_input(index), object_data_errors)
      text_values_match?(alt_num[PAHMAObjectData::ALT_NUM_NOTE.name], alt_num_note_input(index), object_data_errors)
    end

    descrips = data_set[PAHMAObjectData::BRIEF_DESCRIPS.name]
    descrips && descrips.each do |descrip|
      index = descrips.index descrip
      text_values_match?(descrip[PAHMAObjectData::BRIEF_DESCRIP.name], desc_text_area(index), object_data_errors)
    end

    obj_classes = data_set[PAHMAObjectData::OBJ_CLASS_GRP.name]
    obj_classes && obj_classes.each do |obj_class|
      index = obj_classes.index obj_class
      text_values_match?(obj_class[PAHMAObjectData::OBJ_CLASS_NAME.name], obj_class_name_input(index), object_data_errors)
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
    obj_type && text_values_match?(obj_type, obj_type_input, object_data_errors)

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

    object_data_errors
  end

end
