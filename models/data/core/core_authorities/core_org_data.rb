require_relative '../../../../spec_helper'

class CoreOrgData < CoreAuthorityData

  DATA = [
      ADDITIONS_TO_NAME = new('additionsToName'),
      CONTACT_NAME = new('contactName'),
      CONTACT_NAMES = new('contactGroup'),
      DISSOLUTION_DATE = new('dissolutionDate', 'Dissolution date'),
      FOUNDING_DATE = new('foundingDate', 'Foundation date'),
      FOUNDING_PLACE = new('foundingPlace'),
      FUNCTION = new('function'),
      FUNCTIONS = new('functions'),
      GROUP = new('group'),
      GROUPS = new('groups'),
      HISTORY_NOTE = new('historyNote'),
      HISTORY_NOTES = new('historyNotes'),
      MAIN_BODY_NAME = new('mainBodyName'),
      ORG_RECORD_TYPE = new('organizationRecordType'),
      ORG_RECORD_TYPES = new('organizationRecordTypes'),
      ORG_TERM_GRP = new('orgTermGroup')
  ]

end
