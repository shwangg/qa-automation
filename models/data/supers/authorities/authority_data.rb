require_relative '../../../../spec_helper'

class AuthorityData < CollectionSpaceData

  DATA = [
      TERM_DISPLAY_NAME = new('termDisplayName'),
      TERM_FLAG = new('termFlag'),
      TERM_LANGUAGE = new('termLanguage'),
      TERM_NAME = new('termName'),
      TERM_PREF_FOR_LANGUAGE = new('termPrefForLang'),
      TERM_QUALIFIER = new('termQualifier'),
      TERM_SOURCE = new('termSource'),
      TERM_SOURCE_DETAIL = new('termSourceDetail'),
      TERM_SOURCE_ID = new('termSourceID'),
      TERM_SOURCE_NOTE = new('termSourceNote'),
      TERM_STATUS = new('termStatus'),
      TERM_TYPE = new('termType')
  ]

end
