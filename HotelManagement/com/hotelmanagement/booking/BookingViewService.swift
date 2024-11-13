protocol BookingViewService : AnyObject
{
    func  displayBookingDetails(roomBookings : [RoomBooking], roomNumber : Int)
    func  getInputBookingStatus()
    func  getInputCheckInBooking()
    func  getInputCheckInBooking(booking : RoomBooking,totalAmount : Float)
    func  bookingInit(guest : Guest)
    func  getInputCheckOutBooking()
    
}
