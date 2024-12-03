protocol PaymentViewService : AnyObject
{
    func getInputPaymentProcess(roomBooking : RoomBooking) throws
}
