class PAHMAInventoryMovementData < CoreUCBInventoryMovementData

  DATA = [
      CRATE = new('crate'),
      LOCATION_HANDLER = new('locationHandler'),
      LOCATION_HANDLERS = new('locationHandlers'),
      REASON = new('reasonForMove'),
      METHOD = new('movementMethod'),
      METHODS = new('movementMethods'),
      NOTE = new('movementNote')
  ]

end
