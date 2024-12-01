class PaymentView : PaymentViewService
{
    private unowned var  paymentViewModel: PaymentViewModelService
    init(paymentViewModel: PaymentViewModelService)
    {
        self.paymentViewModel = paymentViewModel
    }
    func getInputPaymentProcess(roomBooking : RoomBooking)
    {
         let total = paymentViewModel.calculateAmount(roomNumber: roomBooking.roomNumberProperty)
         print ("Total Amount to be paid is :  \(total)")
         print("press 1 to pay for room booking in online mode : ",terminator: "")
         let inputInt = readLine()
         if  inputInt == "1"
         {
             paymentViewModel.setPaymentDetails(roomBooking: roomBooking, amount: total, paymentStatus: PaymentStatus.Success)
             print("Booking is Confirmed and Payment is successful")
             return
          }
         paymentViewModel.setPaymentDetails(roomBooking: roomBooking, amount: total ,paymentStatus: PaymentStatus.Pending)
         print ("Your Booking is Confirmed and Your payment is pending ")
    }
}
