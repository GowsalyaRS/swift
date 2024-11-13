struct Room : CustomStringConvertible
{
    private static var roomCount : Int = 100
    private let roomNumber       : Int
    private let capacity         : Int
    private var roomType         : RoomType
    private var bedType          : BedType
    private var price            : Float
    private var available        : Bool
    {
        didSet
        {
            print (roomNumber , " room number  is availablity  \(available)")
        }
    }
    private var amenities        : [String]
    
    init(capacity:Int,roomType:RoomType,bedType:BedType,price:Float,amenities:[String])
    {
        roomNumber      = Room.roomCount
        Room.roomCount += 1
        self.capacity   = capacity
        self.roomType   = roomType
        self.bedType    = bedType
        self.price      = price
        self.available  = true
        self.amenities  = amenities
    }
    func getRoomNumber()->Int
    {
        return roomNumber
    }
    var priceProperty : Float
    {
       return price 
    }
    
    var availbleProperty : Bool
    {
       return available
    }
    
    mutating func changeAvailability(_ available : Bool)
    {
        self.available = available
    }
    
    var description: String
    {
        return  """
                    Room Number : \(roomNumber), 
                    Capacity    : \(capacity), 
                    Room Type   : \(roomType), 
                    Bed Type    : \(bedType),
                    Price       : \(price), 
                    Available   : \(available), 
                    Amenities   : \(amenities)
                """
    }
}
