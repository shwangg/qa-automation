require_relative '../../../spec_helper'

class PAHMASearchPage < CoreSearchPage

  include Page
  include CollectionSpacePages

  DEPLOYMENT = Deployment::PAHMA

  # OBJECT NUMBER

  def object_num_input(index)
    input_locator [fieldset(PAHMAObjectData::OBJECT_NUM.name, index)]
  end

  def object_num_delete_btn(index)
    delete_button_locator [fieldset(PAHMAObjectData::OBJECT_NUM.name, index)]
  end

  def object_num_add_btn
    add_button_locator [fieldset(PAHMAObjectData::OBJECT_NUM.name)]
  end

  # TODO - object number range (for 'any' rather than 'all')

  # ALTERNATE NUMBER

  def alt_num_input(index)
    input_locator [fieldset(PAHMAObjectData::ALT_NUM.name, index)]
  end

  def alt_num_add_btn
    add_button_locator [fieldset(PAHMAObjectData::ALT_NUM.name)]
  end

  # IS COMPONENT?

  def is_component_input(index)
    input_locator [fieldset(PAHMAObjectData::IS_COMPONENT.name, index)]
  end

  def is_component_options(index)
    input_options_locator [fieldset(PAHMAObjectData::IS_COMPONENT.name, index)]
  end

  def is_component_add_btn
    add_button_locator [fieldset(PAHMAObjectData::IS_COMPONENT.name)]
  end

  # OBJECT STATUS

  def obj_status_input(index)
    input_locator [fieldset(PAHMAObjectData::OBJ_STATUS.name, index)]
  end

  def obj_status_options(index)
    input_options_locator [fieldset(PAHMAObjectData::OBJ_STATUS.name, index)]
  end

  def obj_status_add_btn
    add_button_locator [fieldset(PAHMAObjectData::OBJ_STATUS.name)]
  end

  # OBJECT NAME

  def obj_name_input(index)
    input_locator [fieldset(PAHMAObjectData::OBJ_NAME_NAME.name, index)]
  end

  def obj_name_add_btn
    add_button_locator [fieldset(PAHMAObjectData::OBJ_NAME_NAME.name)]
  end

  # RESPONSIBLE COLLECTION MANAGER

  def resp_coll_input(index)
    input_locator [fieldset(PAHMAObjectData::RESPONSIBLE_DEPT.name, index)]
  end

  def resp_coll_options(index)
    input_options_locator [fieldset(PAHMAObjectData::RESPONSIBLE_DEPT.name, index)]
  end

  def resp_coll_add_btn
    add_button_locator [fieldset(PAHMAObjectData::RESPONSIBLE_DEPT.name)]
  end

  # OBJECT TYPE

  def obj_type_input(index)
    input_locator [fieldset(PAHMAObjectData::COLLECTION.name, index)]
  end

  def obj_type_options(index)
    input_options_locator [fieldset(PAHMAObjectData::COLLECTION.name, index)]
  end

  def obj_type_add_btn
    add_button_locator [fieldset(PAHMAObjectData::COLLECTION.name)]
  end

  # ETHNOGRAPHIC FILE CODE

  def ethno_file_code_input(index)
    input_locator [fieldset(PAHMAObjectData::ETHNO_FILE_CODE.name, index)]
  end

  def ethno_file_code_add_btn
    add_button_locator [fieldset(PAHMAObjectData::ETHNO_FILE_CODE.name)]
  end

  # ASSOCIATED CULTURAL GROUP

  def assoc_cult_grp_input(index)
    input_locator [fieldset(PAHMAObjectData::ASSOC_PPL.name, index)]
  end

  def assoc_cult_grp_add_btn
    add_button_locator [fieldset(PAHMAObjectData::ASSOC_PPL.name)]
  end

  # MATERIAL

  def material_input(index)
    input_locator [fieldset(PAHMAObjectData::MATERIAL.name, index)]
  end

  def material_add_btn
    add_button_locator [fieldset(PAHMAObjectData::MATERIAL.name)]
  end

  # TITLE

  def title_input(index)
    input_locator [fieldset(PAHMAObjectData::TITLE.name, index)]
  end

  def title_add_btn
    add_button_locator [fieldset(PAHMAObjectData::TITLE.name)]
  end

  # AUDIO SERIES

  def audio_series_input(index)
    input_locator [fieldset(PAHMAObjectData::AUDIO_SERIES.name, index)]
  end

  def audio_series_options(index)
    input_options_locator [fieldset(PAHMAObjectData::AUDIO_SERIES.name, index)]
  end

  def audio_series_add_btn
    add_button_locator [fieldset(PAHMAObjectData::AUDIO_SERIES.name)]
  end

  # PAHMA_COLLECTION

  def pahma_collection_input(index)
    input_locator [fieldset(PAHMAObjectData::PAHMA_COLLECTION.name, index)]
  end

  def pahma_collection_options(index)
    input_options_locator [fieldset(PAHMAObjectData::PAHMA_COLLECTION.name, index)]
  end

  def pahma_collection_add_btn
    add_button_locator [fieldset(PAHMAObjectData::PAHMA_COLLECTION.name)]
  end

  # LEGACY DEPARTMENT

  def legacy_dept_input(index)
    input_locator [fieldset(PAHMAObjectData::LEGACY_DEPT.name, index)]
  end

  def legacy_dept_options(index)
    input_options_locator [fieldset(PAHMAObjectData::LEGACY_DEPT.name, index)]
  end

  def legacy_dept_add_btn
    add_button_locator [fieldset(PAHMAObjectData::LEGACY_DEPT.name)]
  end

  # Using a single set of test data, enters search parameters in the advanced search form
  # @param [Hash] data_set
  # @return [Array<Object>]
  def enter_object_id_search_data(data_set)
    search_input_errors = []
    hide_notifications_bar

    # The first input on the form occasionally vanishes when leaving the field, so click through several fields before entering
    # any values.
    wait_for_element_and_click(object_num_input 0)
    wait_for_element_and_click(alt_num_input 0)
    wait_for_element_and_click(is_component_input 0)

    object_nums = data_set[PAHMAObjectData::OBJECT_NUM.name]
    if object_nums
      when_exists(object_num_input(0), Config.short_wait)
      # Some search test data sets could have an array of object numbers or an individual one.
      if object_nums.instance_of? Array
        object_nums.each do |num|
          index = object_nums.index num
          logger.debug "Entering #{num} at index #{index}"
          wait_for_element_and_click object_num_add_btn unless index.zero?
          attempt_action(search_input_errors, num) { element(object_num_input(index)).send_keys num[PAHMAObjectData::OBJECT_NUM.name] }
        end
      else
        logger.debug "Entering #{object_nums}"
        attempt_action(search_input_errors, object_nums) { element(object_num_input(0)).send_keys object_nums }
      end
      sleep 2
    end

    alt_nums = data_set[PAHMAObjectData::ALT_NUM_GRP.name]
    alt_nums && alt_nums.each do |num|
      index = alt_nums.index num
      logger.debug "Entering #{num} at index #{index}"
      wait_for_element_and_click alt_num_add_btn unless index.zero?
      attempt_action(search_input_errors, num) { wait_for_element_and_type(alt_num_input(index), num[PAHMAObjectData::ALT_NUM.name]) }
    end

    components = data_set[PAHMAObjectData::IS_COMPONENT.name]
    if components
      # Some search test data sets could have an array of is-components or an individual one.
      if components.instance_of? Array
        components.each do |comp|
          index = components.index comp
          logger.debug "Entering #{comp} at index #{index}"
          wait_for_element_and_click is_component_add_btn unless index.zero?
          attempt_action(search_input_errors, comp) { wait_for_options_and_select(is_component_input(index), is_component_options(index), comp) }
        end
      else
        attempt_action(search_input_errors, components) { wait_for_options_and_select(is_component_input(0), is_component_options(0), components) }
      end
    end

    obj_statuses = data_set[PAHMAObjectData::OBJ_STATUS_LIST.name]
    obj_statuses && obj_statuses.each do |status|
      index = obj_statuses.index status
      logger.debug "Entering #{status} at index #{index}"
      wait_for_element_and_click obj_status_add_btn unless index.zero?
      attempt_action(search_input_errors, status) { wait_for_options_and_select(obj_status_input(index), obj_status_options(index), status[PAHMAObjectData::OBJ_STATUS.name]) }
    end

    obj_names = data_set[PAHMAObjectData::OBJ_NAME_GRP.name]
    obj_names && obj_names.each do |name|
      index = obj_names.index name
      logger.debug "Entering #{name} at index #{index}"
      wait_for_element_and_click obj_name_add_btn unless index.zero?
      attempt_action(search_input_errors, name) { wait_for_element_and_type(obj_name_input(index), name[PAHMAObjectData::OBJ_NAME_NAME.name]) }
    end

    resp_colls = data_set[PAHMAObjectData::RESPONSIBLE_DEPTS.name]
    resp_colls && resp_colls.each do |coll|
      index = resp_colls.index coll
      logger.debug "Entering #{coll} at index #{index}"
      wait_for_element_and_click resp_coll_add_btn unless index.zero?
      attempt_action(search_input_errors, coll) { wait_for_options_and_select(resp_coll_input(index), resp_coll_options(index), coll[PAHMAObjectData::RESPONSIBLE_DEPT.name]) }
    end

    obj_types = data_set[PAHMAObjectData::COLLECTION.name]
    if obj_types
      # Some search test data sets could have an array of object types or an individual one.
      if obj_types.instance_of? Array
        obj_types.each do |type|
          index = obj_types.index type
          logger.debug "Entering #{type} at index #{index}"
          wait_for_element_and_click obj_type_add_btn unless index.zero?
          attempt_action(search_input_errors, type) { wait_for_options_and_select(obj_type_input(index), obj_type_options(index), type[PAHMAObjectData::COLLECTION.name]) }
        end
      else
        attempt_action(search_input_errors, obj_types) { wait_for_options_and_select(obj_type_input(0), obj_type_options(0), obj_types) }
      end
    end

    ethno_file_codes = data_set[PAHMAObjectData::ETHNO_FILE_CODE_LIST.name]
    ethno_file_codes && ethno_file_codes.each do |code|
      index = ethno_file_codes.index code
      logger.debug "Entering #{code} at index #{index}"
      wait_for_element_and_click ethno_file_code_add_btn unless index.zero?
      # TODO - handle option creation
      attempt_action(search_input_errors, code) { wait_for_element_and_type(ethno_file_code_input(index), code[PAHMAObjectData::ETHNO_FILE_CODE.name]) }
    end

    assoc_cult_grps = data_set[PAHMAObjectData::ASSOC_PPL_GRP.name]
    assoc_cult_grps && assoc_cult_grps.each do |grp|
      index = assoc_cult_grps.index grp
      logger.debug "Entering #{grp} at index #{index}"
      wait_for_element_and_click assoc_cult_grp_add_btn unless index.zero?
      # TODO - handle option creation
      attempt_action(search_input_errors, grp) { wait_for_element_and_type(assoc_cult_grp_input(index), grp[PAHMAObjectData::ASSOC_PPL.name]) }
    end

    materials = data_set[PAHMAObjectData::MATERIAL_GRP.name]
    materials && materials.each do |mat|
      index = materials.index mat
      logger.debug "Entering #{mat} at index #{index}"
      wait_for_element_and_click material_add_btn unless index.zero?
      # TODO - handle option creation
      attempt_action(search_input_errors, mat) { wait_for_element_and_type(material_input(index), mat[PAHMAObjectData::MATERIAL.name]) }
    end

    titles = data_set[PAHMAObjectData::TITLE_GRP.name]
    titles && titles.each do |title|
      index = titles.index title
      logger.debug "Entering #{title} at index #{index}"
      wait_for_element_and_click title_add_btn unless index.zero?
      attempt_action(search_input_errors, title) { wait_for_element_and_type(title_input(index), title[PAHMAObjectData::TITLE.name]) }
    end

    series_grp = data_set[PAHMAObjectData::AUDIO_SERIES_GRP.name]
    if series_grp
      # Some search test data sets could have an array of audio series or an individual one.
      if series_grp.instance_of? Array
        series_grp.each do |series|
          index = series_grp.index series
          logger.debug "Entering #{series} at index #{index}"
          wait_for_element_and_click audio_series_add_btn unless index.zero?
          attempt_action(search_input_errors, series) { wait_for_options_and_select(audio_series_input(index), audio_series_options(index), series[PAHMAObjectData::AUDIO_SERIES.name]) }
        end
      else
        attempt_action(search_input_errors, obj_types) { wait_for_options_and_select(audio_series_input(index), audio_series_options(index), series_grp) }
      end
    end

    pahma_collections = data_set[PAHMAObjectData::PAHMA_COLLECTION_LIST.name]
    pahma_collections && pahma_collections.each do |coll|
      index = pahma_collections.index coll
      logger.debug "Entering #{coll} at index #{index}"
      wait_for_element_and_click pahma_collection_add_btn unless index.zero?
      attempt_action(search_input_errors, coll) { wait_for_options_and_select(pahma_collection_input(index), pahma_collection_options(index), coll[PAHMAObjectData::PAHMA_COLLECTION.name]) }
    end

    legacy_depts = data_set[PAHMAObjectData::LEGACY_DEPT_GRP.name]
    legacy_depts && legacy_depts.each do |dept|
      index = legacy_depts.index dept
      logger.debug "Entering #{dept} at index #{index}"
      wait_for_element_and_click legacy_dept_add_btn unless index.zero?
      attempt_action(search_input_errors, dept) { wait_for_options_and_select(legacy_dept_input(index), legacy_dept_options(index), dept[PAHMAObjectData::LEGACY_DEPT.name]) }
    end
  end

  # Enters object search criteria and hits search. Returns an array of any errors caused by form fields.
  # @param [Hash] data_set
  # @return [Array<Object>]
  def perform_adv_search_for_all(data_set)
    click_clear_button
    select_adv_search_all_option
    search_input_errors = enter_object_id_search_data data_set
    click_search_button
    search_input_errors
  end

end
