import Foundation
class BookingView  : BookingViewService
{
    
    private unowned var bookingViewModel : BookingViewModelService
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
    
    func  bookingAccess(guest : Guest)
    {
        print ("Welcome  \(guest.nameProperty)) to  our Booking ")
        bookingInit(guest: guest)
    }

    func bookingInit(guest : Guest)
    {
         while (true)
         {
             print ("----------------------------------")
             for  roomBooking in BookingGuestOption.allCases
             {
                 print (roomBooking.rawValue,".",roomBooking)
             }
             print ("----------------------------------")
             print ("Enter your choice : " , terminator: "")
             if let input = readLine(), let choice = Int(input)
             {
                 switch choice
                 {
                     case BookingGuestOption.RoomBooking.rawValue:
                       let roomViewModel = RoomViewModel()
                     let roomView = RoomView(roomViewModel: roomViewModel as RoomViewModelService )
                     roomViewModel.setRoomView(roomView: roomView as RoomViewService)
                     setDelegate(delegate: roomViewModel as RoomViewModel)
                        getRoomBookingDetails(guest : guest)
                     case BookingGuestOption.BookingHistory.rawValue:
                        if let bookings = bookingViewModel.isAvailableBookingHistory(guest : guest ,bookingStatus: BookingStatus.confirmed)
                        {
                            displayRoomBookingDetails(bookings : bookings)
                        }
                        else
                        {
                           print ("No Booking History")
                        }
                     case BookingGuestOption.CancelBooking.rawValue:
                     let validBooking : [RoomBooking] = bookingViewModel.getValidBooking (guest: guest)
                     if validBooking.isEmpty
                     {
                        print ("No Avilable booking found")
                        return
                     }
                     for booking in validBooking
                     {
                         print (booking)
                     }
                     getInputCancelBooking(booking: validBooking)
                     case  BookingGuestOption.cancelBookingHistory.rawValue:
                        if let bookings = bookingViewModel.isAvailableBookingHistory(guest : guest ,bookingStatus: BookingStatus.cancelled)
                        {
                           displayRoomBookingDetails(bookings : bookings)
                        }
                        else
                        {
                          print ("No Cancelling History")
                        }
                     case BookingGuestOption.WriteFeedback.rawValue:
                         let bookingId =  getInputBookingId()
                     guard bookingId > 0 else { print("Invalid booking id"); return}
                     let (isValid , booking) = bookingViewModel.checkBooking(bookingId: bookingId)
                      if isValid
                      {
                          let  feedbackViewModel = FeedbackViewModel()
                          let feedbackView = FeedbackView(feedbackViewModel: feedbackViewModel)
                          feedbackViewModel.setFeedbackView(feedbackView)
                          feedbackView.getInputFeedbackDetails(booking: booking!)
                      }
                      else
                      {
                          print("Invalid booking id")
                      }
                     case BookingGuestOption.Back.rawValue:
                     return
                     default : print("Invalid choice")
                 }
             }
             else
             {
                 print("Invalid input")
             }
         }
    }
    
    func  getRoomBookingDetails(guest : Guest)
    {
           let roomNumber = ValidInput.getCapacity(inputName  :" Enter the room number   : ")
          
        if ((delegate?.isValidRoomNumber(roomNumber : roomNumber)) == true)
        {
            let date : Date = ValidInput.getDate(inputName    :" Enter the Date         : ")
            let days =  ValidInput.getCapacity(inputName      :" Enter the staying days : ")
            let dates : [Date] = Validation.generateDateArray(startDate: date, numberOfDays: days)
           
            if ((delegate?.isRoomAvailabilityChecking (roomNumber: roomNumber, startDate: dates.first! , endDate: dates.last!)) == true)
            {
                let noOfGuest =  ValidInput.getCapacity(inputName :" Enter the no of guest  : ")
                let roomBooking = bookingViewModel.addedConfirmBooking(guest : guest, roomNumber: roomNumber, dates: dates, noOfGuest: noOfGuest)
                let paymentViewModel = PaymentViewModel()
                let paymentView = PaymentView(paymentViewModel: paymentViewModel as PaymentViewModelService)
                paymentViewModel.setPaymentView(paymentView: paymentView as PaymentViewService)
                paymentView.getInputPaymentProcess(roomBooking : roomBooking)
            }
            else
            {
               print ("Room \(roomNumber) is already booked during the requested dates.")
            }
        }
        else
        {
            print ("This room is not available")
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
        let bookingStatus = ValidInput.getBookingStatus(inputName  : " Enter the booking status : ")
        bookingViewModel.getRoomBookingDetails(bookingStatus : bookingStatus)
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
                    getInputCheckInBooking(booking : booking! , totalAmount : amount)
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
    
    func  getInputCheckInBooking(booking : RoomBooking ,totalAmount : Float)
    {
        print ("Enter the Amount to be paid : ")
        guard let amount : Float = Float.init(readLine()!)else
        {
            print ("Invalid Amount")
            return
        }
        if amount == totalAmount
        {
            bookingViewModel.setCheckInDetails(booking: booking)
        }
        else
        {
            print ("Invalid Amount ")
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
