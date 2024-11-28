protocol PaymentDelegation : AnyObject
{
    func isPaymentChecking(roomBooking: RoomBooking) -> Bool
}
