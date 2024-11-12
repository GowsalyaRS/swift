protocol PaymentViewModelService
{
    func calculateAmount(roomNumber : Int )  -> Float
    func setPaymentView(paymentView: PaymentViewService)
    func setPaymentDetails (roomBooking : RoomBooking, amount : Float,paymentStatus : PaymentStatus)
}
