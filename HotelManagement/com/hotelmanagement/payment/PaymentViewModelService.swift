protocol PaymentViewModelService : AnyObject
{
    func calculateAmount(booking : RoomBooking ) throws -> Float
    func getTotalAmount(roomBooking : RoomBooking) throws -> Float
    func updateBookingStatus(bookingId : Int) throws
    func setPaymentDetails (roomBooking : RoomBooking, amount : Float,paymentStatus : PaymentStatus)  throws
}

