class BAMPFAInventoryMovementData < CoreUCBInventoryMovementData

  DATA = [
      COMPUTED_LOCATION = new('currentLocation', 'Current storage location'),
      CRATE = new('crate'),
      HANDLER = new('movementContact'),
      REASON = new('reasonForMove'),
      METHOD = new('movementMethod'),
      METHODS = new('movementMethods'),
      NOTE = new('movementNote')
  ]

end
