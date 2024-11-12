class PaymentViewModel
{
    private var paymentView : PaymentView?
    let hotel = HotelDataLayer.getInstance()
    
    func setPaymentView(paymentView: PaymentView)
    {
        self.paymentView = paymentView
    }
    
    func isValidAmount(amount: Float , totalPrice : Float) -> Bool
    {
        if amount == totalPrice
        {
            return true
        }
        return false
    }
    
    func calculateAmount(roomNumber : Int )  -> Float
    {
        var price =  hotel.getRooms()[roomNumber]?.priceProperty
        if price == nil
        {
            return 0
        }
        let discount = (hotel.hotelProperty.bookingDiscountProperty *  price!)
        price! += ( price! * 0.05 ) - discount
        ValidInput.alert(msg : "Your Discount  Amount  is : \(discount)")
        return price!
    }
    
    func setPaymentDetails (roomBooking : RoomBooking, amount : Float,paymentStatus : PaymentStatus)
    {
        let payment = Payment (bookingId: roomBooking.bookingIdProperty, paymentStatus: paymentStatus, totalAmount: amount)
        hotel.setPaymentDetails(payment: payment)
    }
    
    func getPayementDetails() -> [Int : Payment]
    {
        return hotel.getPaymentDetails()
    }
    
    func isPaymentChecking(roomBooking: RoomBooking) -> Bool
    {
         let payments : [Int:Payment] =  hotel.getPaymentDetails()
         let payment = payments[roomBooking.bookingIdProperty]
         if payment?.paymentStatusProperty == PaymentStatus.Success
         {
            return true
         }
        return false
    }
    
    func isPaymentChecking (roomBooking : RoomBooking , amount : Float) -> Bool
    {
        let payments : [Int:Payment] =  hotel.getPaymentDetails()
        var payment = payments[roomBooking.bookingIdProperty]
        if payment?.totalAmountProperty == amount
        {
            payment?.paymentStatusProperty = PaymentStatus.Success
            return true
        }
        return false
    }
}
 
