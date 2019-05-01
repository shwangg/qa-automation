require_relative '../../../spec_helper'

module CoreObjectIdInfoForm

  include Logging
  include Page
  include CollectionSpacePages

  DEPLOYMENT = Deployment::CORE

  def num_objects_input
    input_locator([], CoreObjectData::NUM_OBJECTS.name)
  end

  # OTHER NUMBER

  def other_num_num_input(index)
    input_locator([fieldset(CoreObjectData::OTHER_NUM.name, index)], CoreObjectData::NUM_VALUE.name)
  end

  def other_num_type_input(index)
    input_locator([fieldset(CoreObjectData::OTHER_NUM.name, index)], CoreObjectData::NUM_TYPE.name)
  end

  def other_num_type_options(index)
    input_options_locator([fieldset(CoreObjectData::OTHER_NUM.name, index)], CoreObjectData::NUM_TYPE.name)
  end

  def other_num_move_top_btn(index)
    move_top_button_locator [fieldset(CoreObjectData::OTHER_NUM.name, index)]
  end

  def other_num_delete_btn(index)
    delete_button_locator [fieldset(CoreObjectData::OTHER_NUM.name, index)]
  end

  def other_num_add_btn
    add_button_locator [fieldset(CoreObjectData::OTHER_NUM.name)]
  end

  # RESPONSIBLE DEPARTMENT

  def resp_dept_input(index)
    input_locator([fieldset(CoreObjectData::RESPONSIBLE_DEPT.name, index)])
  end

  def resp_dept_options(index)
    input_options_locator([fieldset(CoreObjectData::RESPONSIBLE_DEPT.name, index)])
  end

  def resp_dept_move_top_btn(index)
    move_top_button_locator([fieldset(CoreObjectData::RESPONSIBLE_DEPT.name, index)])
  end

  def resp_dept_delete_btn(index)
    delete_button_locator([fieldset(CoreObjectData::RESPONSIBLE_DEPT.name, index)])
  end

  def resp_dept_add_btn
    add_button_locator [fieldset(CoreObjectData::RESPONSIBLE_DEPT.name)]
  end

  # COLLECTION

  def collection_input
    input_locator([], CoreObjectData::COLLECTION.name)
  end

  def collection_options
    input_options_locator([], CoreObjectData::COLLECTION.name)
  end

  # RECORD STATUS

  def record_status_input
    input_locator([], CoreObjectData::RECORD_STATUS.name)
  end

  def record_status_options
    input_options_locator([], CoreObjectData::RECORD_STATUS.name)
  end

  # PUBLISH TO

  def publish_to_input(index)
    input_locator([fieldset(CoreObjectData::PUBLISH_TO.name, index)])
  end

  def publish_to_options(index)
    input_options_locator([fieldset(CoreObjectData::PUBLISH_TO.name, index)])
  end

  def publish_to_move_top_btn(index)
    move_top_button_locator([fieldset(CoreObjectData::PUBLISH_TO.name, index)])
  end

  def publish_to_delete_btn(index)
    delete_button_locator([fieldset(CoreObjectData::PUBLISH_TO.name, index)])
  end

  def publish_to_add_btn
    add_button_locator [fieldset(CoreObjectData::PUBLISH_TO.name)]
  end

  # INVENTORY STATUS

  def inventory_status_input(index)
    input_locator([fieldset(CoreObjectData::INVENTORY_STATUS.name, index)])
  end

  def inventory_status_options(index)
    input_options_locator([fieldset(CoreObjectData::INVENTORY_STATUS.name, index)])
  end

  def inventory_status_move_top_btn(index)
    move_top_button_locator([fieldset(CoreObjectData::INVENTORY_STATUS.name, index)])
  end

  def inventory_status_delete_btn(index)
    delete_button_locator([fieldset(CoreObjectData::INVENTORY_STATUS.name, index)])
  end

  def inventory_status_add_btn
    add_button_locator [fieldset(CoreObjectData::INVENTORY_STATUS.name)]
  end

  # BRIEF DESCRIPTION

  def brief_desc_text_area(index)
    text_area_locator([fieldset(CoreObjectData::BRIEF_DESCRIP.name, index)])
  end

  def brief_desc_move_top_btn(index)
    move_top_button_locator([fieldset(CoreObjectData::BRIEF_DESCRIP.name, index)])
  end

  def brief_desc_delete_btn(index)
    delete_button_locator([fieldset(CoreObjectData::BRIEF_DESCRIP.name, index)])
  end

  def brief_desc_add_btn
    add_button_locator [fieldset(CoreObjectData::BRIEF_DESCRIP.name)]
  end

  # DISTINGUISHING FEATURES

  def dist_features_text_area
    text_area_locator([], CoreObjectData::DISTINGUISHING_FEATURES.name)
  end

  # COMMENT

  def comment_text_area(index)
    text_area_locator([fieldset(CoreObjectData::COMMENT.name, index)])
  end

  def comment_move_top_btn(index)
    move_top_button_locator([fieldset(CoreObjectData::COMMENT.name, index)])
  end

  def comment_delete_btn(index)
    delete_button_locator([fieldset(CoreObjectData::COMMENT.name, index)])
  end

  def comment_add_btn
    add_button_locator([fieldset(CoreObjectData::COMMENT.name)])
  end

  # TITLE

  def title_input(index)
    input_locator([fieldset(CoreObjectData::TITLE_GRP.name, index)], CoreObjectData::TITLE.name)
  end

  def title_type_input(index)
    input_locator([fieldset(CoreObjectData::TITLE_GRP.name, index)], CoreObjectData::TITLE_TYPE.name)
  end

  def title_type_options(index)
    input_options_locator([fieldset(CoreObjectData::TITLE_GRP.name, index)], CoreObjectData::TITLE_TYPE.name)
  end

  def title_lang_input(index)
    input_locator([fieldset(CoreObjectData::TITLE_GRP.name, index)], CoreObjectData::TITLE_LANG.name)
  end

  def title_lang_options(index)
    input_options_locator([fieldset(CoreObjectData::TITLE_GRP.name, index)], CoreObjectData::TITLE_LANG.name)
  end

  def title_translation_input(indices)
    input_locator([fieldset(CoreObjectData::TITLE_GRP.name, indices[0]), fieldset(CoreObjectData::TITLE_TRANSLATION_SUB_GRP.name, indices[1])], CoreObjectData::TITLE_TRANSLATION.name)
  end

  def title_translation_lang_input(indices)
    input_locator([fieldset(CoreObjectData::TITLE_GRP.name, indices[0]), fieldset(CoreObjectData::TITLE_TRANSLATION_SUB_GRP.name, indices[1])], CoreObjectData::TITLE_TRANSLATION_LANG.name)
  end

  def title_translation_lang_options(indices)
    input_options_locator([fieldset(CoreObjectData::TITLE_GRP.name, indices[0]), fieldset(CoreObjectData::TITLE_TRANSLATION_SUB_GRP.name, indices[1])], CoreObjectData::TITLE_TRANSLATION_LANG.name)
  end

  def title_translation_move_top_btn(indices)
    move_top_button_locator([fieldset(CoreObjectData::TITLE_GRP.name, indices[0]), fieldset(CoreObjectData::TITLE_TRANSLATION.name, indices[1])])
  end

  def title_translation_delete_btn(indices)
    move_top_button_locator([fieldset(CoreObjectData::TITLE_GRP.name, indices[0]), fieldset(CoreObjectData::TITLE_TRANSLATION.name, indices[1])])
  end

  def title_translation_add_btn(index)
    add_button_locator([fieldset(CoreObjectData::TITLE_GRP.name, index), fieldset(CoreObjectData::TITLE_TRANSLATION_SUB_GRP.name)])
  end

  def title_add_btn
    add_button_locator([fieldset(CoreObjectData::TITLE_GRP.name)])
  end

  # OBJECT NAME

  def object_name_input(index)
    input_locator([fieldset(CoreObjectData::OBJ_NAME_GRP.name, index)], CoreObjectData::OBJ_NAME_NAME.name)
  end

  def object_name_currency_input(index)
    input_locator([fieldset(CoreObjectData::OBJ_NAME_GRP.name, index)], CoreObjectData::OBJ_NAME_CURRENCY.name)
  end

  def object_name_currency_options(index)
    input_options_locator([fieldset(CoreObjectData::OBJ_NAME_GRP.name, index)], CoreObjectData::OBJ_NAME_CURRENCY.name)
  end

  def object_name_level_input(index)
    input_locator([fieldset(CoreObjectData::OBJ_NAME_GRP.name, index)], CoreObjectData::OBJ_NAME_LEVEL.name)
  end

  def object_name_level_options(index)
    input_options_locator([fieldset(CoreObjectData::OBJ_NAME_GRP.name, index)], CoreObjectData::OBJ_NAME_LEVEL.name)
  end

  def object_name_system_input(index)
    input_locator([fieldset(CoreObjectData::OBJ_NAME_GRP.name, index)], CoreObjectData::OBJ_NAME_SYSTEM.name)
  end

  def object_name_system_options(index)
    input_options_locator([fieldset(CoreObjectData::OBJ_NAME_GRP.name, index)], CoreObjectData::OBJ_NAME_SYSTEM.name)
  end

  def object_name_type_input(index)
    input_locator([fieldset(CoreObjectData::OBJ_NAME_GRP.name, index)], CoreObjectData::OBJ_NAME_TYPE.name)
  end

  def object_name_type_options(index)
    input_options_locator([fieldset(CoreObjectData::OBJ_NAME_GRP.name, index)], CoreObjectData::OBJ_NAME_TYPE.name)
  end

  def object_name_lang_input(index)
    input_locator([fieldset(CoreObjectData::OBJ_NAME_GRP.name, index)], CoreObjectData::OBJ_NAME_LANG.name)
  end

  def object_name_lang_options(index)
    input_options_locator([fieldset(CoreObjectData::OBJ_NAME_GRP.name, index)], CoreObjectData::OBJ_NAME_LANG.name)
  end

  def object_name_note_input(index)
    input_locator([fieldset(CoreObjectData::OBJ_NAME_GRP.name, index)], CoreObjectData::OBJ_NAME_NOTE.name)
  end

  def object_name_add_btn
    add_button_locator([fieldset(CoreObjectData::OBJ_NAME_GRP.name)])
  end

  # PAGE INTERACTIONS

  # Using a single set of test data, enters values in the new object ID info form
  # @param [Hash] data_set
  # @return [Array<Object>]
  def enter_object_id_data(data_set)
    data_input_errors = []
    hide_notifications_bar

    object_num = data_set[ObjectData::OBJECT_NUM.name]
    logger.debug "Entering object number #{object_num}"
    wait_for_options_and_type(object_num_input, object_num_options, object_num)

    other_nums = data_set[CoreObjectData::OTHER_NUM.name]
    other_nums && other_nums.each do |num|
      index = other_nums.index num
      logger.debug "Entering other number data #{num} at index #{index}"
      wait_for_element_and_click other_num_add_btn unless index.zero?
      attempt_action(data_input_errors, num) { wait_for_element_and_type(other_num_num_input(index), num[CoreObjectData::NUM_VALUE.name]) }
      attempt_action(data_input_errors, num) { wait_for_options_and_select(other_num_type_input(index), other_num_type_options(index), num[CoreObjectData::NUM_TYPE.name]) }
    end

    num_objects = data_set[CoreObjectData::NUM_OBJECTS.name]
    logger.debug "Entering number of objects #{num_objects}"
    attempt_action(data_input_errors, num_objects) { wait_for_element_and_type(num_objects_input, num_objects) }

    collection = data_set[CoreObjectData::COLLECTION.name]
    logger.debug "Selecting collection #{collection}"
    attempt_action(data_input_errors, collection) { wait_for_options_and_select(collection_input, collection_options, collection) }

    resp_depts = data_set[CoreObjectData::RESPONSIBLE_DEPTS.name]
    resp_depts && resp_depts.each do |dept|
      data = dept[CoreObjectData::RESPONSIBLE_DEPT.name]
      index = resp_depts.index dept
      logger.debug "Selecting responsible department #{data} at index #{index}"
      wait_for_element_and_click resp_dept_add_btn unless index.zero?
      attempt_action(data_input_errors, dept) { wait_for_options_and_select(resp_dept_input(index), resp_dept_options(index), data) }
    end

    pub_to_list = data_set[CoreObjectData::PUBLISH_TO_LIST.name]
    pub_to_list && pub_to_list.each do |pub|
      data = pub[CoreObjectData::PUBLISH_TO.name]
      index = pub_to_list.index pub
      logger.debug "Selecting publish-to-list #{data} at index #{index}"
      wait_for_element_and_click publish_to_add_btn unless index.zero?
      attempt_action(data_input_errors, pub) { wait_for_options_and_select(publish_to_input(index), publish_to_options(index), data) }
    end

    status = data_set[CoreObjectData::RECORD_STATUS.name]
    logger.debug "Selecting record status #{status}"
    attempt_action(data_input_errors, status) { wait_for_options_and_select(record_status_input, record_status_options, status) }

    inv_statuses = data_set[CoreObjectData::INVENTORY_STATUS_LIST.name]
    inv_statuses && inv_statuses.each do |stat|
      data = stat[CoreObjectData::INVENTORY_STATUS.name]
      index = inv_statuses.index stat
      logger.debug "Selecting inventory status #{data}"
      wait_for_element_and_click inventory_status_add_btn unless index.zero?
      attempt_action(data_input_errors, stat) { wait_for_options_and_select(inventory_status_input(index), inventory_status_options(index), data) }
    end

    brief_descrips = data_set[CoreObjectData::BRIEF_DESCRIPS.name]
    if brief_descrips
      # Scroll to top to ensure brief description field is not obscured by floating header bar
      scroll_to_top
      brief_descrips.each do |descrip|
        data = descrip[CoreObjectData::BRIEF_DESCRIP.name]
        index = brief_descrips.index descrip
        logger.debug "Entering brief description #{data} at index #{index}"
        wait_for_element_and_click brief_desc_add_btn unless index.zero?
        attempt_action(data_input_errors, descrip) { wait_for_element_and_type(brief_desc_text_area(index), data) }
      end
    end

    dist_feat = data_set[CoreObjectData::DISTINGUISHING_FEATURES.name]
    if dist_feat
      logger.debug "Entering distinguishing feature #{dist_feat}"
      attempt_action(data_input_errors, dist_feat) { wait_for_element_and_type(dist_features_text_area, dist_feat) }
    end

    comments = data_set[CoreObjectData::COMMENTS.name]
    comments && comments.each do |comment|
      data = comment[CoreObjectData::COMMENT.name]
      index = comments.index comment
      logger.debug "Entering comment #{data} at index #{index}"
      wait_for_element_and_click comment_add_btn unless index.zero?
      attempt_action(data_input_errors, comment) { wait_for_element_and_type(comment_text_area(index), data) }
    end

    titles = data_set[CoreObjectData::TITLE_GRP.name]
    titles && titles.each do |title|
      index = titles.index title
      logger.debug "Entering title data #{title} at index #{index}"
      wait_for_element_and_click title_add_btn unless index.zero?
      attempt_action(data_input_errors, title) { wait_for_element_and_type(title_input(index), title[CoreObjectData::TITLE.name]) }
      attempt_action(data_input_errors, title) { wait_for_options_and_select(title_type_input(index), title_type_options(index), title[CoreObjectData::TITLE_TYPE.name]) }
      attempt_action(data_input_errors, title) { wait_for_options_and_select(title_lang_input(index), title_lang_options(index), title[CoreObjectData::TITLE_LANG.name]) }

      translations = title[CoreObjectData::TITLE_TRANSLATION_SUB_GRP.name]
      translations && translations.each do |trans|
        sub_index = translations.index trans
        logger.debug "Entering translation data #{trans} at sub-index #{sub_index}"
        wait_for_element_and_click title_translation_add_btn(sub_index) unless sub_index.zero?
        attempt_action(data_input_errors, trans) { wait_for_element_and_type(title_translation_input([index, sub_index]), trans[CoreObjectData::TITLE_TRANSLATION.name]) }
        attempt_action(data_input_errors, trans) { wait_for_options_and_select(title_translation_lang_input([index, sub_index]), title_translation_lang_options([index, sub_index]), trans[CoreObjectData::TITLE_TRANSLATION_LANG.name]) }
      end
    end

    obj_names = data_set[CoreObjectData::OBJ_NAME_GRP.name]
    obj_names && obj_names.each do |name|
      index = obj_names.index name
      logger.debug "Entering object name data #{name} at index #{index}"
      wait_for_element_and_click object_name_add_btn unless index.zero?
      attempt_action(data_input_errors, name) { wait_for_element_and_type(object_name_input(index), name[CoreObjectData::OBJ_NAME_NAME.name]) }
      attempt_action(data_input_errors, name) { wait_for_options_and_select(object_name_currency_input(index), object_name_currency_options(index), name[CoreObjectData::OBJ_NAME_CURRENCY.name]) }
      attempt_action(data_input_errors, name) { wait_for_options_and_select(object_name_level_input(index), object_name_level_options(index), name[CoreObjectData::OBJ_NAME_LEVEL.name]) }
      attempt_action(data_input_errors, name) { wait_for_options_and_select(object_name_system_input(index), object_name_system_options(index), name[CoreObjectData::OBJ_NAME_SYSTEM.name]) }
      attempt_action(data_input_errors, name) { wait_for_options_and_select(object_name_type_input(index), object_name_type_options(index), name[CoreObjectData::OBJ_NAME_TYPE.name]) }
      attempt_action(data_input_errors, name) { wait_for_options_and_select(object_name_lang_input(index), object_name_lang_options(index), name[CoreObjectData::OBJ_NAME_LANG.name]) }
      attempt_action(data_input_errors, name) { wait_for_element_and_type(object_name_note_input(index), name[CoreObjectData::OBJ_NAME_NOTE.name]) }
    end
    data_input_errors
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
