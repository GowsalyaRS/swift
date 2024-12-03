import Foundation
class BookingView  : BookingViewService
{
    private var bookingViewModel : BookingViewModelService
    private weak var delegate : RoomDelegation?
    private weak var  paymentDelegate : PaymentDelegation?
    init(bookingViewModel : BookingViewModelService)
    {
       self.bookingViewModel = bookingViewModel
    }
    func setDelegate(delegate: RoomDelegation)
    {
        self.delegate = delegate
    }
    func setPaymentDelegate(paymentDelegate: PaymentDelegation)
    {
        self.paymentDelegate = paymentDelegate
    }
    func getRoomBookingDetails(guest : Guest) throws
    {
         let roomId  = ValidInput.getCapacity(inputName :" Enter the room Id            : ")
         if roomId == 0 {  return  }
         if (( try delegate?.isValidRoomNumber(roomId : roomId)) == true)
         {
            let date = ValidInput.getDate(inputName :" Enter the Date (dd-MM-yyyy)  :")
            if date == nil{  return  }
            let days =  ValidInput.getCapacity(inputName :" Enter the staying days       : ")
            if days == 0 {  return }
            let dates : [Date] = Validation.generateDateArray(startDate: date!, numberOfDays: days)
            if let (isAvailable, roomNumber) = try  delegate?.isRoomAvailabilityChecking(roomId: roomId, startDate: dates.first!, endDate: dates.last!) , isAvailable == true
            {
                let noOfGuest =  ValidInput.getCapacity(inputName :" Enter the no of guest         : ")
                if noOfGuest == 0  { return }
                let roomBooking = try bookingViewModel.addedConfirmBooking(guest : guest, roomNumber: roomNumber, dates: dates, noOfGuest: noOfGuest, stayingDays : days)
                print("Room Booking is Successfully. Your Room Number is : \(roomNumber)")
                let paymentViewModel = PaymentViewModel()
                let paymentView = PaymentView(paymentViewModel: paymentViewModel as PaymentViewModelService)
                paymentViewModel.setPaymentView(paymentView: paymentView as PaymentViewService)
                try paymentView.getInputPaymentProcess(roomBooking : roomBooking)
            }
            else
            {
               print ("This Type of Room is already booked during the requested dates.")
            }
        }
        else
        {
            print ("This room Id  is Invalid")
        }
    }
    func getPaymentDetails()throws -> [Int : Payment]
    {
        let paymentViewModel = PaymentViewModel()
        let paymentView = PaymentView(paymentViewModel: paymentViewModel as PaymentViewModelService)
        paymentViewModel.setPaymentView(paymentView: paymentView as PaymentViewService)
        let payment : [Int : Payment] = try  paymentViewModel.getPayementDetails()
        return payment
    }
    func displayRoomBookingDetails(bookings : [RoomBooking]) throws
    {
        let payment = try getPaymentDetails()
        for booking in bookings
        {
            print (booking)
            print (payment[booking.bookingIdProperty]!)
        }
    }
    func getInputBookingStatus() throws
    {
        while true
        {
            let bookingStatus = ValidInput.getBookingStatus(inputName  : " Enter the booking status : ")
            if bookingStatus == nil { return }

            if (bookingStatus == .pending)
            {
                try bookingViewModel.getRoomBookingDetails()
            }
            else
            {
              try bookingViewModel.getRoomBookingDetails(bookingStatus : bookingStatus!)
            }
            print ("Press 0 to exit, any other key to continue ")
            if let num : Int = Int.init(readLine()!)
            {
                if(num == 0)
                {
                    break;
                }
            }
        }
    }
    func displayBookingDetails(roomBookings : [RoomBooking]) 
    {
        if roomBookings.isEmpty
        {
            print ("No Bookings Found")
            return
        }
        for roomBooking in roomBookings
        {
            print (roomBooking)
        }
    }
    func getInputCancelBooking(booking : [RoomBooking]) throws
    {
        let bookingId =   getInputBookingId()
        if bookingId == 0 { return } 
            if let booking : RoomBooking =  bookingViewModel.isValidBooking(guestBookings : booking, bookingId : bookingId)
            {
                print ("Enter the reason of cancellation  : ")
                let cancellationReason = readLine()!
                try  bookingViewModel.setCancellationDetails(booking: booking, cancellationReason: cancellationReason)
            }
            else
            {
                print ("Room Id is not valid")
            }
    }
    func getInputBookingId() -> Int
    {
        print ("Enter the booking Id  : ")
        if let bookingId : Int = Int.init(readLine()!)
        {
             return bookingId
        }
        return 0
    }
    func getInputCheckInBooking() throws
    {
        let bookingId : Int  = getInputBookingId()
        guard bookingId > 0 else { print ("Invalid input"); return }
        let (isValid, booking) = try bookingViewModel.checkBooking(bookingId: bookingId)
        if isValid
        {
            if bookingViewModel.checkBooking(roomBooking: booking!)
            {
                let paymentViewModel = PaymentViewModel()
                let paymentView = PaymentView(paymentViewModel:paymentViewModel as PaymentViewModelService )
                paymentViewModel.setPaymentView(paymentView: paymentView as PaymentViewService)
                setPaymentDelegate(paymentDelegate: paymentViewModel)
                if ((try paymentDelegate?.isPaymentChecking(roomBooking  : booking!)) == true)
                {
                   try bookingViewModel.setCheckInDetails(booking: booking!)
                }
                else
                {
                    let amount = try paymentViewModel.getTotalAmount (roomBooking: booking!)
                    print ("Your pending Amount is : \(amount)")
                    try bookingViewModel.setCheckInDetails(booking: booking!)
                }
            }
            else
            {
                print ("Booking is not found")
            }
        }
        else
        {
            print ("Booking not found")
        }
    }
    func getInputCheckOutBooking() throws
    {
        let bookingId : Int  = getInputBookingId()
        guard bookingId > 0 else { print ("Invalid input"); return }
        let  (isValid,booking) = try  bookingViewModel.isAvailableCheckOut(bookingId : bookingId)
        if isValid
        {
             try bookingViewModel.setCheckoutDetails(booking: booking!)
        }
        else
        {
            print ("Invalid Booking Id")
        }
    }
}
