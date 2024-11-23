struct HotelRoom
{
    private static var counter   : Int = 100
    private let roomNumber       : Int
    private let roomId            : Int
    private var available        : Bool = true
    {
        didSet
        {
            print (roomNumber , " room number  is availablity  \(available)")
        }
    }
    init(roomId : Int)
    {
        roomNumber = HotelRoom.counter
        HotelRoom.counter += 1
        self.roomId     = roomId
    }
    var roomIdProperty : Int
    {
        return roomId
    }
    var roomNumberProperty : Int
    {
        return roomNumber
    }
    var availbleProperty : Bool
    {
       return available
    }
    mutating func changeAvailability(_ available : Bool)
    {
        self.available = available
    }
}
