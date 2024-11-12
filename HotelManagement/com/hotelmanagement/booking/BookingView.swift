import Foundation
class BookingView
{
    private var bookingViewModel : BookingViewModel
    
    init(bookingViewModel : BookingViewModel)
    {
       self.bookingViewModel = bookingViewModel
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
        if (bookingViewModel.isValidRoomNumber(roomNumber : roomNumber))
        {
            let days =  ValidInput.getCapacity(inputName      :" Enter the staying days : ")
            let noOfGuest =  ValidInput.getCapacity(inputName :" Enter the no of guest  : ")
            let date : Date = ValidInput.getDate(inputName    :" Enter the Date         : ")
            let dates : [Date] = Validation.generateDateArray(startDate: date, numberOfDays: days)
            if bookingViewModel.isRoomAvailabilityChecking(roomNumber: roomNumber, startDate: dates.first! , endDate: dates.last!)
            {
                
                let roomBooking = bookingViewModel.addedConfirmingBooking(guest : guest, roomNumber: roomNumber, dates: dates, noOfGuest: noOfGuest)
                let paymentViewModel = PaymentViewModel()
                let paymentView = PaymentView(paymentViewModel: paymentViewModel)
                paymentViewModel.setPaymentView(paymentView: paymentView)
                paymentView.getInputPaymentProcess(roomBooking : roomBooking)
            }
            else
            {
               print ("Room \(roomNumber) is already booked during the requested dates.")
            }
        }
    }
    
    func displayRoomBookingDetails(bookings : [RoomBooking])
    {
        let paymentViewModel = PaymentViewModel()
        let paymentView = PaymentView(paymentViewModel: paymentViewModel)
        paymentViewModel.setPaymentView(paymentView: paymentView)
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
    func getInputCheckBooking()
    {
        let bookingId : Int  = getInputBookingId()
        guard bookingId > 0 else { print ("Invalid input"); return }
        let (isValid, booking) =  bookingViewModel.checkBooking(bookingId: bookingId)
        if isValid
        {
            if bookingViewModel.checkBooking(roomBooking: booking!)
            {
                let paymentViewModel = PaymentViewModel()
                let paymentView = PaymentView(paymentViewModel:paymentViewModel )
                paymentViewModel.setPaymentView(paymentView: paymentView)
                if paymentViewModel.isPaymentChecking(roomBooking  : booking!)
                {
                    bookingViewModel.setCheckInDetails(booking: booking!)
                }
                else
                {
                    getInputCheckBooking(booking : booking!)
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
    
    func  getInputCheckBooking(booking : RoomBooking)
    {
        print ("Enter the Amount to be paid : ")
        guard let amount : Float = Float.init(readLine()!)else
        {
            print ("Invalid Amount")
            return
        }
        let paymentViewModel = PaymentViewModel()
        let paymentView = PaymentView(paymentViewModel:paymentViewModel )
        paymentViewModel.setPaymentView(paymentView: paymentView)
        
        if paymentViewModel.isPaymentChecking(roomBooking: booking , amount : amount)
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
       //  var booking =  bookingViewModel.checkingCheckOut()
    }
}