import Foundation
class RoomViewModel : RoomViewModelService,RoomDelegation
{
    private weak var roomView : RoomViewService?
    private var  roomDataLayer = RoomDataLayer.getInstance()
    func setRoomView( roomView: RoomViewService)
    {
        self.roomView = roomView
    }
    func createRoom(roomType:RoomType,bedType:BedType,price:Float,amenities:[String],noOfRoom : Int) throws -> Result <Void,DatabaseError>
    {
        let room = Room(roomType: roomType, bedType: bedType,price: price,amenities: amenities)
        do { try roomDataLayer.insertRoomStructure(room: room) }
        catch
        { return .failure(DatabaseError.insertFailed(msg : "Room creation failed"))}
        for _ in 0..<noOfRoom
        {
            let hotelRoom = HotelRoom(roomId: room.roomIdProperty)
            do { try roomDataLayer.insertRoomData(hotelRoom : hotelRoom) }
            catch { return .failure(DatabaseError.insertFailed(msg : "Room creation failed")) }
        }
        return .success(())
    }
    func isRoomChecking() throws -> ([Room])
    {
        let rooms =  try roomDataLayer.getRoomData()
        return rooms
    }
    func isRoomAvailabilityChecking(roomId: Int, startDate: Date, endDate: Date)  throws ->
         Result <Int,DatabaseError>
    {
        let hotelRooms = try roomDataLayer.getHotelRoomData(roomId: roomId)
         for hotelRoom in hotelRooms
         {
             let bookings = try BookingDataLayer.getInstance().getStatusBookings(bookingStatus:  BookingStatus.confirmed, roomNumber : hotelRoom.roomNumberProperty)
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
                    return .success(hotelRoom.roomNumberProperty)
                }
         }
        return .failure(.noRecordFound(msg: "This Type of Room is already booked during the requested dates"))
    }
    func isValidRoomNumber(roomId : Int) throws -> Bool
    {
        let result = try roomDataLayer.getRoomData( roomId : roomId)
        if result.isEmpty
        {
            return false
        }
        return true
    }
}
