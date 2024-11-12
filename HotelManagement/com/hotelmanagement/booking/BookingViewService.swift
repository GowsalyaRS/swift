protocol BookingViewService
{
    func displayBookingDetails(roomBookings : [RoomBooking], roomNumber : Int)
    func getInputBookingStatus()
    func getInputCheckBooking()
    func bookingInit(guest : Guest)
}
