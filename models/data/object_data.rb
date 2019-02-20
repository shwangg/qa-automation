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
