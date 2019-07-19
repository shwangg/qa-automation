require_relative '../../../../spec_helper'

class UCJEPSUseOfCollectionsData < CoreUseofCollectionsData

  DATA = [
      AUTHORIZATION_GRP = new('authorizationGroup'),
      AUTHORIZATION_STATUS = new('authorizationStatus'),
      COLLECTION_TYPE = new('collectionType'),
      COLLECTION_TYPE_LIST = new('collectionTypeList'),
      DATE_COMPLETED = new('dateCompleted'),
      DATE_REQUESTED = new('dateRequested'),
      FEE_AMOUNT = new('feeAmount'),
      FEE_NOTE = new('feeNote'),
      FEE_PAID = new('feePaid'),
      LINK_TO_CONTRACT = new('linkToContract'),
      LOCATION = new('location'),
      LOCATION_LIST = new('locationList'),
      MATERIAL_TYPE = new('materialType'),
      MATERIAL_TYPE_LIST = new('materialTypeList'),
      OBLIGATIONS = new('obligationsFulfilled'),
      OCCASION = new('occasion'),
      OCCASION_LIST = new('occasionList'),
      PROJECT_DESC = new('projectDescription'),
      PROJECT_ID = new('projectId'),
      STAFF_GRP = new('staffGroup'),
      STAFF_HOURS_SPENT = new('staffHours'),
      STAFF_NAME = new('staffName'),
      STAFF_NOTE = new('staffNote'),
      STAFF_ROLE = new('staffRole'),
      USE_DATE = new('useDate'),
      USE_DATE_GRP = new('useDateGroup'),
      USE_DATE_HOURS_SPENT = new('useDateHoursSpent'),
      USE_DATE_NUM_VISITORS = new('useDateNumberOfVisitors'),
      USE_DATE_VISITOR_NOTE = new('useDateVisitorNote'),
      USER_INSTITUTION = new('userInstitution'),
      USER_ROLE = new('userRole')
  ]

  def empty_authorization
    {
        AUTHORIZED_BY.name => '',
        AUTHORIZATION_NOTE.name => '',
        AUTHORIZATION_DATE.name => '',
        AUTHORIZATION_STATUS.name => ''
    }
  end

  def empty_user
    {
        USER.name => '',
        USER_TYPE.name => '',
        USER_ROLE.name => '',
        USER_INSTITUTION.name => ''
    }
  end

  def empty_staff
    {
        STAFF_NAME.name => '',
        STAFF_ROLE.name => '',
        STAFF_HOURS_SPENT.name => '',
        STAFF_NOTE.name => ''
    }
  end

end