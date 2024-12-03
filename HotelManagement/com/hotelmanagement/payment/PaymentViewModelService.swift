protocol PaymentViewModelService : AnyObject
{
    func calculateAmount(roomNumber : Int ) throws -> Float
    func getTotalAmount(roomBooking : RoomBooking) throws -> Float
    func setPaymentDetails (roomBooking : RoomBooking, amount : Float,paymentStatus : PaymentStatus)  throws
}

