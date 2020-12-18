class BOTGARDENObjectData < CoreUCBObjectData

  DATA = [

      ANNOT_GRP = new('annotationGroup'),
      ANNOT_TYPE = new('annotationType'),
      ANNOT_NOTE = new('annotationNote'),
      ANNOT_DATE = new('annotationDate'),
      ANNOT_AUTHOR = new('annotationAuthor'),
      ASSOC_PPL_GRP = new('assocPeopleGroup'),
      ASSOC_PPL = new('assocPeople'),
      ASSOC_PPL_TYPE = new('assocPeopleType'),
      ASSOC_PPL_NOTE = new('assocPeopleNote'),

      RARE = new('rare'),
      TAXON_IDENT_GRP = new('taxonomicIdentGroup'),
      TAXON_NAME = new('taxon'),
      TAXON_QUALIFIER = new('qualifier'),
      TAXON_BY = new('identBy'),
      TAXON_INSTITUTION = new('institution'),
      TAXON_KIND = new('identKind'),
      TAXON_REF = new('reference'),
      TAXON_PAGE = new('refPage'),
      TAXON_NOTE = new('notes'),

      USAGE_GRP = new('usageGroup'),
      USAGE = new('usage'),
      USAGE_NOTE = new('usageNote')
  ]
end
