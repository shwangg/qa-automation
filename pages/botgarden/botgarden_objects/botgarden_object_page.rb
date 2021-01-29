require_relative '../../../spec_helper'

class BOTGARDENObjectPage < CoreUCBObjectPage

  include Logging
  include Page
  include CollectionSpacePages
  include BOTGARDENPages
  include BOTGARDENSidebar
  include BOTGARDENObjectIdInfoForm

  DEPLOYMENT = Deployment::BOTGARDEN

  def enter_object_id_data(data)
    enter_object_number data
    select_legacy_dept data
    enter_num_pieces data
    enter_count_note data
    select_is_component data
    select_object_statuses data
    enter_alt_num data
    enter_description data
    enter_object_classes data
    enter_object_names data
    select_resp_colls data
    enter_object_type data
    enter_assoc_cult_grps data
    enter_enthno_file_codes data
    enter_object_comments data
    enter_annotations data
    enter_dimensions data
    enter_materials data
    enter_taxonomics data
    enter_titles data
    enter_usages data
    select_series data
    select_collections data
    select_tms_source data
  end

  def related_tab_button(relate); {:xpath => '//div[contains(@class,"RecordBrowser")]//button[contains(., "' + relate + '")]'} end

  def hit_related_tab(relate)
    logger.info 'Clicking link to Create New' + relate
    scroll_to_top
    wait_for_element_and_click related_tab_button(relate)
  end

end
