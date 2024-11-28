class PaymentViewModel : PaymentViewModelService, PaymentDelegation
{
    private weak var paymentView : PaymentViewService?
    let hotel = HotelDataLayer.getInstance()
    func setPaymentView(paymentView: PaymentViewService)
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
        let roomIds =  hotel.hotelRoomsProperty.filter { $0.roomNumberProperty == roomNumber }
        var price : Float = 0
        if let roomId =  roomIds.first?.roomIdProperty
        {
            let room  = hotel.roomsProperty.filter { $0.value.roomIdProperty == roomId }.first
            price = room?.value.roomPriceProperty ?? 0
        }
        if(price == 0)
        {
             return 0
        }
        price += ( price * 0.05 )
        return price
    }
    func setPaymentDetails (roomBooking : RoomBooking, amount : Float,paymentStatus : PaymentStatus)
    {
        let payment = Payment (bookingId: roomBooking.bookingIdProperty, paymentStatus: paymentStatus, totalAmount: amount)
        hotel.paymentDetailsProperty [roomBooking.bookingIdProperty] = payment
    }
    func getPayementDetails() -> [Int : Payment]
    {
        return hotel.paymentDetailsProperty
    }
    func isPaymentChecking(roomBooking: RoomBooking) -> Bool
    {
         let payments : [Int:Payment] =  hotel.paymentDetailsProperty
         let payment = payments[roomBooking.bookingIdProperty]
         if payment?.paymentStatusProperty == PaymentStatus.Success
         {
            return true
         }
        return false
    }
    func getTotalAmount(roomBooking : RoomBooking) -> Float
    {
        let payments : [Int:Payment] =  hotel.paymentDetailsProperty
        let payment = payments[roomBooking.bookingIdProperty]
        return  payment?.totalAmountProperty ?? 0
    }
}
 
