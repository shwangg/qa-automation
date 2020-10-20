class CoreAuthorityType

  attr_accessor :name

  def initialize(name)
    @name = name
  end

  TYPES = [
      CITATION = new('Citations'),
      CONCEPT = new('Concepts'),
      ORGANIZATION = new('Organizations'),
      PERSON = new('Persons'),
      PLACE = new('Places'),
      STORAGE_LOCATION = new('Storage Locations'),
      TAXON_NAME = new('Taxon names'),
      WORK = new('Works')
  ]

end
