require_relative '../../spec_helper'

module CoreNewObjectIdInfoForm

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
  def enter_object_id_data(data_set)
    logger.info "Entering data set #{data_set}"
    hide_notifications_bar
    wait_for_options_and_type(object_num_input, object_num_options, data_set[ObjectData::OBJECT_NUM.name]) if data_set[ObjectData::OBJECT_NUM.name]

    other_nums = data_set[CoreObjectData::OTHER_NUM.name]
    if other_nums
      other_nums.each do |num|
        index = other_nums.index num
        wait_for_element_and_click other_num_add_btn unless index.zero?
        wait_for_element_and_type(other_num_num_input(index), num[CoreObjectData::NUM_VALUE.name])
        wait_for_options_and_select(other_num_type_input(index), other_num_type_options(index), num[CoreObjectData::NUM_TYPE.name])
      end
    end

    wait_for_element_and_type(num_objects_input, data_set[CoreObjectData::NUM_OBJECTS.name]) if data_set[CoreObjectData::NUM_OBJECTS.name]
    wait_for_options_and_select(collection_input, collection_options, data_set[CoreObjectData::COLLECTION.name]) if data_set[CoreObjectData::COLLECTION.name]

    resp_depts = data_set[CoreObjectData::RESPONSIBLE_DEPTS.name]
    if resp_depts
      resp_depts.each do |dept|
        index = resp_depts.index dept
        wait_for_element_and_click resp_dept_add_btn unless index.zero?
        wait_for_options_and_select(resp_dept_input(index), resp_dept_options(index), dept[CoreObjectData::RESPONSIBLE_DEPT.name])
      end
    end

    pub_to_list = data_set[CoreObjectData::PUBLISH_TO_LIST.name]
    if pub_to_list
      pub_to_list.each do |pub|
        index = pub_to_list.index pub
        wait_for_element_and_click publish_to_add_btn unless index.zero?
        wait_for_options_and_select(publish_to_input(index), publish_to_options(index), pub[CoreObjectData::PUBLISH_TO.name])
      end
    end

    wait_for_options_and_select(record_status_input, record_status_options, data_set[CoreObjectData::RECORD_STATUS.name]) if data_set[CoreObjectData::RECORD_STATUS.name]

    inv_statuses = data_set[CoreObjectData::INVENTORY_STATUS_LIST.name]
    if inv_statuses
      inv_statuses.each do |stat|
        index = inv_statuses.index stat
        wait_for_element_and_click inventory_status_add_btn unless index.zero?
        wait_for_options_and_select(inventory_status_input(index), inventory_status_options(index), stat[CoreObjectData::INVENTORY_STATUS.name])
      end
    end

    brief_descrips = data_set[CoreObjectData::BRIEF_DESCRIPS.name]
    if brief_descrips
      brief_descrips.each do |descrip|
        index = brief_descrips.index descrip
        wait_for_element_and_click brief_desc_add_btn unless index.zero?
        wait_for_element_and_type(brief_desc_text_area(index), descrip[CoreObjectData::BRIEF_DESCRIP.name])
      end
    end

    wait_for_element_and_type(dist_features_text_area, data_set[CoreObjectData::DISTINGUISHING_FEATURES.name]) if data_set[CoreObjectData::DISTINGUISHING_FEATURES.name]

    comments = data_set[CoreObjectData::COMMENTS.name]
    if comments
      comments.each do |comment|
        index = comments.index comment
        wait_for_element_and_click comment_add_btn unless index.zero?
        wait_for_element_and_type(comment_text_area(index), comment[CoreObjectData::COMMENT.name])
      end
    end

    titles = data_set[CoreObjectData::TITLE_GRP.name]
    if titles
      titles.each do |title|
        index = titles.index title
        wait_for_element_and_click title_add_btn unless index.zero?
        wait_for_element_and_type(title_input(index), title[CoreObjectData::TITLE.name])
        wait_for_options_and_select(title_type_input(index), title_type_options(index), title[CoreObjectData::TITLE_TYPE.name])
        wait_for_options_and_select(title_lang_input(index), title_lang_options(index), title[CoreObjectData::TITLE_LANG.name])

        translations = title[CoreObjectData::TITLE_TRANSLATION_SUB_GRP.name]
        if translations
          translations.each do |trans|
            sub_index = translations.index trans
            wait_for_element_and_click title_translation_add_btn(sub_index) unless sub_index.zero?
            wait_for_element_and_type(title_translation_input([index, sub_index]), trans[CoreObjectData::TITLE_TRANSLATION.name])
            wait_for_options_and_select(title_translation_lang_input([index, sub_index]), title_translation_lang_options([index, sub_index]), trans[CoreObjectData::TITLE_TRANSLATION_LANG.name])
          end
        end
      end
    end

    obj_names = data_set[CoreObjectData::OBJ_NAME_GRP.name]
    if obj_names
      obj_names.each do |name|
        index = obj_names.index name
        wait_for_element_and_click object_name_add_btn unless index.zero?
        wait_for_element_and_type(object_name_input(index), name[CoreObjectData::OBJ_NAME_NAME.name])
        wait_for_options_and_select(object_name_currency_input(index), object_name_currency_options(index), name[CoreObjectData::OBJ_NAME_CURRENCY.name])
        wait_for_options_and_select(object_name_level_input(index), object_name_level_options(index), name[CoreObjectData::OBJ_NAME_LEVEL.name])
        wait_for_options_and_select(object_name_system_input(index), object_name_system_options(index), name[CoreObjectData::OBJ_NAME_SYSTEM.name])
        wait_for_options_and_select(object_name_type_input(index), object_name_type_options(index), name[CoreObjectData::OBJ_NAME_TYPE.name])
        wait_for_options_and_select(object_name_lang_input(index), object_name_lang_options(index), name[CoreObjectData::OBJ_NAME_LANG.name])
        wait_for_element_and_type(object_name_note_input(index), name[CoreObjectData::OBJ_NAME_NOTE.name])
      end
    end
  end

end
