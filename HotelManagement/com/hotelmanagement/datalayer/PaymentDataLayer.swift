class PaymentDataLayer
{
    public func insertPaymentdata(payment : Payment) throws
    {
        let paymentInsertQuery  = """
                      insert into payment(bookingId,amount,payment_status_id)
                      values(
                      \(payment.bookingIdProperty),
                      \(payment.totalAmountProperty),
                      \(payment.paymentStatusProperty.rawValue));
                     """
        try DataAccess.insertRecord(query: paymentInsertQuery)
    }
    public func  getPaymentData(query : String) throws -> [Int: Payment]
    {
        let payments = try DataAccess.executeQueryData(query: query)
        var paymentData : [Int :Payment] = [:]
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
    public func getPaymentData() throws -> [Int : Payment]
    {
        let query = "select * from payment"
        return try getPaymentData(query: query)
    }
    public func updatePaymentStatus (payment: Payment) throws
    {
        let paymentUpdateQuery = "update payment set payment_status_id = \(payment.paymentStatusProperty.rawValue) where bookingId = \(payment.bookingIdProperty)"
        try DataAccess.insertRecord(query: paymentUpdateQuery)
    }
    public func getPaymentBooking (bookingId: Int) throws -> Payment?
    {
        let query = "select * from payment where bookingId = \(bookingId)"
        let payments = try DataAccess.executeQueryData(query: query)
        guard let payment = payments.first else { return nil }
        if let bookingId = payment["bookingId"] as? Int,
           let amounts = (payment["amount"] as? Double),
           let paymentStatusId = payment["payment_status_id"] as? Int
        {
            let amount =  Float(amounts)
            let paymentStatus = PaymentStatus(rawValue: paymentStatusId)
            return Payment(bookingId: bookingId, paymentStatus: paymentStatus!, totalAmount: amount )
        }
        return nil
    }
}
