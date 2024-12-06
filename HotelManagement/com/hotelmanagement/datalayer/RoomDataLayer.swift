class RoomDataLayer
{
    private static var roomDataLayer : RoomDataLayer? = nil
    private init()
    {
    }
    public static func getInstance() -> RoomDataLayer
    {
        if roomDataLayer == nil
        {
            roomDataLayer = RoomDataLayer()
        }
        return roomDataLayer!
    }
    func insertRoomStructure(room: Room) throws
    {
        let amenitie : String = room.amenitiesProperty.joined(separator: ",")
        let insertRoomQuery = """
                              INSERT INTO rooms(roomId,room_type_id,bed_id,price,amenities)
                              VALUES(\(room.roomIdProperty),\(room.roomTypeProperty.rawValue), \(room.bedTypeProperty.rawValue),\(room.priceProperty),'\( amenitie)');
                              """
        try DataAccess.insertRecord(query: insertRoomQuery)
    }
    func insertRoomData(hotelRoom : HotelRoom) throws
    {
       let insertRoomQuery = "INSERT INTO hotel_rooms(roomNumber,roomId) VALUES     (\(hotelRoom.roomNumberProperty),\(hotelRoom.roomIdProperty))"
        try DataAccess.insertRecord(query: insertRoomQuery)
    }
    func getRoomDetails (query : String) throws -> [Room]
    {
        let rooms = try DataAccess.executeQueryData(query: query)
        var roomsArray : [Room] = []
        for room in rooms
        {
            let roomId = room["roomId"] as! Int
            let room_id = room["room_type_id"] as! Int
            let bed_id = room["bed_id"] as! Int
            let amenitie = room["amenities"] as! String
            let price = (Float)(room["price"] as! Double)
            if let roomType = RoomType(rawValue: room_id),
               let bedType = BedType(rawValue: bed_id)
            {
                let amenities  = amenitie.split(separator: ",").map { String($0).trimmingCharacters(in: .whitespaces) }
                var roomss = Room(roomId : roomId,roomType: roomType, bedType: bedType, price: price, amenities: amenities)
                    roomss.roomIdProperty = roomId
                    roomsArray.append(roomss)
            }
            else
            {
                print("Invalid bed type or room type" )
            }
        }
        return (roomsArray)
    }
    func getRoomData() throws -> [Room]
    {
        return try getRoomDetails(query: "select * from rooms")
    }
    func getHotelRoomDetails (query : String) throws -> [HotelRoom]
    {
        let hotelRooms = try DataAccess.executeQueryData(query:query)
        var hotelRoomsArray : [HotelRoom] = []
        for hotelroom in hotelRooms
        {
            let roomNumber = hotelroom["roomNumber"] as! Int
            let roomId = hotelroom["roomId"] as! Int
            let availableInt = hotelroom["available"] as! Int
            let available = availableInt == 1 ? true : false
            let hotelRoom = HotelRoom(roomNumber: roomNumber, roomId: roomId, available: available)
            hotelRoomsArray.append(hotelRoom)
        }
        return hotelRoomsArray
    }
    func getHotelRoomData() throws -> [HotelRoom]
    {
        return  try getHotelRoomDetails(query : "select * from hotel_rooms")
    }
    func updateHotelRoomData(hotelRoom: HotelRoom) throws
    {
        let  updateRoomAvailableQuery = "update hotel_rooms set available = \(hotelRoom.availbleProperty) where roomNumber =   \(hotelRoom.roomNumberProperty)"
        try DataAccess.insertRecord(query:  updateRoomAvailableQuery)
    }
    func getRoomNumber(roomNumber: Int) throws ->  HotelRoom?
    {
        let hotelRooms = try DataAccess.executeQueryData(query: "select * from hotel_rooms where roomNumber = \(roomNumber)")
        for hotelroom in hotelRooms
        {
            let roomNumber = hotelroom["roomNumber"] as! Int
            let roomId = hotelroom["roomId"] as! Int
            let availableInt = hotelroom["available"] as! Int
            let available = availableInt == 1 ? true : false
            let hotelRoom = HotelRoom(roomNumber: roomNumber, roomId: roomId, available: available)
            return hotelRoom
        }
        return nil
    }
    func getRoomData( roomId : Int ) throws -> [Room]
    {
         let roomQuery = """
                          select * from rooms
                          where roomId = \(roomId)
                         """
         return try getRoomDetails(query: roomQuery)
    }
    func getHotelRoomData(roomId: Int) throws -> [HotelRoom]
    {
        let hotelRoomQuery = """
                             select * from hotel_rooms 
                             where roomId = \(roomId)
                             """
        return try getHotelRoomDetails(query : hotelRoomQuery)
    }
}

