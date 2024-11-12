class PaymentView
{
    private var  paymentViewModel: PaymentViewModel
    
    init(paymentViewModel: PaymentViewModel)
    {
        self.paymentViewModel = paymentViewModel
    }
    
    func getInputPaymentProcess(roomBooking : RoomBooking)
    {
        let total =   paymentViewModel.calculateAmount(roomNumber: roomBooking.roomNumberProperty)
         print ("Total Amount to be paid is :  \(total)")
         print("press 1 to pay for room booking in online mode")
         let inputInt = readLine()
         if  inputInt == "1"
         {
            let amount  : Float = ValidInput.getPrice(inputName : "Enter the payment Amount")
            if (amount == total)
            {
                paymentViewModel.setPaymentDetails(roomBooking: roomBooking, amount: amount, paymentStatus: PaymentStatus.Success)
                return
             }
             else
             {
                print("Please Enter the valid Amount ")
             }
          }
          else
          {
            paymentViewModel.setPaymentDetails(roomBooking: roomBooking, amount: total ,paymentStatus: PaymentStatus.Pending)
            print ("Your payment is pending ")
            return
         }
    }
}
