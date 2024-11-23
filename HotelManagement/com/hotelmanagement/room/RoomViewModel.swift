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
        hotel.roomsProperty [room.roomIdProperty] = room
        for _ in 0..<noOfRoom
        {
            let hotelRoom = HotelRoom(roomId: room.roomIdProperty)
            hotel.hotelRoomsProperty.append(hotelRoom)
        }
    }
    func isRoomChecking() -> (Bool,[Int:Room])
    {
        let rooms = HotelDataLayer.getInstance().roomsProperty
        if   rooms.isEmpty
        {
            return (false,rooms)
        }
        return (true,rooms)
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
        return hotel.roomsProperty.contains(where: { $0.key == roomId })
    }
}
