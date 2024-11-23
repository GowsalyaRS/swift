protocol BookingViewService : AnyObject
{
    func  getInputBookingStatus()
    func  getInputCheckInBooking()
    func  getInputCheckOutBooking()
    func  getInputBookingId() -> Int
    func  getInputCancelBooking(booking : [RoomBooking])
    func  getRoomBookingDetails(guest : Guest)
    func  displayRoomBookingDetails(bookings : [RoomBooking])
    func  displayBookingDetails(roomBookings : [RoomBooking], roomNumber : Int)
}
