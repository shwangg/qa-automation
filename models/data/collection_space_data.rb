class CollectionSpaceData

  attr_reader :name

  def initialize(name)
    @name = name
  end

  DATA = [
      REF_NAME = new('refName'),
      REF_NAME_CHILD = new('childRefName'),
      REF_NAMES_CHILDREN = new('childRefNames'),
      UPDATED_BY = new('updatedBy'),
      UPDATED_AT = new('updatedAt')
  ]

end
