protocol PaymentViewModelService : AnyObject
{
    func calculateAmount(roomNumber : Int )  -> Float
    func getTotalAmount(roomBooking : RoomBooking) -> Float
    func setPaymentDetails (roomBooking : RoomBooking, amount : Float,paymentStatus : PaymentStatus)
}

