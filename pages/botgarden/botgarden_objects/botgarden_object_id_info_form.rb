require_relative '../../../spec_helper'

module BOTGARDENObjectIdInfoForm

  include Logging
  include Page
  include CollectionSpacePages

  DEPLOYMENT = Deployment::BOTGARDEN


  def alt_num_input(index); input_locator([fieldset(BOTGARDENObjectData::ALT_NUM_GRP.name, index)], BOTGARDENObjectData::ALT_NUM.name) end
  def alt_num_type_input(index); input_locator([fieldset(BOTGARDENObjectData::ALT_NUM_GRP.name, index)], BOTGARDENObjectData::ALT_NUM_TYPE.name) end
  def alt_num_type_options(index); input_options_locator([fieldset(BOTGARDENObjectData::ALT_NUM_GRP.name, index)], BOTGARDENObjectData::ALT_NUM_TYPE.name) end
  def alt_num_note_input(index); input_locator([fieldset(BOTGARDENObjectData::ALT_NUM_GRP.name, index)], BOTGARDENObjectData::ALT_NUM_NOTE.name) end

  def object_num_input; input_locator([], BOTGARDENObjectData::OBJECT_NUM.name) end

  def obj_type_input; input_locator([], BOTGARDENObjectData::COLLECTION.name) end
  def obj_type_options; input_options_locator([], BOTGARDENObjectData::COLLECTION.name) end

  def assoc_cult_grp_input(index);input_locator([fieldset(BOTGARDENObjectData::ASSOC_PPL_GRP.name, index)], BOTGARDENObjectData::ASSOC_PPL.name) end
  def assoc_cult_grp_type_input(index); input_locator([fieldset(BOTGARDENObjectData::ASSOC_PPL_GRP.name, index)], BOTGARDENObjectData::ASSOC_PPL_TYPE.name) end
  def assoc_cult_grp_type_options(index); input_options_locator([fieldset(BOTGARDENObjectData::ASSOC_PPL_GRP.name, index)], BOTGARDENObjectData::ASSOC_PPL_TYPE.name) end
  def assoc_cult_grp_note_input(index); input_locator([fieldset(BOTGARDENObjectData::ASSOC_PPL_GRP.name, index)], BOTGARDENObjectData::ASSOC_PPL_NOTE.name) end


  def annot_type_input(index); input_locator([fieldset(BOTGARDENObjectData::ANNOT_GRP.name, index)], BOTGARDENObjectData::ANNOT_TYPE.name) end
  def annot_type_options(index); input_options_locator([fieldset(BOTGARDENObjectData::ANNOT_GRP.name, index)], BOTGARDENObjectData::ANNOT_TYPE.name) end
  def annot_note_input(index); input_locator([fieldset(BOTGARDENObjectData::ANNOT_GRP.name, index)], BOTGARDENObjectData::ANNOT_NOTE.name) end
  def annot_date_input(index); input_locator([fieldset(BOTGARDENObjectData::ANNOT_GRP.name, index)], BOTGARDENObjectData::ANNOT_DATE.name) end
  def annot_author_input(index); input_locator([fieldset(BOTGARDENObjectData::ANNOT_GRP.name, index)], BOTGARDENObjectData::ANNOT_AUTHOR.name) end


  def taxon_name_input(index); input_locator([fieldset(BOTGARDENObjectData::TAXON_IDENT_GRP.name, index)], BOTGARDENObjectData::TAXON_NAME.name) end
  def taxon_name_options(index); input_options_locator([fieldset(BOTGARDENObjectData::TAXON_IDENT_GRP.name, index)], BOTGARDENObjectData::TAXON_NAME.name) end
  def taxon_qualifier_input(index); input_locator([fieldset(BOTGARDENObjectData::TAXON_IDENT_GRP.name, index)], BOTGARDENObjectData::TAXON_QUALIFIER.name) end
  def taxon_qualifier_options(index); input_options_locator([fieldset(BOTGARDENObjectData::TAXON_IDENT_GRP.name, index)], BOTGARDENObjectData::TAXON_QUALIFIER.name) end
  def taxon_by_input(index); input_locator([fieldset(BOTGARDENObjectData::TAXON_IDENT_GRP.name, index)], BOTGARDENObjectData::TAXON_BY.name) end
  def taxon_date_input(index); structured_date_input_locator([fieldset(BOTGARDENObjectData::TAXON_IDENT_GRP.name, index)]) end
  def taxon_institution_input(index); input_locator([fieldset(BOTGARDENObjectData::TAXON_IDENT_GRP.name, index)], BOTGARDENObjectData::TAXON_INSTITUTION.name) end
  def taxon_kind_input(index); input_locator([fieldset(BOTGARDENObjectData::TAXON_IDENT_GRP.name, index)], BOTGARDENObjectData::TAXON_KIND.name) end
  def taxon_kind_options(index); input_options_locator([fieldset(BOTGARDENObjectData::TAXON_IDENT_GRP.name, index)], BOTGARDENObjectData::TAXON_KIND.name) end
  def taxon_ref_input(index); input_locator([fieldset(BOTGARDENObjectData::TAXON_IDENT_GRP.name, index)], BOTGARDENObjectData::TAXON_REF.name) end
  def taxon_page_input(index); input_locator([fieldset(BOTGARDENObjectData::TAXON_IDENT_GRP.name, index)], BOTGARDENObjectData::TAXON_PAGE.name) end
  def taxon_note_input(index); text_area_locator([fieldset(BOTGARDENObjectData::TAXON_IDENT_GRP.name, index)], BOTGARDENObjectData::TAXON_NOTE.name) end


  def usage_input(index); text_area_locator([fieldset(BOTGARDENObjectData::USAGE_GRP.name, index)], BOTGARDENObjectData::USAGE.name) end
  def usage_note_input(index); text_area_locator([fieldset(BOTGARDENObjectData::USAGE_GRP.name, index)], BOTGARDENObjectData::USAGE_NOTE.name) end


  # OBJECT NUM

  def enter_object_number(data)
    logger.debug "Entering object number '#{data[BOTGARDENObjectData::OBJECT_NUM.name]}'"
    wait_for_element_and_type(object_num_input, data[BOTGARDENObjectData::OBJECT_NUM.name])
  end

  def verify_object_number(data)
    tex
  end



  # ASSOCIATED CULTURAL GROUP

  def enter_assoc_cult_grps(data)
    assoc_cult_grps = data[BOTGARDENObjectData::ASSOC_PPL_GRP.name]
    prep_fieldsets_for_test_data([fieldset(BOTGARDENObjectData::ASSOC_PPL_GRP.name)], assoc_cult_grps)
    assoc_cult_grps && assoc_cult_grps.each_with_index do |assoc_cult, index|
      logger.debug "Entering associated cultural group '#{assoc_cult}'"
      # TODO - handle creation of input options
      wait_for_element_and_type(assoc_cult_grp_input(index), assoc_cult[BOTGARDENObjectData::ASSOC_PPL.name])
      wait_for_options_and_select(assoc_cult_grp_type_input(index), assoc_cult_grp_type_options(index), assoc_cult[BOTGARDENObjectData::ASSOC_PPL_TYPE.name])
      wait_for_element_and_type(assoc_cult_grp_note_input(index), assoc_cult[BOTGARDENObjectData::ASSOC_PPL_NOTE.name])
    end
  end


  # ANNOTATIONS

  def enter_annotations(data)
    annotations = data[BOTGARDENObjectData::ANNOT_GRP.name]
    prep_fieldsets_for_test_data([fieldset(BOTGARDENObjectData::ANNOT_GRP.name)], annotations)
    annotations && annotations.each_with_index do |annot, index|
      logger.debug "Entering annotation '#{annot}' at index #{index}"
      wait_for_options_and_select(annot_type_input(index), annot_type_options(index), annot[BOTGARDENObjectData::ANNOT_TYPE.name])
      wait_for_element_and_type(annot_note_input(index), annot[BOTGARDENObjectData::ANNOT_NOTE.name])
      enter_simple_date(annot_date_input(index), annot[BOTGARDENObjectData::ANNOT_DATE.name])
      # TODO - handle creation of input options
      wait_for_element_and_type(annot_author_input(index), annot[BOTGARDENObjectData::ANNOT_AUTHOR.name])
    end
  end


  # TAXONOMIC INFORMATION

  def enter_taxonomics(data)
    taxonomics = data[BOTGARDENObjectData::TAXON_IDENT_GRP.name]
    prep_fieldsets_for_test_data([fieldset(BOTGARDENObjectData::TAXON_IDENT_GRP.name)], taxonomics)
    taxonomics && taxonomics.each_with_index do |tax, index|
      logger.debug "Entering taxonomic information '#{tax}' at index #{index}"
      # TODO - handle creation of input options
      enter_auto_complete(taxon_name_input(index), taxon_name_options(index), tax[BOTGARDENObjectData::TAXON_NAME.name])
      wait_for_options_and_select(taxon_qualifier_input(index), taxon_qualifier_options(index), tax[BOTGARDENObjectData::TAXON_QUALIFIER.name])
      # TODO - handle creation of input options
      wait_for_element_and_type(taxon_by_input(index), tax[BOTGARDENObjectData::TAXON_BY.name])
      # TODO - taxon date input
      # TODO - handle creation of input options
      wait_for_element_and_type(taxon_institution_input(index), tax[BOTGARDENObjectData::TAXON_INSTITUTION.name])
      wait_for_options_and_select(taxon_kind_input(index), taxon_kind_options(index), tax[BOTGARDENObjectData::TAXON_KIND.name])
      # TODO - handle creation of input options
      wait_for_element_and_type(taxon_ref_input(index), tax[BOTGARDENObjectData::TAXON_REF.name])
      wait_for_element_and_type(taxon_page_input(index), tax[BOTGARDENObjectData::TAXON_PAGE.name])
      wait_for_element_and_type(taxon_note_input(index), tax[BOTGARDENObjectData::TAXON_NOTE.name])
    end
  end


  # USAGE

  def enter_usages(data)
    usages = data[BOTGARDENObjectData::USAGE_GRP.name]
    prep_fieldsets_for_test_data([fieldset(BOTGARDENObjectData::USAGE_GRP.name)], usages)
    usages && usages.each_with_index do |usage, index|
      logger.debug "Entering usage '#{usage}' at index #{index}"
      wait_for_element_and_type(usage_input(index), usage[BOTGARDENObjectData::USAGE.name])
      wait_for_element_and_type(usage_note_input(index), usage[BOTGARDENObjectData::USAGE_NOTE.name])
    end
  end



  def verify_object_info_data(data_set)
    logger.debug "Checking object number #{data_set[BOTGARDENObjectData::OBJECT_NUM.name]}"
    object_data_errors = []
    text_values_match?(data_set[BOTGARDENObjectData::OBJECT_NUM.name], element_value(object_num_input), object_data_errors)

    legacy_dept = data_set[BOTGARDENObjectData::LEGACY_DEPT.name]
    legacy_dept && text_values_match?(legacy_dept, element_value(legacy_dept_input), object_data_errors)

    num_pieces = data_set[BOTGARDENObjectData::NUM_OBJECTS.name]
    num_pieces && text_values_match?(num_pieces, element_value(num_pieces_input), object_data_errors)

    count_note = data_set[BOTGARDENObjectData::INVENTORY_COUNT.name]
    count_note && text_values_match?(count_note, element_value(count_note_input), object_data_errors)

    is_component = data_set[BOTGARDENObjectData::IS_COMPONENT.name]
    is_component && text_values_match?(is_component, element_value(is_component_input), object_data_errors)

    obj_statuses = data_set[BOTGARDENObjectData::OBJ_STATUS_LIST.name]
    obj_statuses && obj_statuses.each do |obj_status|
      index = obj_statuses.index obj_status
      text_values_match?(obj_status[BOTGARDENObjectData::OBJ_STATUS.name], element_value(obj_status_input index), object_data_errors)
    end

    alt_nums = data_set[BOTGARDENObjectData::ALT_NUM_GRP.name]
    alt_nums && alt_nums.each do |alt_num|
      index = alt_nums.index alt_num
      text_values_match?(alt_num[BOTGARDENObjectData::ALT_NUM.name], element_value(alt_num_input(index)), object_data_errors)
      text_values_match?(alt_num[BOTGARDENObjectData::ALT_NUM_TYPE.name], element_value(alt_num_type_input(index)), object_data_errors)
      text_values_match?(alt_num[BOTGARDENObjectData::ALT_NUM_NOTE.name], element_value(alt_num_note_input(index)), object_data_errors)
    end

    descrips = data_set[BOTGARDENObjectData::BRIEF_DESCRIPS.name]
    descrips && descrips.each do |descrip|
      index = descrips.index descrip
      text_values_match?(descrip[BOTGARDENObjectData::BRIEF_DESCRIP.name], element_value(desc_text_area(index)), object_data_errors)
    end

    obj_classes = data_set[BOTGARDENObjectData::OBJ_CLASS_GRP.name]
    obj_classes && obj_classes.each do |obj_class|
      index = obj_classes.index obj_class
      text_values_match?(obj_class[BOTGARDENObjectData::OBJ_CLASS_NAME.name], element_value(obj_class_name_input(index)), object_data_errors)
    end

    obj_names = data_set[BOTGARDENObjectData::OBJ_NAME_GRP.name]
    obj_names && obj_names.each do |name|
      index = obj_names.index name
      text_values_match?(name[BOTGARDENObjectData::OBJ_NAME_NAME.name], element_value(object_name_input index), object_data_errors)
      text_values_match?(name[BOTGARDENObjectData::OBJ_NAME_CURRENCY.name], element_value(object_name_currency_input index), object_data_errors)
      text_values_match?(name[BOTGARDENObjectData::OBJ_NAME_LEVEL.name], element_value(object_name_level_input index), object_data_errors)
      text_values_match?(name[BOTGARDENObjectData::OBJ_NAME_SYSTEM.name], element_value(object_name_system_input index), object_data_errors)
      text_values_match?(name[BOTGARDENObjectData::OBJ_NAME_TYPE.name], element_value(object_name_type_input index), object_data_errors)
      text_values_match?(name[BOTGARDENObjectData::OBJ_NAME_LANG.name], element_value(object_name_lang_input index), object_data_errors)
      text_values_match?(name[BOTGARDENObjectData::OBJ_NAME_NOTE.name], element_value(object_name_note_input index), object_data_errors)
    end

    resp_colls = data_set[BOTGARDENObjectData::RESPONSIBLE_DEPTS.name]
    resp_colls && resp_colls.each do |resp_coll|
      index = resp_colls.index resp_coll
      text_values_match?(resp_coll[BOTGARDENObjectData::RESPONSIBLE_DEPT.name], element_value(resp_coll_input index), object_data_errors)
    end

    obj_type = data_set[BOTGARDENObjectData::COLLECTION.name]
    obj_type && text_values_match?(obj_type, element_value(obj_type_input), object_data_errors)

    assoc_cult_grps = data_set[BOTGARDENObjectData::ASSOC_PPL_GRP.name]
    assoc_cult_grps && assoc_cult_grps.each do |assoc_cult|
      index = assoc_cult_grps.index assoc_cult
      text_values_match?(assoc_cult[BOTGARDENObjectData::ASSOC_PPL.name], element_value(assoc_cult_grp_input index), object_data_errors)
      text_values_match?(assoc_cult[BOTGARDENObjectData::ASSOC_PPL_TYPE.name], element_value(assoc_cult_grp_type_input index), object_data_errors)
      text_values_match?(assoc_cult[BOTGARDENObjectData::ASSOC_PPL_NOTE.name], element_value(assoc_cult_grp_note_input index), object_data_errors)
    end

    ethno_file_codes = data_set[BOTGARDENObjectData::ETHNO_FILE_CODE_LIST.name]
    ethno_file_codes && ethno_file_codes.each do |code|
      index = ethno_file_codes.index code
      text_values_match?(code[BOTGARDENObjectData::ETHNO_FILE_CODE.name], element_value(ethno_file_code_input index), object_data_errors)
    end

    obj_comments = data_set[BOTGARDENObjectData::COMMENTS.name]
    obj_comments && obj_comments.each do |comment|
      index = obj_comments.index comment
      text_values_match?(comment[BOTGARDENObjectData::COMMENT.name], element_value(obj_comment_text_area index), object_data_errors)
    end

    annotations = data_set[BOTGARDENObjectData::ANNOT_GRP.name]
    annotations && annotations.each do |annot|
      index = annotations.index annot
      text_values_match?(annot[BOTGARDENObjectData::ANNOT_TYPE.name], element_value(annot_type_input index), object_data_errors)
      text_values_match?(annot[BOTGARDENObjectData::ANNOT_NOTE.name], element_value(annot_note_input index), object_data_errors)
      text_values_match?(annot[BOTGARDENObjectData::ANNOT_DATE.name], element_value(annot_date_input index), object_data_errors)
      text_values_match?(annot[BOTGARDENObjectData::ANNOT_AUTHOR.name], element_value(annot_author_input index), object_data_errors)
    end

    dimensions = data_set[BOTGARDENObjectData::MEASURE_PART_GRP.name]
    dimensions && dimensions.each do |dim|
      index = dimensions.index dim
      text_values_match?(dim[BOTGARDENObjectData::MEASURE_PART.name], element_value(part_measured_input index), object_data_errors)
      measures = dim[BOTGARDENObjectData::MEASURE_DIMEN_GRP.name]
      measures && measures.each do |meas|
        sub_index = measures.index meas
        indices = [index, sub_index]
        text_values_match?(meas[BOTGARDENObjectData::MEASURE_DIMENSION.name], element_value(measure_dimen_input indices), object_data_errors)
        text_values_match?(meas[BOTGARDENObjectData::MEASURE_BY.name], element_value(measure_by_input indices), object_data_errors)
        text_values_match?(meas[BOTGARDENObjectData::MEASURE_VALUE.name], element_value(measure_value_input indices), object_data_errors)
        text_values_match?(meas[BOTGARDENObjectData::MEASURE_UNIT.name], element_value(measure_unit_input indices), object_data_errors)
        text_values_match?(meas[BOTGARDENObjectData::MEASURE_QUALIFIER.name], element_value(measure_qualifier_input indices), object_data_errors)
        text_values_match?(meas[BOTGARDENObjectData::MEASURE_DATE.name], element_value(measure_date_input indices), object_data_errors)
        text_values_match?(meas[BOTGARDENObjectData::MEASURE_NOTE.name], element_value(measure_note_input indices), object_data_errors)
      end
    end

    materials = data_set[BOTGARDENObjectData::MATERIAL_GRP.name]
    materials && materials.each do |mat|
      index = materials.index mat
      text_values_match?(mat[BOTGARDENObjectData::MATERIAL.name], element_value(material_input index), object_data_errors)
      text_values_match?(mat[BOTGARDENObjectData::MATERIAL_COMPONENT.name], element_value(material_component_input index), object_data_errors)
      text_values_match?(mat[BOTGARDENObjectData::MATERIAL_NAME.name], element_value(material_name_input index), object_data_errors)
      text_values_match?(mat[BOTGARDENObjectData::MATERIAL_SOURCE.name], element_value(material_source_input index), object_data_errors)
      text_values_match?(mat[BOTGARDENObjectData::MATERIAL_NOTE.name], element_value(material_note_input index), object_data_errors)
    end

    taxonomics = data_set[BOTGARDENObjectData::TAXON_IDENT_GRP.name]
    taxonomics && taxonomics.each do |tax|
      index = taxonomics.index tax
      text_values_match?(tax[BOTGARDENObjectData::TAXON_NAME.name], element_value(taxon_name_input index), object_data_errors)
      text_values_match?(tax[BOTGARDENObjectData::TAXON_QUALIFIER.name], element_value(taxon_qualifier_input index), object_data_errors)
      text_values_match?(tax[BOTGARDENObjectData::TAXON_BY.name], element_value(taxon_by_input index), object_data_errors)
      text_values_match?(tax[BOTGARDENObjectData::TAXON_INSTITUTION.name], element_value(taxon_institution_input index), object_data_errors)
      text_values_match?(tax[BOTGARDENObjectData::TAXON_KIND.name], element_value(taxon_kind_input index), object_data_errors)
      text_values_match?(tax[BOTGARDENObjectData::TAXON_REF.name], element_value(taxon_ref_input index), object_data_errors)
      text_values_match?(tax[BOTGARDENObjectData::TAXON_PAGE.name], element_value(taxon_page_input index), object_data_errors)
      text_values_match?(tax[BOTGARDENObjectData::TAXON_NOTE.name], element_value(taxon_note_input index), object_data_errors)
    end

    titles = data_set[BOTGARDENObjectData::TITLE_GRP.name]
    titles && titles.each do |title|
      index = titles.index title
      text_values_match?(title[BOTGARDENObjectData::TITLE.name], element_value(title_input index), object_data_errors)
      text_values_match?(title[BOTGARDENObjectData::TITLE_TYPE.name], element_value(title_type_input index), object_data_errors)
      text_values_match?(title[BOTGARDENObjectData::TITLE_LANG.name], element_value(title_lang_input index), object_data_errors)

      translations = title[BOTGARDENObjectData::TITLE_TRANSLATION_SUB_GRP.name]
      translations && translations.each do |trans|
        sub_index = translations.index trans
        text_values_match?(trans[BOTGARDENObjectData::TITLE_TRANSLATION.name], element_value(title_translation_input [index, sub_index]), object_data_errors)
        text_values_match?(trans[BOTGARDENObjectData::TITLE_TRANSLATION_LANG.name], element_value(title_translation_lang_input [index, sub_index]), object_data_errors)
      end
    end

    usages = data_set[BOTGARDENObjectData::USAGE_GRP.name]
    usages && usages.each do |usage|
      index = usages.index usage
      text_values_match?(usage[BOTGARDENObjectData::USAGE.name], element_value(usage_input index), object_data_errors)
      text_values_match?(usage[BOTGARDENObjectData::USAGE_NOTE.name], element_value(usage_note_input index), object_data_errors)
    end

    series = data_set[BOTGARDENObjectData::AUDIO_SERIES.name]
    series && text_values_match?(series, element_value(series_input), object_data_errors)

    collections = data_set[BOTGARDENObjectData::PAHMA_COLLECTION_LIST.name]
    collections && collections.each do |collect|
      index = collections.index collect
      text_values_match?(collect[BOTGARDENObjectData::PAHMA_COLLECTION.name], element_value(collection_input index), object_data_errors)
    end

    tms_source = data_set[BOTGARDENObjectData::TMS_DATA_SRC.name]
    tms_source && text_values_match?(tms_source, element_value(tms_data_source_input), object_data_errors)

    logger.warn "Object data errors: #{object_data_errors}"
    object_data_errors
  end

end
