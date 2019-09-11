class CoreInventoryMovementData < CollectionSpaceData

  DATA = [
      REF_NUM = new('movementReferenceNumber'),
      NORMAL_LOCATION = new('normalLocation'),
      CURRENT_LOCATION = new('currentLocation'),
      CURRENT_LOCATION_FITNESS = new('currentLocationFitness'),
      CURRENT_LOCATION_NOTE = new('currentLocationNote'),
      LOCATION_DATE = new('locationDate')
  ]

end
