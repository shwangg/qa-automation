require_relative '../../../../spec_helper'

class BOTGARDENTaxonData < CoreUCBAuthorityData
#CoreUCBAuthorityPage is used because CoreUCBTaxonPage/CoreTaxonPage does not exist

  DATA = [
      ACCESS_RESTRICTIONS = new('accessRestrictions'),
      CONCEPT_TERMS = new('conceptTermGroup'),
      CONSERV_ORG = new('conservationOrganization'),
      CONSERV_CATEG = new('conservationCategory'),
      DISPLAY_NAME = new('termDisplayName'),
      TERM_GROUP = new('taxonTermGroup'),
      PLANT_ATTRIB_GRP = new('plantAttributesGroup'),
      QUALIFIER = new('termQualifier')
  ]

end
