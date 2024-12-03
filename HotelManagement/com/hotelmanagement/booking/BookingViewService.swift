protocol BookingViewService : AnyObject
{
    func  getInputBookingStatus() throws
    func  getInputCheckInBooking() throws
    func  getInputCheckOutBooking() throws   
    func  getInputBookingId() -> Int
    func  getInputCancelBooking(booking : [RoomBooking]) throws
    func  getRoomBookingDetails(guest : Guest) throws
    func  displayRoomBookingDetails(bookings : [RoomBooking]) throws
    func  displayBookingDetails(roomBookings : [RoomBooking]) throws
}
