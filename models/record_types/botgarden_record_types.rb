class BotgardenRecordTypes < CoreUCBRecordTypes

  DEPLOYMENT = Deployment::BOTGARDEN

  PROCEDURES += [
    CURRENT_LOCS = new('Current Locations'),
    DISTRIBUTIONS = new('Distributions'),
    POT_TAGS = new('Pot Tags'),
    PROPAGATIONS = new('Propagations'),
    VOUCHERS = new('Vouchers')
  ]

  AUTHORITIES += [
    GARDEN_LOCS = new('Garden Locations'),
    TAXON_NAMES = new('Taxon names')
  ]

end
