struct Room : CustomStringConvertible
{
    private static var roomCount : Int = 0
    private var roomId           : Int
    private var roomType         : RoomType
    private var bedType          : BedType
    private var price            : Float
    private var amenities        : [String]
    init(roomType:RoomType,bedType:BedType,price:Float,amenities:[String])
    {
        Room.roomCount += 1
        roomId     = Room.roomCount
        self.roomType   = roomType
        self.bedType    = bedType
        self.price      = price
        self.amenities  = amenities
    }
    init(roomId : Int ,roomType:RoomType,bedType:BedType,price:Float,amenities:[String])
    {
        self.roomId     = roomId
        self.roomType   = roomType
        self.bedType    = bedType
        self.price      = price
        self.amenities  = amenities
    }
    var roomIdProperty : Int
    {
        get { return roomId }
        set { roomId = newValue }
    }
    var priceProperty : Float
    {
       return price 
    }
    var amenitiesProperty : [String]
    {
        return amenities
    }
    var roomTypeProperty : RoomType
    {
        return roomType
    }
    var bedTypeProperty : BedType
    {
        return bedType
    }
    static var counter : Int
    {
        get { return roomCount }
        set { roomCount = newValue }
    }
    var description: String
    {
        return  """
                    ----------------------------------------
                    Room Id     : \(roomId)
                    Room Type   : \(roomType)
                    Bed Type    : \(bedType)
                    Price       : \(price)
                    Amenities   : \(amenities)
                    -----------------------------------------
                """
    }
}
