struct Room : CustomStringConvertible
{
    private static var roomCount : Int = 1
    private let roomId           : Int
    private var roomType         : RoomType
    private var bedType          : BedType
    private var price            : Float
    private var amenities        : [String]
    init(roomType:RoomType,bedType:BedType,price:Float,amenities:[String])
    {
        roomId     = Room.roomCount
        Room.roomCount += 1
        self.roomType   = roomType
        self.bedType    = bedType
        self.price      = price
        self.amenities  = amenities
    }
    var roomIdProperty : Int
    {
        return roomId
    }
    var priceProperty : Float
    {
       return price 
    }
    var roomPriceProperty : Float
    {
        return price
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
