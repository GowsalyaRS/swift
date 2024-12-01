class PaymentViewModel : PaymentViewModelService, PaymentDelegation
{
    private weak var paymentView : PaymentViewService?
    let hotel = HotelDataLayer.getInstance()
    func setPaymentView(paymentView: PaymentViewService)
    {
        self.paymentView = paymentView
    }
    func calculateAmount(roomNumber: Int) -> Float
    {
        let query = """
                   SELECT price, stayingDays 
                   FROM hotel_rooms 
                   RIGHT JOIN rooms ON hotel_rooms.roomId = rooms.roomId
                   RIGHT JOIN booking b ON hotel_rooms.roomNumber = b.roomNumber
                   WHERE hotel_rooms.roomNumber = \(roomNumber);
                   """
        if let result = hotel.executeQueryData(query: query),
           let roomData = result.first, let stayingDays = roomData["stayingDays"] as? Int,
           let price = roomData["price"] as? Double
        {
            let finalPrice = ((price + (price * 0.05)) * Double(stayingDays))
            return  Float(finalPrice)
        }
        return 0.0
    }
    func setPaymentDetails (roomBooking : RoomBooking, amount : Float,paymentStatus : PaymentStatus)
    {
        let query  = """
                     insert into payment(bookingId,amount,payment_status_id)
                     values(
                      \(roomBooking.bookingIdProperty),
                      \(amount),
                      \(paymentStatus.rawValue));
                     """
        hotel.insertRecord(query: query)
    }
    func getPayementDetails() -> [Int : Payment]
    {
       let query = """
                    select * from payment
                   """
        let payments = hotel.executeQueryData(query: query)
        var paymentData : [Int:Payment] = [:]
        for payment in payments!
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
    func isPaymentChecking(roomBooking: RoomBooking) -> Bool
    {
        let query = """
                    select payment_status_id from payment where 
                    bookingId = \(roomBooking.bookingIdProperty)
                    """
        let paymentStatusId = hotel.executeQueryData(query: query)?.first?["payment_status_id"] as? Int
        return PaymentStatus(rawValue: paymentStatusId!) == .Success
    }
    func getTotalAmount(roomBooking : RoomBooking) -> Float
    {
        let query = "select amount from payment where bookingId = \(roomBooking.bookingIdProperty)"
        let amount = hotel.executeQueryData(query: query)?.first?["amount"] as? Double
        return Float(amount!)
    }
}
 
