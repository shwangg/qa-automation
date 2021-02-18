class PAHMARecordTypes < CoreUCBRecordTypes

  DEPLOYMENT = Deployment::PAHMA

  PROCEDURES += [
    ACCESSIONS = new('Accessions'),
    IN_LOANS = new('In Loans'),
    INVENTORY_MOVT = new('Inventory/Movement'),
    MEDIA = new('Media'),
    NAGPRA_CLAIMS = new('NAGPRA Claims'),
    OBJECT_ENTRIES = new('Object Entries'),
    OSTEOLOGY = new('Osteology'),
    OUT_LOANS = new('Out Loans')
  ]

  AUTHORITIES += [
    TAXON_NAMES = new('Taxon names')
  ]

end
