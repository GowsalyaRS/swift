class PaymentView : PaymentViewService
{
    private unowned var  paymentViewModel: PaymentViewModelService
    init(paymentViewModel: PaymentViewModelService)
    {
        self.paymentViewModel = paymentViewModel
    }
    func getInputPaymentProcess(roomBooking : RoomBooking)
    {
        let total =   paymentViewModel.calculateAmount(roomNumber: roomBooking.roomNumberProperty)
         print ("Total Amount to be paid is :  \(total)")
         print("press 1 to pay for room booking in online mode : ",terminator: "")
         let inputInt = readLine()
         if  inputInt == "1"
         {
             var count = 0
             while(true)
             {
                 let amount  : Float = ValidInput.getPrice(inputName : "Enter the payment Amount : ")
                 count += 1;
                 if (amount == total)
                 {
                     paymentViewModel.setPaymentDetails(roomBooking: roomBooking, amount: amount, paymentStatus: PaymentStatus.Success)
                     print("Booking is Confirmed and Payment is successful")
                     return
                 }
                 else
                 {
                     print("Please Enter the valid Amount ")
                 }
                 if(count % 2 == 0)
                 {
                     print("Press 2 Exit")
                     let num : String? = readLine()
                     if num == "2"
                     {
                         break ;
                     }
                 }
             }
          }
        paymentViewModel.setPaymentDetails(roomBooking: roomBooking, amount: total ,paymentStatus: PaymentStatus.Pending)
        print ("Your Booking is Confirmed and Your payment is pending ")
    }
}
