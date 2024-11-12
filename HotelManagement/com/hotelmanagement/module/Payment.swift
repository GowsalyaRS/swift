struct Payment : CustomStringConvertible
{
    private var bookingId      : Int
    private var totalAmount    : Float
    private var paymentStatus  : PaymentStatus
    {
        didSet
        {
           print ("Payment Status is  \(paymentStatus)")
        }
    }
   
    init(bookingId: Int, paymentStatus: PaymentStatus , totalAmount: Float)
    {
        self.bookingId      = bookingId
        self.paymentStatus  = paymentStatus
        self.totalAmount    = totalAmount
    }
    var bookingIdProperty: Int { bookingId }
    var paymentStatusProperty: PaymentStatus
    {
        get
        {
            paymentStatus
        }
    }
    mutating func setPaymentStatus(_ paymentStatus: PaymentStatus)
    {
        self.paymentStatus = paymentStatus
    }
    var totalAmountProperty: Float { totalAmount }
    var description: String
    {
       return """
               Payment Status : \(paymentStatus)
               Total Amount   : \(totalAmount)
               -------------------------------------- 
               """
    }
}
