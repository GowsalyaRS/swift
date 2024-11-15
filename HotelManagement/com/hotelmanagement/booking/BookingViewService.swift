protocol BookingViewService : AnyObject
{
    func  getInputBookingStatus()
    func  getInputCheckInBooking()
    func  getInputCheckOutBooking()
    func  getInputCheckInBooking(booking : RoomBooking,totalAmount : Float)
    func  bookingAccess(guest : Guest)
    func  displayBookingDetails(roomBookings : [RoomBooking], roomNumber : Int)
}
