require_relative '../../../spec_helper'

module CoreSearchObjectsForm

  include Logging
  include Page
  include CollectionSpacePages

  # RESPONSIBLE DEPARTMENT

  def resp_dept_input(index)
    input_locator([fieldset(CoreObjectData::RESPONSIBLE_DEPT.name, index)])
  end

  def resp_dept_options(index)
    input_options_locator([fieldset(CoreObjectData::RESPONSIBLE_DEPT.name, index)])
  end

  def resp_dept_delete_btn(index)
    delete_button_locator([fieldset(CoreObjectData::RESPONSIBLE_DEPT.name, index)])
  end

  def resp_dept_add_btn
    add_button_locator([fieldset(CoreObjectData::RESPONSIBLE_DEPT.name)])
  end

  # COLLECTION

  def collection_input(index)
    input_locator([fieldset(CoreObjectData::COLLECTION.name, index)])
  end

  def collection_options(index)
    input_options_locator([fieldset(CoreObjectData::COLLECTION.name, index)])
  end

  def collection_delete_btn(index)
    delete_button_locator([fieldset(CoreObjectData::COLLECTION.name, index)])
  end

  def collection_add_btn
    add_button_locator([fieldset(CoreObjectData::COLLECTION.name)])
  end

  # RECORD STATUS

  def record_status_input(index)
    input_locator([fieldset(CoreObjectData::RECORD_STATUS.name, index)])
  end

  def record_status_options(index)
    input_options_locator([fieldset(CoreObjectData::RECORD_STATUS.name, index)])
  end

  def record_status_delete_btn(index)
    delete_button_locator([fieldset(CoreObjectData::RECORD_STATUS.name, index)])
  end

  def record_status_add_btn
    add_button_locator([fieldset(CoreObjectData::RECORD_STATUS.name)])
  end

  # TITLE

  def title_input(index)
    input_locator([fieldset(CoreObjectData::TITLE.name, index)])
  end

  def title_delete_btn(index)
    delete_button_locator([fieldset(CoreObjectData::TITLE.name, index)])
  end

  def title_add_btn
    add_button_locator([fieldset(CoreObjectData::TITLE.name)])
  end

  # OBJECT NAME

  def object_name_input(index)
    input_locator([fieldset(CoreObjectData::OBJ_NAME_NAME.name, index)])
  end

  def object_name_delete_btn(index)
    delete_button_locator([fieldset(CoreObjectData::OBJ_NAME_NAME.name, index)])
  end

  def object_name_add_btn
    add_button_locator([fieldset(CoreObjectData::OBJ_NAME_NAME.name)])
  end

  # PAGE INTERACTIONS

  # Using a single set of test data, enters search parameters in the advanced search form
  # @param [Hash] data_set
  # @return [Array<Object>]
  def enter_object_id_search_data(data_set)
    search_input_errors = []
    hide_notifications_bar

    object_nums = data_set[CoreObjectData::OBJECT_NUM.name]
    if object_nums
      # Some search test data sets could have an array of object numbers or an individual one.
      if object_nums.instance_of? Array
        object_nums.each do |num|
          data = num[CoreObjectData::OBJECT_NUM.name]
          index = object_nums.index num
          logger.debug "Entering object number #{data} at index #{index}"
          wait_for_element_and_click object_num_add_btn unless index.zero?
          attempt_action(search_input_errors, data) { wait_for_element_and_type(object_num_input(index), data) }
        end
      else
        logger.debug "Entering object number #{object_nums}"
        attempt_action(search_input_errors, object_nums) { wait_for_element_and_type(object_num_input(0), object_nums) }
      end
    end

    resp_depts = data_set[CoreObjectData::RESPONSIBLE_DEPTS.name]
    resp_depts && resp_depts.each do |dept|
      data = dept[CoreObjectData::RESPONSIBLE_DEPT.name]
      index = resp_depts.index dept
      logger.debug "Selecting responsible department #{data} at index #{index}"
      wait_for_element_and_click resp_dept_add_btn unless index.zero?
      attempt_action(search_input_errors, data) { wait_for_options_and_select(resp_dept_input(index), resp_dept_options(index), data) }
    end

    collections = data_set[CoreObjectData::COLLECTION.name]
    if collections
      # Some search test data sets could have an array of collections or an individual one.
      if collections.instance_of? Array
        collections.each do |collection|
          data = collection[CoreObjectData::COLLECTION.name]
          index = collections.index collection
          logger.debug "Selecting collection #{data} at index #{index}"
          wait_for_element_and_click collection_add_btn unless index.zero?
          attempt_action(search_input_errors, data) { wait_for_options_and_select(collection_input(index), collection_options(index), data) }
        end
      else
        logger.debug "Selecting collection #{collections}"
        attempt_action(search_input_errors, collections) { wait_for_options_and_select(collection_input(0), collection_options(0), collections) }
      end
    end

    record_statuses = data_set[CoreObjectData::RECORD_STATUS.name]
    if record_statuses
      # Some search test data sets could have an array of record statuses or an individual one.
      if record_statuses.instance_of? Array
        record_statuses.each do |status|
          data = status[CoreObjectData::RECORD_STATUS.name]
          index = record_statuses.index status
          logger.debug "Selecting record status #{data} at index #{index}"
          wait_for_element_and_click record_status_add_btn unless index.zero?
          attempt_action(search_input_errors, data) { wait_for_options_and_select(record_status_input(index), record_status_options(index), data) }
        end
      else
        logger.debug "Selecting record status #{record_statuses}"
        attempt_action(search_input_errors, record_statuses) { wait_for_options_and_select(record_status_input(0), record_status_options(0), record_statuses) }
      end
    end

    titles = data_set[CoreObjectData::TITLE_GRP.name]
    titles && titles.each do |title|
      data = title[CoreObjectData::TITLE.name]
      index = titles.index title
      logger.debug "Entering title #{data} at index #{index}"
      wait_for_element_and_click title_add_btn unless index.zero?
      attempt_action(search_input_errors, data) { wait_for_element_and_type(title_input(index), data) }
    end

    object_names = data_set[CoreObjectData::OBJ_NAME_GRP.name]
    object_names && object_names.each do |name|
      data = name[CoreObjectData::OBJ_NAME_NAME.name]
      index = object_names.index name
      logger.debug "Entering object name #{data} at index #{index}"
      wait_for_element_and_click object_name_add_btn unless index.zero?
      attempt_action(search_input_errors, data) { wait_for_element_and_type(object_name_input(index), data) }
    end
    search_input_errors
  end

end
