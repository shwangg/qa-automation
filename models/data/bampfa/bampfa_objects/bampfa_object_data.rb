class BAMPFAObjectData < CoreUCBObjectData

    DATA = [
        ARTIST_MAKER_GRP = new('bampfaObjectProductionPersonGroup'),
        ARTIST_NAME = new('bampfaObjectProductionPerson'),
        ID_PREFIX = new('accNumberPrefix'),
        ID_YEAR = new('accNumberPart1'),
        ID_GIFT_1 = new('accNumberPart2'),
        ID_GIFT_2 = new('accNumberPart3'),
        ID_GIFT_3 = new('accNumberPart4'),
        ID_ALPHA = new('accNumberPart5'),
        ID_NUMBER = new('objectNumber')
    ]
end
