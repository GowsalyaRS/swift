import Foundation
class RoomViewModel : RoomViewModelService,RoomDelegation
{
    private weak var roomView : RoomViewService?
    private var  hotel = HotelDataLayer.getInstance()
    func setRoomView( roomView: RoomViewService)
    {
        self.roomView = roomView
    }
    func createRoom(roomType:RoomType,bedType:BedType,price:Float,amenities:[String],noOfRoom : Int) throws
    {
        let room = Room(roomType: roomType, bedType: bedType,price: price,amenities: amenities)
        let amenitie : String = amenities.joined(separator: ",")
        var insertRoomQuery = """
                        INSERT INTO rooms(roomId,room_type_id,bed_id,price,amenities)
                        VALUES(\(room.roomIdProperty),\(roomType.rawValue), \(bedType.rawValue),\(price),'\(amenitie)');
                        """
        do { try hotel.insertRecord(query: insertRoomQuery) }
        catch { throw Result.failure(msg : "Room Design creation failed") }
        for _ in 0..<noOfRoom
        {
            let hotelRoom = HotelRoom(roomId: room.roomIdProperty)
            insertRoomQuery = "INSERT INTO hotel_rooms(roomNumber,roomId) VALUES     (\(hotelRoom.roomNumberProperty),\(hotelRoom.roomIdProperty))"
            do { try hotel.insertRecord(query: insertRoomQuery) }
            catch { throw Result.failure(msg : "Room creation failed") }
        }
        print( "Room Created Successful")
    }
    func isRoomChecking() throws -> ([Room])
    {
        let rooms = try hotel.executeQueryData(query: "select * from rooms")
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
    func isRoomAvailabilityChecking(roomId: Int, startDate: Date, endDate: Date)  throws -> (Bool, Int)
    {
        let query = """
                    SELECT hotel_rooms.roomNumber
                    FROM hotel_rooms
                    WHERE hotel_rooms.roomId = \(roomId)
                    """
         let roomNumbers = try hotel.executeQueryData(query: query)
         for room in roomNumbers
         {
             if let roomNumber = room["roomNumber"] as? Int
             {
                    let bookingQuery = """
                                       SELECT bookingStartDate, bookingEndDate
                                       FROM booking
                                       WHERE roomNumber = \(roomNumber)
                                       AND bookingStatusId = \(BookingStatus.confirmed.rawValue)
                                       """
                    let bookings = try hotel.executeQueryData(query: bookingQuery)
                    var isAvailable = true
                    if bookings.isEmpty
                    {
                        return (true, roomNumber)
                    }
                    for booking in bookings
                    {
                        if let bookingStartString = booking["bookingStartDate"] as? String,
                           let bookingEndString = booking["bookingEndDate"] as? String,
                           let bookingStart = Validation.convertStringToDate(formate: "dd-MM-yyyy", date:bookingStartString ),
                           let bookingEnd = Validation.convertStringToDate(formate: "dd-MM-yyyy", date: bookingEndString )
                        {
                            if startDate < bookingEnd && endDate > bookingStart
                            {
                                isAvailable = false
                                break
                            }
                        }
                    }
                    if isAvailable
                    {
                        return (true, roomNumber)
                    }
                }
            }
        return (false, 0)
    }
    func  isValidRoomNumber(roomId : Int) throws -> Bool
    {
        let rooms = try hotel.executeQueryData(query: "SELECT * FROM Rooms WHERE roomId = \(roomId)")
        return !(rooms.isEmpty)
    }
}
