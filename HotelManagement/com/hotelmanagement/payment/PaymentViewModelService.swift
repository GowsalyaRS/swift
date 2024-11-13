protocol PaymentViewModelService : AnyObject
{
    func calculateAmount(roomNumber : Int )  -> Float
    func setPaymentView(paymentView: PaymentViewService)
    func setPaymentDetails (roomBooking : RoomBooking, amount : Float,paymentStatus : PaymentStatus)
    func getTotalAmount(roomBooking : RoomBooking) -> Float
    func isPaymentChecking(roomBooking: RoomBooking) -> Bool
}

