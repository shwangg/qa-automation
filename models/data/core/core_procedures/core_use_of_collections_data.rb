require_relative '../../../../spec_helper'

class CoreUseOfCollectionsData < CollectionSpaceData

  DATA = [
      AUTHORIZATION_DATE = new('authorizationDate'),
      AUTHORIZATION_GRP = new('authorizationGroup'),
      AUTHORIZATION_NOTE = new('authorizationNote'),
      AUTHORIZATION_STATUS = new('authorizationStatus'),
      AUTHORIZED_BY = new('authorizedBy'),
      COLLECTION_TYPE = new('collectionType'),
      COLLECTION_TYPE_LIST = new('collectionTypeList'),
      DATE_COMPLETED = new('dateCompleted'),
      DATE_REQUESTED = new('dateRequested'),
      END_DATE = new('endDate'),
      FEE_CURRENCY = new('feeCurrency'),
      FEE_GRP = new('feeGroup'),
      FEE_NOTE = new('feeNote'),
      FEE_PAID = new('feePaid'),
      FEE_VALUE = new('feeValue'),
      LOCATION = new('location'),
      LOCATION_LIST = new('locationList'),
      MATERIAL_TYPE = new('materialType'),
      MATERIAL_TYPE_LIST = new('materialTypeList'),
      METHOD = new('method'),
      METHOD_LIST = new('methodList'),
      NOTE = new('note'),
      OBLIGATIONS = new('obligationsFulfilled'),
      OCCASION = new('occasion'),
      OCCASION_LIST = new('occasionList'),
      PROJECT_DESC = new('projectDescription'),
      PROJECT_ID = new('projectId'),
      PROVISOS = new('provisos'),
      REFERENCE_NBR = new('referenceNumber'),
      RESULT = new('result'),
      STAFF_GRP = new('staffGroup'),
      STAFF_HOURS_SPENT = new('staffHours'),
      STAFF_NAME = new('staffName'),
      STAFF_NOTE = new('staffNote'),
      STAFF_ROLE = new('staffRole'),
      TITLE = new('title'),
      USE_DATE = new('useDate'),
      USE_DATE_GRP = new('useDateGroup'),
      USE_DATE_HOURS_SPENT = new('useDateHoursSpent'),
      USE_DATE_NUM_VISITORS = new('useDateNumberOfVisitors'),
      USE_DATE_TIME_NOTE = new('useDateTimeNote'),
      USE_DATE_VISITOR_NOTE = new('useDateVisitorNote'),
      USER = new('user'),
      USER_GRP = new('userGroup'),
      USER_INSTITUTION_ROLE = new('userInstitutionRole'),
      USER_INSTITUTION = new('userInstitution'),
      USER_UOC_ROLE = new('userUocRole')
  ]

  def self.empty_authorization
    {
        AUTHORIZED_BY.name => '',
        AUTHORIZATION_NOTE.name => '',
        AUTHORIZATION_DATE.name => '',
        AUTHORIZATION_STATUS.name => ''
    }
  end

  def self.empty_user
    {
        USER.name => '',
        USER_INSTITUTION_ROLE.name => '',
        USER_UOC_ROLE.name => '',
        USER_INSTITUTION.name => ''
    }
  end

  def self.empty_use_date
    {
        USE_DATE.name => '',
        USE_DATE_NUM_VISITORS.name => '',
        USE_DATE_HOURS_SPENT.name => '',
        USE_DATE_TIME_NOTE.name => '',
        USE_DATE_VISITOR_NOTE.name => ''
    }
  end

  def self.empty_staff
    {
        STAFF_NAME.name => '',
        STAFF_ROLE.name => '',
        STAFF_HOURS_SPENT.name => '',
        STAFF_NOTE.name => ''
    }
  end

  def self.empty_fee
    {
        FEE_CURRENCY.name => '',
        FEE_VALUE.name => '',
        FEE_NOTE.name => ''
    }
  end

end