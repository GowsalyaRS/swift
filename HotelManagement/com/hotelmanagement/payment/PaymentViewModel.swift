class PaymentViewModel : PaymentViewModelService, PaymentDelegation
{
    private weak var paymentView : PaymentViewService?
    let paymentDataLayer = PaymentDataLayer()
    func setPaymentView(paymentView: PaymentViewService)
    {
        self.paymentView = paymentView
    }
    func calculateAmount(booking : RoomBooking) throws -> Float
    {
        let  roomViewModel =  RoomViewModel()
        let room =   try  roomViewModel.getRoomData(roomNumber : booking.roomNumberProperty);
        let amount = room?.priceProperty ?? 0
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
    func getPayementDetails(bookingId : Int) throws -> Payment?
    {
        return try paymentDataLayer.getPaymentBooking(bookingId: bookingId)
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
    func updateBookingStatus(bookingId : Int) throws
    {
        if var payment  = try paymentDataLayer.getPaymentBooking(bookingId: bookingId)
         {
            if payment.paymentStatusProperty == PaymentStatus.Success
            {
                payment.setPaymentStatus(PaymentStatus.Refunded)
            }
            else
            {
                payment.setPaymentStatus(PaymentStatus.No_Paid)
            }
            try paymentDataLayer.updatePaymentStatus (payment: payment)
        }
    }
    func updateBookingStatus(payment: Payment) throws
    {
        var payment = payment
        if payment.paymentStatusProperty == PaymentStatus.Pending
        {
            payment.setPaymentStatus(PaymentStatus.Success)
            try paymentDataLayer.updatePaymentStatus(payment: payment)
        }
    }
}
 
