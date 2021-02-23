class BOTGARDENObjectData < CoreUCBObjectData

  DATA = [
      ASSOC_PPL_GRP = new('assocPeopleGroup'),
      ASSOC_PPL = new('assocPeople'),
      ASSOC_PPL_TYPE = new('assocPeopleType'),
      ASSOC_PPL_NOTE = new('assocPeopleNote'),

      DEAD_FLAG = new(nil, 'Dead flag'),

      RARE = new('rare'),

      USAGE_GRP = new('usageGroup'),
      USAGE = new('usage'),
      USAGE_NOTE = new('usageNote')
  ]
end
