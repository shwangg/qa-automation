class UCJEPSRecordTypes < CoreUCBRecordTypes

  DEPLOYMENT = Deployment::UCJEPS

  OBJECTS = [
    CATALOG_RECORDS = new('Cataloging Records')
  ]

  PROCEDURES += [
    TAXON_NAMES = new('Taxon names')
  ]

end
