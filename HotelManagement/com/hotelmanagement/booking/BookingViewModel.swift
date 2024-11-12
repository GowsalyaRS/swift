import Foundation
class BookingViewModel
{
    private var bookingView : BookingViewService?
    private let hotel  =  HotelDataLayer.getInstance()
    
    func setBookingView(bookingView: BookingViewService)
    {
        self.bookingView = bookingView
    }
    
    func  isValidRoomNumber(roomNumber : Int) -> Bool
    {
        return  hotel.getRooms().contains(where: { $0.key == roomNumber })
    }
    
    func isRoomAvailabilityChecking(roomNumber: Int, startDate: Date, endDate: Date) -> Bool
    {
        let bookings = hotel.getRoomBookings(roomNumber: roomNumber , bookingStatus : BookingStatus.confirmed)
        for booking in bookings
        {
            let bookingDate = booking.roomBookingDateProperty
            if (!bookingDate.isEmpty)
            {
                if startDate < bookingDate.last! && endDate > bookingDate.first!
                {
                    return false
                }
            }
        }
        return true
    }
    func addedConfirmingBooking (guest : Guest, roomNumber: Int, dates: [Date], noOfGuest: Int) -> RoomBooking
    {
        let booking : RoomBooking = RoomBooking(roomNumber: roomNumber, guestId: guest.guestIdProperty, noOfGuest: noOfGuest, roomBookingDate: dates)
        booking.bookingStatusProperty = .confirmed
        hotel.addBooking(roomNumber : roomNumber , booking: booking)
        hotel.addGuestBooking(guestId: guest.guestIdProperty , booking: booking)
        hotel.setBooking(booking: booking)
        return booking
    }
    
    func isAvailableBookingHistory (guest : Guest , bookingStatus : BookingStatus) -> [RoomBooking]?
    {
        let bookings = hotel.getGuestBookings(guestNumber: guest.guestIdProperty, bookingStatus : bookingStatus)

        if bookings.isEmpty
        {
            return nil
        }
        return bookings
    }
    
    func getRoomBookingDetails(bookingStatus : BookingStatus)
    {
        let rooms  =  hotel.getRooms()
        for roomNumber in rooms.keys
        {
            let bookings = hotel.getRoomBookings(roomNumber: roomNumber, bookingStatus: bookingStatus)
            bookingView!.displayBookingDetails(roomBookings: bookings,roomNumber : roomNumber)
        }
    }
    
    func getValidBooking (guest: Guest) -> [RoomBooking]
    {
        return hotel.getGuestBookings(guestNumber: guest.guestIdProperty, bookingStatus: .confirmed)
    }
    
    func isValidBooking(roomBookings : [RoomBooking] , roomNumber : Int) -> RoomBooking?
    {
        for roomBook in roomBookings
        {
            if roomBook.roomNumberProperty == roomNumber
            {
                let date : [Date] =  roomBook.roomBookingDateProperty
                if (date.first != nil && date.first! >= Date())
                {
                    return roomBook
                }
            }
        }
        return nil
    }
    
    func setCancellationDetails(booking: RoomBooking, cancellationReason: String)
    {
        booking.bookingStatusProperty = BookingStatus.cancelled
        let roomcancelling =   RoomCancellation(bookingId: booking.bookingIdProperty, cancellationReason: cancellationReason)
        hotel.setCancelBooking(cancelBooking: roomcancelling)
        let payments =  hotel.getPaymentDetails()
        var payment  =  payments[booking.bookingIdProperty]
        payment?.setPaymentStatus(.Refunded)
    }
    
    func checkBooking(bookingId: Int) -> (Bool,RoomBooking?)
    {
        
        if let roomBooking = hotel.getBooking(bookingId:  bookingId)
        {
            return (true,roomBooking)
        }
        return (false,nil)
    }
   
    func checkBooking(roomBooking : RoomBooking) -> Bool
    {
        print (roomBooking.roomBookingDateProperty.first!)
        print (Date())
        if roomBooking.bookingStatusProperty == BookingStatus.confirmed  && roomBooking.roomBookingDateProperty.first! == Validation.convertDate(date: Date())
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    func setCheckInDetails(booking : RoomBooking) 
    {
        booking.bookingStatusProperty = BookingStatus.checkin
        let rooms = hotel.getRooms()
        var room =  rooms [booking.roomNumberProperty]
        room?.changeAvailability(false)
    }
    
    func setCheckoutDetails(booking : RoomBooking)
    {
        booking.bookingStatusProperty = BookingStatus.checkout
        let rooms = hotel.getRooms()
        var room =  rooms [booking.roomNumberProperty]
        room?.changeAvailability(true)
    }
    
    func isAvailableCheckOut(bookingId : Int) -> (Bool,RoomBooking?)
    {
        let booking = hotel.getBooking(bookingId: bookingId)
        if (booking != nil &&  booking?.bookingStatusProperty == BookingStatus.checkin)
        {
            return (true,booking)
        }
       return (false,nil)
    }
}
