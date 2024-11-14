import Foundation
class RoomViewModel : RoomViewModelService,RoomDelegation
{
    private  weak var roomView : RoomViewService?
    private var  hotel = HotelDataLayer.getInstance()
    
    func setRoomView( roomView: RoomViewService)
    {
        self.roomView = roomView
    }
    
    func isHotelRoomCheck() -> (Bool,[Int:Room])
    {
        let rooms = HotelDataLayer.getInstance().getRooms()
        if   rooms.isEmpty
        {
            return (false,rooms)
        }
        return (true,rooms)
    }
    
    func isRoomAvailabilityChecking(roomNumber: Int, startDate: Date, endDate: Date) -> Bool
    {
        let bookings = hotel.getRoomBookings(roomNumber: roomNumber , bookingStatus : BookingStatus.confirmed)
         for booking in bookings
         {
            let bookingDate = booking.roomBookingDateProperty
            if (!bookingDate.isEmpty)
            {
                if (startDate <= bookingDate.last! && endDate >= bookingDate.first!)
                {
                    return false
                }
            }
        }
        return true
    }
    func  isValidRoomNumber(roomNumber : Int) -> Bool
    {
        if  hotel.getRooms().contains(where: { $0.key == roomNumber })
        {
            if let room : Room =  hotel.getRooms()[roomNumber]
            {
                return room.availbleProperty
            }
        }
        return false
    }
}
