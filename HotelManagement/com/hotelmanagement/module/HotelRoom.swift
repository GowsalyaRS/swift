struct HotelRoom
{
    private static var counter   : Int = 100
    private let roomNumber       : Int
    private let roomId           : Int
    private var available        : Bool = true
    {
        didSet
        {
            print (roomNumber , " room number  is availablity  \(available)")
        }
    }
    init(roomId : Int)
    {
        HotelRoom.counter += 1
        roomNumber = HotelRoom.counter
        self.roomId     = roomId
    }
    init (roomNumber : Int,roomId : Int,available : Bool)
    {
        self.roomNumber = roomNumber
        self.roomId     = roomId
        self.available  = available
    }
    var roomIdProperty : Int
    {
        return roomId
    }
    var roomNumberProperty : Int
    {
        get { return roomNumber }
    }
    var availbleProperty : Bool
    {
       return available
    }
    mutating func changeAvailability(_ available : Bool)
    {
        self.available = available
    }
    static var counterProperty : Int
    {
        get { return counter }
        set { counter = newValue }
    }
}
