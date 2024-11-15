protocol PaymentViewModelService : AnyObject
{
    func calculateAmount(roomNumber : Int )  -> Float
    func setPaymentDetails (roomBooking : RoomBooking, amount : Float,paymentStatus : PaymentStatus)
    func getTotalAmount(roomBooking : RoomBooking) -> Float
}

