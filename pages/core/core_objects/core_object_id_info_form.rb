require_relative '../../../spec_helper'

module CoreObjectIdInfoForm

  include Logging
  include Page
  include CollectionSpacePages

  DEPLOYMENT = Deployment::CORE


  def object_num_input; input_locator([], CoreObjectData::OBJECT_NUM.name) end
  def object_num_options; input_options_locator([], CoreObjectData::OBJECT_NUM.name) end
  def num_objects_input; input_locator([], CoreObjectData::NUM_OBJECTS.name) end

  def other_num_num_input(index); input_locator([fieldset(CoreObjectData::OTHER_NUM.name, index)], CoreObjectData::NUM_VALUE.name) end
  def other_num_type_input(index); input_locator([fieldset(CoreObjectData::OTHER_NUM.name, index)], CoreObjectData::NUM_TYPE.name) end
  def other_num_type_options(index); input_options_locator([fieldset(CoreObjectData::OTHER_NUM.name, index)], CoreObjectData::NUM_TYPE.name) end

  def resp_dept_input(index); input_locator([fieldset(CoreObjectData::RESPONSIBLE_DEPT.name, index)]) end
  def resp_dept_options(index); input_options_locator([fieldset(CoreObjectData::RESPONSIBLE_DEPT.name, index)]) end

  def collection_input; input_locator([], CoreObjectData::COLLECTION.name) end
  def collection_options; input_options_locator([], CoreObjectData::COLLECTION.name) end

  def record_status_input; input_locator([], CoreObjectData::RECORD_STATUS.name) end
  def record_status_options; input_options_locator([], CoreObjectData::RECORD_STATUS.name) end

  def publish_to_input(index); input_locator([fieldset(CoreObjectData::PUBLISH_TO.name, index)]) end
  def publish_to_options(index); input_options_locator([fieldset(CoreObjectData::PUBLISH_TO.name, index)]) end

  def inventory_status_input(index); input_locator([fieldset(CoreObjectData::INVENTORY_STATUS.name, index)]) end
  def inventory_status_options(index); input_options_locator([fieldset(CoreObjectData::INVENTORY_STATUS.name, index)]) end

  def brief_desc_text_area(index); text_area_locator([fieldset(CoreObjectData::BRIEF_DESCRIP.name, index)]) end

  def dist_features_text_area; text_area_locator([], CoreObjectData::DISTINGUISHING_FEATURES.name) end

  def comment_text_area(index); text_area_locator([fieldset(CoreObjectData::COMMENT.name, index)]) end

  def computed_storage_location; input_locator_by_label(CoreObjectData::COMPUTED_LOCATION.label) end

  def title_input(index); input_locator([fieldset(CoreObjectData::TITLE_GRP.name, index)], CoreObjectData::TITLE.name) end
  def title_type_input(index); input_locator([fieldset(CoreObjectData::TITLE_GRP.name, index)], CoreObjectData::TITLE_TYPE.name) end
  def title_type_options(index); input_options_locator([fieldset(CoreObjectData::TITLE_GRP.name, index)], CoreObjectData::TITLE_TYPE.name) end
  def title_lang_input(index); input_locator([fieldset(CoreObjectData::TITLE_GRP.name, index)], CoreObjectData::TITLE_LANG.name) end
  def title_lang_options(index); input_options_locator([fieldset(CoreObjectData::TITLE_GRP.name, index)], CoreObjectData::TITLE_LANG.name) end
  def title_translation_input(indices); input_locator([fieldset(CoreObjectData::TITLE_GRP.name, indices[0]), fieldset(CoreObjectData::TITLE_TRANSLATION_SUB_GRP.name, indices[1])], CoreObjectData::TITLE_TRANSLATION.name) end
  def title_translation_lang_input(indices); input_locator([fieldset(CoreObjectData::TITLE_GRP.name, indices[0]), fieldset(CoreObjectData::TITLE_TRANSLATION_SUB_GRP.name, indices[1])], CoreObjectData::TITLE_TRANSLATION_LANG.name) end
  def title_translation_lang_options(indices); input_options_locator([fieldset(CoreObjectData::TITLE_GRP.name, indices[0]), fieldset(CoreObjectData::TITLE_TRANSLATION_SUB_GRP.name, indices[1])], CoreObjectData::TITLE_TRANSLATION_LANG.name) end

  def object_name_input(index); input_locator([fieldset(CoreObjectData::OBJ_NAME_GRP.name, index)], CoreObjectData::OBJ_NAME_NAME.name) end
  def object_name_currency_input(index); input_locator([fieldset(CoreObjectData::OBJ_NAME_GRP.name, index)], CoreObjectData::OBJ_NAME_CURRENCY.name) end
  def object_name_currency_options(index); input_options_locator([fieldset(CoreObjectData::OBJ_NAME_GRP.name, index)], CoreObjectData::OBJ_NAME_CURRENCY.name) end
  def object_name_level_input(index); input_locator([fieldset(CoreObjectData::OBJ_NAME_GRP.name, index)], CoreObjectData::OBJ_NAME_LEVEL.name) end
  def object_name_level_options(index); input_options_locator([fieldset(CoreObjectData::OBJ_NAME_GRP.name, index)], CoreObjectData::OBJ_NAME_LEVEL.name) end
  def object_name_system_input(index); input_locator([fieldset(CoreObjectData::OBJ_NAME_GRP.name, index)], CoreObjectData::OBJ_NAME_SYSTEM.name) end
  def object_name_system_options(index); input_options_locator([fieldset(CoreObjectData::OBJ_NAME_GRP.name, index)], CoreObjectData::OBJ_NAME_SYSTEM.name) end
  def object_name_type_input(index); input_locator([fieldset(CoreObjectData::OBJ_NAME_GRP.name, index)], CoreObjectData::OBJ_NAME_TYPE.name) end
  def object_name_type_options(index); input_options_locator([fieldset(CoreObjectData::OBJ_NAME_GRP.name, index)], CoreObjectData::OBJ_NAME_TYPE.name) end
  def object_name_lang_input(index); input_locator([fieldset(CoreObjectData::OBJ_NAME_GRP.name, index)], CoreObjectData::OBJ_NAME_LANG.name) end
  def object_name_lang_options(index); input_options_locator([fieldset(CoreObjectData::OBJ_NAME_GRP.name, index)], CoreObjectData::OBJ_NAME_LANG.name) end
  def object_name_note_input(index); input_locator([fieldset(CoreObjectData::OBJ_NAME_GRP.name, index)], CoreObjectData::OBJ_NAME_NOTE.name) end

  def object_template_input; {:xpath => '//div[contains(@class,"RecordHeader")]//div[contains(@class,"DropdownMenuInput")]/input'} end
  def object_template_options; {:xpath => '//div[contains(@class,"RecordHeader")]//li'} end

  def select_object_template(template)
    logger.info "Selecting template '#{template}'"
    wait_for_options_and_select(object_template_input, object_template_options, template)
  end

  # OBJECT NUMBER

  def enter_object_number(data)
    logger.debug "Entering object number #{data[CoreObjectData::OBJECT_NUM.name]}"
    wait_for_options_and_type(object_num_input, object_num_options, data[CoreObjectData::OBJECT_NUM.name])
  end

  # NUMBER OF OBJECTS

  def enter_num_objects(data)
    logger.debug "Entering number of objects #{data[CoreObjectData::NUM_OBJECTS.name]}"
    wait_for_element_and_type(num_objects_input, data[CoreObjectData::NUM_OBJECTS.name])
  end

  # OTHER NUMBER

  def enter_other_numbers(data)
    other_nums = data[CoreObjectData::OTHER_NUM.name]
    other_nums && other_nums.each_with_index do |num, index|
      logger.debug "Entering other number data #{num} at index #{index}"
      wait_for_element_and_type(other_num_num_input(index), num[CoreObjectData::NUM_VALUE.name])
      wait_for_options_and_select(other_num_type_input(index), other_num_type_options(index), num[CoreObjectData::NUM_TYPE.name])
    end
  end

  # RESPONSIBLE DEPARTMENT

  def enter_resp_depts(data)
    resp_depts = data[CoreObjectData::RESPONSIBLE_DEPTS.name]
    prep_fieldsets_for_test_data([fieldset(CoreObjectData)], resp_depts)
    resp_depts && resp_depts.each_with_index do |dept, index|
      logger.debug "Selecting responsible department #{dept[CoreObjectData::RESPONSIBLE_DEPT.name]} at index #{index}"
      wait_for_options_and_select(resp_dept_input(index), resp_dept_options(index), dept[CoreObjectData::RESPONSIBLE_DEPT.name])
    end
  end

  # COLLECTION

  def select_collection(data)
    logger.debug "Selecting collection #{data[CoreObjectData::COLLECTION.name]}"
    wait_for_options_and_select(collection_input, collection_options, data[CoreObjectData::COLLECTION.name])
  end

  # RECORD STATUS

  def select_status(data)
    logger.debug "Selecting record status #{data[CoreObjectData::RECORD_STATUS.name]}"
    wait_for_options_and_select(record_status_input, record_status_options, data[CoreObjectData::RECORD_STATUS.name])
  end

  # PUBLISH TO

  def enter_publish_to(data)
    pub_to_list = data[CoreObjectData::PUBLISH_TO_LIST.name]
    prep_fieldsets_for_test_data([fieldset(CoreObjectData::PUBLISH_TO_LIST.name)], pub_to_list)
    pub_to_list && pub_to_list.each_with_index do |pub, index|
      logger.debug "Selecting publish-to-list #{pub[CoreObjectData::PUBLISH_TO.name]} at index #{index}"
      wait_for_options_and_select(publish_to_input(index), publish_to_options(index), pub[CoreObjectData::PUBLISH_TO.name])
    end
  end

  # INVENTORY STATUS

  def select_inventory_status(data)
    inv_statuses = data[CoreObjectData::INVENTORY_STATUS_LIST.name]
    prep_fieldsets_for_test_data([fieldset(CoreObjectData::INVENTORY_STATUS_LIST.name)], inv_statuses)
    inv_statuses && inv_statuses.each_with_index do |stat, index|
      logger.debug "Selecting inventory status #{stat[CoreObjectData::INVENTORY_STATUS.name]}"
      wait_for_options_and_select(inventory_status_input(index), inventory_status_options(index), stat[CoreObjectData::INVENTORY_STATUS.name])
    end
  end

  # BRIEF DESCRIPTION

  def enter_brief_description(data)
    brief_descrips = data[CoreObjectData::BRIEF_DESCRIPS.name]
    prep_fieldsets_for_test_data([fieldset(CoreObjectData::BRIEF_DESCRIPS.name)], brief_descrips)
    brief_descrips && brief_descrips.each_with_index do |descrip, index|
      logger.debug "Entering brief description #{descrip[CoreObjectData::BRIEF_DESCRIP.name]} at index #{index}"
      wait_for_element_and_type(brief_desc_text_area(index), descrip[CoreObjectData::BRIEF_DESCRIP.name])
    end
  end

  # DISTINGUISHING FEATURES

  def enter_dist_features(data)
    logger.debug "Entering distinguishing feature #{data[CoreObjectData::DISTINGUISHING_FEATURES.name]}"
    wait_for_element_and_type(dist_features_text_area, data[CoreObjectData::DISTINGUISHING_FEATURES.name])
  end

  # COMMENT

  def enter_comments(data)
    comments = data[CoreObjectData::COMMENTS.name]
    prep_fieldsets_for_test_data([fieldset(CoreObjectData::COMMENTS.name)], comments)
    comments && comments.each_with_index do |comment, index|
      logger.debug "Entering comment #{comment[CoreObjectData::COMMENT.name]} at index #{index}"
      wait_for_element_and_type(comment_text_area(index), comment[CoreObjectData::COMMENT.name])
    end
  end

  # COMPUTED STORAGE LOCATION

  def wait_for_location(data)
    wait_for_event_listener do
      sleep 1
      wait_until(1) { element_value(computed_storage_location) == data[CoreObjectData::COMPUTED_LOCATION.name] }
    end
  end

  # TITLE

  def enter_titles(data)
    titles = data[CoreObjectData::TITLE_GRP.name]
    prep_fieldsets_for_test_data([fieldset(CoreObjectData::TITLE_GRP.name)], titles)
    titles && titles.each_with_index do |title, index|
      logger.debug "Entering title data #{title} at index #{index}"
      wait_for_element_and_type(title_input(index), title[CoreObjectData::TITLE.name])
      wait_for_options_and_select(title_type_input(index), title_type_options(index), title[CoreObjectData::TITLE_TYPE.name])
      wait_for_options_and_select(title_lang_input(index), title_lang_options(index), title[CoreObjectData::TITLE_LANG.name])

      translations = title[CoreObjectData::TITLE_TRANSLATION_SUB_GRP.name]
      prep_fieldsets_for_test_data([fieldset(CoreObjectData::TITLE_GRP.name, index), fieldset(CoreObjectData::TITLE_TRANSLATION_SUB_GRP.name)], translations)
      translations && translations.each_with_index do |trans, sub_index|
        logger.debug "Entering translation data #{trans} at sub-index #{sub_index}"
        wait_for_element_and_type(title_translation_input([index, sub_index]), trans[CoreObjectData::TITLE_TRANSLATION.name])
        wait_for_options_and_select(title_translation_lang_input([index, sub_index]), title_translation_lang_options([index, sub_index]), trans[CoreObjectData::TITLE_TRANSLATION_LANG.name])
      end
    end
  end

  # OBJECT NAME

  def enter_object_names(data)
    obj_names = data[CoreObjectData::OBJ_NAME_GRP.name]
    prep_fieldsets_for_test_data([fieldset(CoreObjectData::OBJ_NAME_GRP.name)], obj_names)
    obj_names && obj_names.each_with_index do |name, index|
      logger.debug "Entering object name data #{name} at index #{index}"
      wait_for_element_and_type(object_name_input(index), name[CoreObjectData::OBJ_NAME_NAME.name])
      wait_for_options_and_select(object_name_currency_input(index), object_name_currency_options(index), name[CoreObjectData::OBJ_NAME_CURRENCY.name])
      wait_for_options_and_select(object_name_level_input(index), object_name_level_options(index), name[CoreObjectData::OBJ_NAME_LEVEL.name])
      wait_for_options_and_select(object_name_system_input(index), object_name_system_options(index), name[CoreObjectData::OBJ_NAME_SYSTEM.name])
      wait_for_options_and_select(object_name_type_input(index), object_name_type_options(index), name[CoreObjectData::OBJ_NAME_TYPE.name])
      wait_for_options_and_select(object_name_lang_input(index), object_name_lang_options(index), name[CoreObjectData::OBJ_NAME_LANG.name])
      wait_for_element_and_type(object_name_note_input(index), name[CoreObjectData::OBJ_NAME_NOTE.name])
    end
  end

  # Checks that visible object info data matches a given object info test data set
  # @param [Hash] data_set
  # @return [Array<Object>]
  def verify_object_info_data(data_set)
    logger.debug "Checking object number #{data_set[CoreObjectData::OBJECT_NUM.name]}"
    object_data_errors = []
    text_values_match?(data_set[CoreObjectData::OBJECT_NUM.name], element_value(object_num_input), object_data_errors)

    other_nums = data_set[CoreObjectData::OTHER_NUM.name]
    other_nums && other_nums.each do |num|
      index = other_nums.index num
      text_values_match?(num[CoreObjectData::NUM_VALUE.name], element_value(other_num_num_input index), object_data_errors)
      text_values_match?(num[CoreObjectData::NUM_TYPE.name], element_value(other_num_type_input index), object_data_errors)
    end

    num_objects = data_set[CoreObjectData::NUM_OBJECTS.name]
    num_objects && text_values_match?(num_objects.to_s, element_value(num_objects_input), object_data_errors)

    collection = data_set[CoreObjectData::COLLECTION.name]
    collection && text_values_match?(collection, element_value(collection_input), object_data_errors)

    resp_depts = data_set[CoreObjectData::RESPONSIBLE_DEPTS.name]
    resp_depts && resp_depts.each { |dept| text_values_match?(dept[CoreObjectData::RESPONSIBLE_DEPT.name], element_value(resp_dept_input resp_depts.index(dept)), object_data_errors) }

    pub_to_list = data_set[CoreObjectData::PUBLISH_TO_LIST.name]
    pub_to_list && pub_to_list.each { |pub| text_values_match?(pub[CoreObjectData::PUBLISH_TO.name], element_value(publish_to_input pub_to_list.index(pub)), object_data_errors) }

    status = data_set[CoreObjectData::RECORD_STATUS.name]
    status && text_values_match?(status, element_value(record_status_input), object_data_errors)

    inv_statuses = data_set[CoreObjectData::INVENTORY_STATUS_LIST.name]
    inv_statuses && inv_statuses.each { |stat| text_values_match?(stat[CoreObjectData::INVENTORY_STATUS.name], element_value(inventory_status_input inv_statuses.index(stat)), object_data_errors) }

    brief_descrips = data_set[CoreObjectData::BRIEF_DESCRIPS.name]
    brief_descrips && brief_descrips.each { |descrip| text_values_match?(descrip[CoreObjectData::BRIEF_DESCRIP.name], element_value(brief_desc_text_area brief_descrips.index(descrip)), object_data_errors) }

    dist_feat = data_set[CoreObjectData::DISTINGUISHING_FEATURES.name]
    dist_feat && text_values_match?(dist_feat, element_value(dist_features_text_area), object_data_errors)

    comments = data_set[CoreObjectData::COMMENTS.name]
    comments && comments.each { |comment| text_values_match?(comment[CoreObjectData::COMMENT.name], element_value(comment_text_area comments.index(comment)), object_data_errors) }

    titles = data_set[CoreObjectData::TITLE_GRP.name]
    titles && titles.each do |title|
      index = titles.index title
      text_values_match?(title[CoreObjectData::TITLE.name], element_value(title_input index), object_data_errors)
      text_values_match?(title[CoreObjectData::TITLE_TYPE.name], element_value(title_type_input index), object_data_errors)
      text_values_match?(title[CoreObjectData::TITLE_LANG.name], element_value(title_lang_input index), object_data_errors)

      translations = title[CoreObjectData::TITLE_TRANSLATION_SUB_GRP.name]
      translations && translations.each do |trans|
        sub_index = translations.index trans
        text_values_match?(trans[CoreObjectData::TITLE_TRANSLATION.name], element_value(title_translation_input [index, sub_index]), object_data_errors)
        text_values_match?(trans[CoreObjectData::TITLE_TRANSLATION_LANG.name], element_value(title_translation_lang_input [index, sub_index]), object_data_errors)
      end
    end

    obj_names = data_set[CoreObjectData::OBJ_NAME_GRP.name]
    obj_names && obj_names.each do |name|
      index = obj_names.index name
      text_values_match?(name[CoreObjectData::OBJ_NAME_NAME.name], element_value(object_name_input index), object_data_errors)
      text_values_match?(name[CoreObjectData::OBJ_NAME_CURRENCY.name], element_value(object_name_currency_input index), object_data_errors)
      text_values_match?(name[CoreObjectData::OBJ_NAME_LEVEL.name], element_value(object_name_level_input index), object_data_errors)
      text_values_match?(name[CoreObjectData::OBJ_NAME_SYSTEM.name], element_value(object_name_system_input index), object_data_errors)
      text_values_match?(name[CoreObjectData::OBJ_NAME_TYPE.name], element_value(object_name_type_input index), object_data_errors)
      text_values_match?(name[CoreObjectData::OBJ_NAME_LANG.name], element_value(object_name_lang_input index), object_data_errors)
      text_values_match?(name[CoreObjectData::OBJ_NAME_NOTE.name], element_value(object_name_note_input index), object_data_errors)
    end

    object_data_errors
  end

end
