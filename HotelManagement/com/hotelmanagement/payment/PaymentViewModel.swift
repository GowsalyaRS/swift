class PaymentViewModel : PaymentViewModelService, PaymentDelegation
{
    private weak var paymentView : PaymentViewService?
    let paymentDataLayer = PaymentDataLayer.getInstance()
    func setPaymentView(paymentView: PaymentViewService)
    {
        self.paymentView = paymentView
    }
    func calculateAmount(booking : RoomBooking) throws -> Float
    {
        let roomDataLayer = RoomDataLayer.getInstance()
        let hotelRoom =  try roomDataLayer.getHotelRoomData().filter { $0.roomNumberProperty == booking.roomNumberProperty }
        let roomId  = hotelRoom.first?.roomIdProperty ?? 0
        let room = try roomDataLayer.getRoomData().filter { $0.roomIdProperty == roomId }
        let amount = room.first?.priceProperty ?? 0
        if amount != 0
        {
            return  ((amount*0.05) + amount) * Float(booking.stayingDaysProperty)
        }
        return 0.0
    }
    func setPaymentDetails (roomBooking : RoomBooking, amount : Float,paymentStatus : PaymentStatus) throws
    {
        let payment = Payment (bookingId: roomBooking.bookingIdProperty, paymentStatus: paymentStatus, totalAmount: amount)
        try  paymentDataLayer.insertPaymentdata(payment: payment)
    }
    func getPayementDetails() throws -> [Int : Payment]
    {
        return try paymentDataLayer.getPaymentData()
    }
    func isPaymentChecking(roomBooking: RoomBooking) throws -> Bool
    {
        if let payment =  try paymentDataLayer.getPaymentBooking(bookingId: roomBooking.bookingIdProperty)
        {
            if payment.paymentStatusProperty == PaymentStatus.Success
            {
                return true
            }
        }
        return false
    }
    func getTotalAmount(roomBooking : RoomBooking) throws -> Float
    {
        if let payment = try paymentDataLayer.getPaymentBooking(bookingId: roomBooking.bookingIdProperty)
        {
            return  payment.totalAmountProperty
        }
        return  0.0
    }
}
 
