class CollectionSpaceData

  attr_reader :name, :label

  def initialize(name, label=nil)
    @name = name
    @label = label
  end

  DATA = [
      REF_NAME = new('refName'),
      REF_NAME_CHILD = new('childRefName'),
      REF_NAMES_CHILDREN = new('childRefNames'),
      UPDATED_BY = new('updatedBy'),
      UPDATED_AT = new('updatedAt')
  ]

end
