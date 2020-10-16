class CoreConditionCheckData < CollectionSpaceData

    DATA = [
        
        COND_REF_NUM = new('conditionCheckRefNumber'),
        COND_CHECK_DATE = new('conditionCheckAssessmentDate'),
        COND_NOTE = new('conditionCheckNote'),
        OBJ_AUDIT_CATEGORY = new('objectAuditCategory'),
        CONS_TREATMENT_PRIORITY = new('conservationTreatmentPriority'),
        NXT_COND_CHECK_DATE = new('nextConditionCheckDate'),
        COND_CHECK_GRP_LIST= new('conditionCheckGroupList'),
        COND_DESC = new('condition'),
        DISP_REC = new('displayRecommendations'),
        HANDLING_REC = new('handlingRecommendations')
    ]
  
  end
  