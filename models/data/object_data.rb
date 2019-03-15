require_relative '../../spec_helper'

class ObjectData

  attr_reader :name

  def initialize(name)
    @name = name
  end

  DATA = [
      BRIEF_DESCRIPS = new('briefDescriptions'),
      BRIEF_DESCRIP = new('briefDescription'),
      COLLECTION = new('collection'),
      COMMENTS = new('comments'),
      COMMENT = new('comment'),
      DATE = new('date'),
      DATE_PERIOD = new('datePeriod'),
      DATE_ASSOC = new('dateAssociation'),
      DATE_NOTE = new('dateNote'),
      DATE_EARLIEST_YEAR = new('dateEarliestSingleYear'),
      DATE_EARLIEST_MONTH = new('dateEarliestSingleMonth'),
      DATE_EARLIEST_DAY = new('dateEarliestSingleDay'),
      DATE_EARLIEST_ERA = new('dateEarliestSingleEra'),
      DATE_EARLIEST_CERTAINTY = new('dateEarliestSingleCertainty'),
      DATE_EARLIEST_QUALIF = new('dateEarliestSingleQualifier'),
      DATE_EARLIEST_QUALIF_VALUE = new('dateEarliestSingleQualifierValue'),
      DATE_EARLIEST_QUALIF_UNIT = new('dateEarliestSingleQualifierUnit'),
      DATE_LATEST_YEAR = new('dateLatestYear'),
      DATE_LATEST_MONTH = new('dateLatestMonth'),
      DATE_LATEST_DAY = new('dateLatestDay'),
      DATE_LATEST_ERA = new('dateLatestEra'),
      DATE_LATEST_CERTAINTY = new('dateLatestCertainty'),
      DATE_LATEST_QUALIF = new('dateLatestQualifier'),
      DATE_LATEST_QUALIF_VALUE = new('dateLatestQualifierValue'),
      DATE_LATEST_QUALIF_UNIT = new('dateLatestQualifierUnit'),
      NUM_OBJECTS = new('numberOfObjects'),
      OBJ_NAME_CURRENCY = new('objectNameCurrency'),
      OBJ_NAME_GRP = new('objectNameGroup'),
      OBJ_NAME_LANG = new('objectNameLanguage'),
      OBJ_NAME_LEVEL = new('objectNameLevel'),
      OBJ_NAME_NAME = new('objectName'),
      OBJ_NAME_NOTE = new('objectNameNote'),
      OBJ_NAME_SYSTEM = new('objectNameSystem'),
      OBJ_NAME_TYPE = new('objectNameType'),
      OBJECT_NUM = new('objectNumber'),
      RESPONSIBLE_DEPTS = new('responsibleDepartments'),
      RESPONSIBLE_DEPT = new('responsibleDepartment'),
      TITLE = new('title'),
      TITLE_GRP = new('titleGroup'),
      TITLE_LANG = new('titleLanguage'),
      TITLE_TYPE = new('titleType'),
      TITLE_TRANSLATION = new('titleTranslation'),
      TITLE_TRANSLATION_LANG = new('titleTranslationLanguage'),
      TITLE_TRANSLATION_SUB_GRP = new('titleTranslationSubGroup')
  ]

end
