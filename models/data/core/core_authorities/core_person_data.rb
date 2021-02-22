require_relative '../../../../spec_helper'

class CorePersonData < CoreAuthorityData

  DATA = [
      NAME_SALUTATION = new('salutation'),
      NAME_TITLE = new('title'),
      NAME_FORENAME = new('foreName'),
      NAME_MIDDLE_NAME = new('middleName'),
      NAME_SURNAME = new('surName'),
      NAME_ADDITION = new('nameAdditions'),
      NAME_INITIALS = new('initials'),

      NATIONALITY = new('nationality'),
      PERSON_TERM_GRP = new('personTermGroup')
  ]

end
