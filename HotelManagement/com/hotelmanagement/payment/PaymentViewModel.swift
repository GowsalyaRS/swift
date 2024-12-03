class PaymentViewModel : PaymentViewModelService, PaymentDelegation
{
    private weak var paymentView : PaymentViewService?
    let hotel = HotelDataLayer.getInstance()
    func setPaymentView(paymentView: PaymentViewService)
    {
        self.paymentView = paymentView
    }
    func calculateAmount(roomNumber: Int) throws -> Float
    {
        let query = """
                   SELECT price, stayingDays 
                   FROM hotel_rooms 
                   RIGHT JOIN rooms ON hotel_rooms.roomId = rooms.roomId
                   RIGHT JOIN booking b ON hotel_rooms.roomNumber = b.roomNumber
                   WHERE hotel_rooms.roomNumber = \(roomNumber);
                   """
         let result = try hotel.executeQueryData(query: query)
         if  let roomData = result.first, let stayingDays = roomData["stayingDays"] as? Int,
           let price = roomData["price"] as? Double
        {
            let finalPrice = ((price + (price * 0.05)) * Double(stayingDays))
            return  Float(finalPrice)
        }
        return 0.0
    }
    func setPaymentDetails (roomBooking : RoomBooking, amount : Float,paymentStatus : PaymentStatus) throws
    {
        let query  = """
                     insert into payment(bookingId,amount,payment_status_id)
                     values(
                      \(roomBooking.bookingIdProperty),
                      \(amount),
                      \(paymentStatus.rawValue));
                     """
       try hotel.insertRecord(query: query)
    }
    func getPayementDetails() throws -> [Int : Payment]
    {
        let query = "select * from payment"
        let payments = try hotel.executeQueryData(query: query)
        var paymentData : [Int:Payment] = [:]
        for payment in payments
        {
            if let bookingId = payment["bookingId"] as? Int,
               let amount = payment["amount"] as? Double,
               let paymentStatusId = payment["payment_status_id"] as? Int
            {
                let paymentStatus = PaymentStatus(rawValue: paymentStatusId)!
                let amounts = Float(amount)
                let payment = Payment(bookingId: bookingId,paymentStatus: paymentStatus , totalAmount: amounts)
                paymentData[bookingId] = payment
            }
        }
        return paymentData
    }
    func isPaymentChecking(roomBooking: RoomBooking) throws -> Bool
    {
        let query = "select payment_status_id from payment where bookingId =       \(roomBooking.bookingIdProperty)"
        let paymentStatusId = try hotel.executeQueryData(query: query).first?["payment_status_id"] as? Int
        return PaymentStatus(rawValue: paymentStatusId!) == .Success
    }
    func getTotalAmount(roomBooking : RoomBooking) throws -> Float
    {
        let query = "select amount from payment where bookingId = \(roomBooking.bookingIdProperty)"
        let amount = try hotel.executeQueryData(query: query).first?["amount"] as? Double
        let querys = "update payment set payment_status_id = \(PaymentStatus.Success.rawValue) where bookingId = \(roomBooking.bookingIdProperty)"
        try hotel.insertRecord(query: querys)
        return Float(amount!)
    }
}
 
