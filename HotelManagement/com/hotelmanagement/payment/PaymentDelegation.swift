protocol PaymentDelegation : AnyObject
{
    func isPaymentChecking(roomBooking: RoomBooking) throws -> Bool
}
