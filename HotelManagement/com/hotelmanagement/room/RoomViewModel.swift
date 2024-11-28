import Foundation
class RoomViewModel : RoomViewModelService,RoomDelegation
{
    private weak var roomView : RoomViewService?
    private var  hotel = HotelDataLayer.getInstance()
    func setRoomView( roomView: RoomViewService)
    {
        self.roomView = roomView
    }
    func createRoom(roomType:RoomType,bedType:BedType,price:Float,amenities:[String],noOfRoom : Int)
    {
        let room = Room(roomType: roomType, bedType: bedType,price: price,amenities: amenities)
        let amenitie : String = amenities.joined(separator: ",")
        var query = """
                    INSERT INTO rooms(roomId,room_type_id,bed_id,price,amenities)
                    VALUES(\(room.roomIdProperty),\(roomType.rawValue), \(bedType.rawValue),\(price),'\(amenitie)');
                   """
        print(hotel.insertRecord(query: query))
        for _ in 0..<noOfRoom
        {
            let hotelRoom = HotelRoom(roomId: room.roomIdProperty)
            hotel.hotelRoomsProperty.append(hotelRoom)
             query = "INSERT INTO hotel_rooms(roomNumber,roomId) VALUES     (\(hotelRoom.roomNumberProperty),\(hotelRoom.roomIdProperty))"
            print (hotel.insertRecord(query: query))
        }
    }
    func isRoomChecking() -> (Bool,[Room])
    {
        let rooms = hotel.executeQueryData(query: "select * from rooms")
        if   rooms!.isEmpty
        {
            return (false,[])
        }
        var roomsArray : [Room] = []
        for room in rooms!
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
                print("Invalid roomTypeId or bedId")
            }
        }
        return (true,roomsArray)
    }
    func isRoomAvailabilityChecking(roomId : Int, startDate: Date, endDate: Date) ->(Bool,Int)
    {
        let hotelRooms = hotel.hotelRoomsProperty.filter({$0.roomIdProperty == roomId})
        for hotelRoom in hotelRooms
        {
            let bookings = (hotel.getRoomBookings(roomNumber : hotelRoom.roomNumberProperty).filter { $0.bookingStatusProperty == .confirmed })
            var flag = true
            for booking in bookings
            {
                let bookingDate = booking.roomBookingDateProperty
                if (!bookingDate.isEmpty)
                {
                    if (startDate < bookingDate.last! && endDate > bookingDate.first!)
                    {
                        flag = false
                        break;
                    }
                }
            }
            if flag
            {
                return (true,hotelRoom.roomNumberProperty)
            }
        }
        return (false,0)
    }
    func  isValidRoomNumber(roomId : Int) -> Bool
    {
        let rooms = hotel.executeQueryData(query: "SELECT * FROM Room WHERE roomId = \(roomId)")
        return (rooms?.isEmpty) ?? false
    }
}
