class BOTGARDENCurrentLocationData < CoreUCBCurrentLocationData
    DATA = [
        ACTION_DATE = new('locationDate'),
        GARDEN_LOCATION = new('currentLocation'),
        MOVEMENT_NOTE = new('movementNote'),
        ACTION_CODE = new('reasonForMove')
    ]
  end
  