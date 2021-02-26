class CoreRecordTypes

  attr_reader :name

  def initialize(name)
    @name = name
  end

  OBJECTS = [
    OBJECT = new('Objects')
  ]

  PROCEDURES = [
    ACQUISITIONS = new('Acquisitions'),
    COND_CHECKS = new('Condition Checks'),
    CONSERV_TREATMENTS = new('Conservation Treatments'),
    EXHIBITIONS = new('Exhibitions'),
    GROUPS = new('Groups'),
    INTAKES = new('Intakes'),
    LOANS_IN = new('Loans In'),
    LOANS_OUT = new('Loans Out'),
    LOC_MOVT_INVENTORY = new('Location/Movement/Inventory'),
    MEDIA_HANDLING = new('Media Handling'),
    OBJECT_EXITS = new('Object Exits'),
    USE_OF_COLLECT = new('Use of Collections'),
    VALUE_CONTROLS = new('Valuation Controls')
  ]

  AUTHORITIES = [
    CITATIONS = new('Citations'),
    CONCEPTS = new('Concepts'),
    ORGS = new('Organizations'),
    PERSONS = new('Persons'),
    PLACES = new('Places'),
    STORAGE_LOCS = new('Storage Locations'),
    WORKS = new('Works')
  ]

  UTIL_RESOURCES = [
    BLOBS = new('Blobs'),
    CONTACTS = new('Contacts'),
    DATA_UPDATE_INVOC = new('Data Update Invocations'),
    DATA_UPDATES = new('Data Updates'),
    ID_GENERATORS = new('ID Generators'),
    RELATIONS = new('Relations'),
    REPORT_INVOC = new('Report Invocations'),
    REPORTS = new('Reports'),
    STRUC_DATA_PARSER = new('Structured Date Parser'),
    TERM_LISTS = new('Term Lists')
  ]

  SECURITY_RES = [
    ROLES = new('Roles'),
    USERS = new('Users')
  ]

end
