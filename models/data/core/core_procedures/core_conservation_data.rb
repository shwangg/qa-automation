class CoreConservationData < CollectionSpaceData

    DATA = [
        CONS_REF_NUM = new('conservationNumber'),
        STATUS_GROUP = new('conservationStatusGroup'),
        STATUS = new('status'),
        STATUS_DATE = new('statusDate'),
        TREATMENT_PURPOSE = new('treatmentPurpose'),
        CONSERVATOR = new('conservator'),
        EXAMINATION_GROUP = new('examinationGroup'),
        EXAMINATION_NOTE = new('examinationNote'),
        APPROVED_BY = new('approvedBy'),
        APPROVED_DATE = new('approvedDate'),
        TREATMENT_START = new('approvedDate'),
        TREATMENT_END = new('treatmentEndDate'),
        RESEARCHER = new('researcher'),
        PROPOSAL_DATE = new('proposedAnalysisDate'),
        ANALYSIS_GROUP = new('destAnalysisGroup'),
        SAMPLE_BY = new('sampleBy'),
        # OTHER_PARTY_GROUP = new('otherPartyGroupList'),
        # OTHER_PARTY_ROLE = new('otherPartyRole'),
        PROPOSED_TREATMENT = new('proposedTreatment'),
        FABRIC_NOTE = new('fabricationNote'),
        TREATMENT_SUMMARY = new('treatmentSummary')
    ]
  
  end
  