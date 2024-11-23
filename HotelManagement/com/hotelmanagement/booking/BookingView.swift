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
    func  getRoomBookingDetails(guest : Guest)
    {
         let roomId  = ValidInput.getCapacity(inputName  :" Enter the room Id    : ")
         if ((delegate?.isValidRoomNumber(roomId : roomId)) == true)
         {
            let date   = ValidInput.getDate(inputName    :" Enter the Date         : ")
            if date == nil{  return  }
            let days =  ValidInput.getCapacity(inputName      :" Enter the staying days : ")
            if days == 0 {  return }
            let dates : [Date] = Validation.generateDateArray(startDate: date!, numberOfDays: days)
            if let (isAvailable, roomNumber) = delegate?.isRoomAvailabilityChecking(roomId: roomId, startDate: dates.first!, endDate: dates.last!) , isAvailable == true
            {
                let noOfGuest =  ValidInput.getCapacity(inputName :" Enter the no of guest  : ")
                if noOfGuest == 0  { return }
                let roomBooking = bookingViewModel.addedConfirmBooking(guest : guest, roomNumber: roomNumber, dates: dates, noOfGuest: noOfGuest)
                print("Room Booking is Successfully. Your Room Number is : \(roomNumber)")
                let paymentViewModel = PaymentViewModel()
                let paymentView = PaymentView(paymentViewModel: paymentViewModel as PaymentViewModelService)
                paymentViewModel.setPaymentView(paymentView: paymentView as PaymentViewService)
                paymentView.getInputPaymentProcess(roomBooking : roomBooking)
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
    func displayRoomBookingDetails(bookings : [RoomBooking])
    {
        let paymentViewModel = PaymentViewModel()
        let paymentView = PaymentView(paymentViewModel: paymentViewModel as PaymentViewModelService)
        paymentViewModel.setPaymentView(paymentView: paymentView as PaymentViewService)
        let payment : [Int : Payment] = paymentViewModel.getPayementDetails()
        for booking in bookings
        {
            print (booking)
            print (payment[booking.bookingIdProperty]!)
        }
    }
    func getInputBookingStatus()
    {
        while true
        {
            let bookingStatus = ValidInput.getBookingStatus(inputName  : " Enter the booking status : ")
            if bookingStatus == nil { return }
            bookingViewModel.getRoomBookingDetails(bookingStatus : bookingStatus!)
            print (" Press 1 to exit : ")
            if let num : Int = Int.init(readLine()!)
            {
                if(num==1)
                {
                    break;
                }
            }
        }
    }
    func displayBookingDetails(roomBookings : [RoomBooking], roomNumber : Int)
    {
        if roomBookings.isEmpty
        {
            print (" No Bookings Found  in room number :  (\(roomNumber))")
            return
        }
        print (" Booking room number \(roomNumber)")
        for roomBooking in roomBookings
        {
            print (roomBooking)
        }
    }
    func getInputCancelBooking(booking : [RoomBooking])
    {
        print ("Enter the room number to cancel booking : ")
        if let roomNumber : Int = Int.init(readLine()!)
        {
            if let booking : RoomBooking =  bookingViewModel.isValidBooking(roomBookings : booking, roomNumber: roomNumber)
            {
                print ("Enter the reason of cancellation  : ")
                let cancellationReason = readLine()!
                bookingViewModel.setCancellationDetails(booking: booking, cancellationReason: cancellationReason)
            }
            else
            {
                print ("Room number not found")
            }
        }
        else
        {
            print ("Invalid input")
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
    func getInputCheckInBooking()
    {
        let bookingId : Int  = getInputBookingId()
        guard bookingId > 0 else { print ("Invalid input"); return }
        let (isValid, booking) =  bookingViewModel.checkBooking(bookingId: bookingId)
        if isValid
        {
            if bookingViewModel.checkBooking(roomBooking: booking!)
            {
                let paymentViewModel = PaymentViewModel()
                let paymentView = PaymentView(paymentViewModel:paymentViewModel as PaymentViewModelService )
                paymentViewModel.setPaymentView(paymentView: paymentView as PaymentViewService)
                setPaymentDelegate(paymentDelegate: paymentViewModel)
                if ((paymentDelegate?.isPaymentChecking(roomBooking  : booking!)) == true)
                {
                    bookingViewModel.setCheckInDetails(booking: booking!)
                }
                else
                {
                    let amount = paymentViewModel.getTotalAmount (roomBooking: booking!)
                    print ("Your pending Amount is : \(amount)")
                    bookingViewModel.setCheckInDetails(booking: booking!)
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
    func  getInputCheckOutBooking()
    {
        let bookingId : Int  = getInputBookingId()
        guard bookingId > 0 else { print ("Invalid input"); return }
        let  (isValid ,booking) =  bookingViewModel.isAvailableCheckOut(bookingId : bookingId)
        if isValid
        {
            bookingViewModel.setCheckoutDetails(booking: booking!)
        }
        else
        {
            print ("Invalid Booking Id")
        }
    }
}
