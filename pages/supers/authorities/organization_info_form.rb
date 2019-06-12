require_relative '../../../spec_helper'

module OrganizationInfoForm

  include Logging
  include Page
  include CollectionSpacePages

  def org_term_add_btn; add_button_locator [fieldset(OrgData::ORG_TERM_GRP.name)] end

  def org_term_display_name_input(index); term_display_name_input [fieldset(OrgData::ORG_TERM_GRP.name, index)] end
  def org_term_name_input(index); term_name_input [fieldset(OrgData::ORG_TERM_GRP.name, index)] end
  def org_term_qualifier_input(index); term_qualifier_input [fieldset(OrgData::ORG_TERM_GRP.name, index)] end
  def org_term_status_input(index); term_status_input [fieldset(OrgData::ORG_TERM_GRP.name, index)] end
  def org_term_status_options(index); term_status_options [fieldset(OrgData::ORG_TERM_GRP.name, index)] end
  def org_term_type_input(index); term_type_input [fieldset(OrgData::ORG_TERM_GRP.name, index)] end
  def org_term_type_options(index); term_type_options [fieldset(OrgData::ORG_TERM_GRP.name, index)] end
  def org_term_flag_input(index); term_flag_input [fieldset(OrgData::ORG_TERM_GRP.name, index)] end
  def org_term_flag_options(index); term_flag_options [fieldset(OrgData::ORG_TERM_GRP.name, index)] end
  def org_term_language_input(index); term_language_input [fieldset(OrgData::ORG_TERM_GRP.name, index)] end
  def org_term_language_options(index); term_language_options [fieldset(OrgData::ORG_TERM_GRP.name, index)] end
  def org_term_pref_for_lang_input(index); term_pref_for_lang_input [fieldset(OrgData::ORG_TERM_GRP.name, index)] end

  def org_term_source_name_input(index); term_source_name_input [fieldset(OrgData::ORG_TERM_GRP.name, index)] end
  def org_term_source_name_options(index); term_source_name_options [fieldset(OrgData::ORG_TERM_GRP.name, index)] end
  def org_term_source_detail_input(index);term_source_detail_input [fieldset(OrgData::ORG_TERM_GRP.name, index)] end
  def org_term_source_id_input(index); term_source_id_input [fieldset(OrgData::ORG_TERM_GRP.name, index)] end
  def org_term_source_note_input(index); term_source_note_input [fieldset(OrgData::ORG_TERM_GRP.name, index)] end

end
