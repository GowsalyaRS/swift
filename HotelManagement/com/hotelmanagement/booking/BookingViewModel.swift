import Foundation
class BookingViewModel : BookingViewModelService
{
    private weak var bookingView : BookingViewService?
    private let hotel  =  HotelDataLayer.getInstance()
    func setBookingView(bookingView: BookingViewService)
    {
        self.bookingView = bookingView
    }
    func addedConfirmBooking (guest : Guest, roomNumber: Int, dates: [Date], noOfGuest: Int) -> RoomBooking
    {
        let booking : RoomBooking = RoomBooking(roomNumber: roomNumber, guestId: guest.guestIdProperty, noOfGuest: noOfGuest, roomBookingDate: dates)
        booking.bookingStatusProperty = .confirmed
        hotel.addBooking(roomNumber : roomNumber , booking: booking)
        hotel.addGuestBooking(guestId: guest.guestIdProperty , booking: booking)
        hotel.bookingProperty [booking.bookingIdProperty] = booking
        return booking
    }
    func isAvailableBookingHistory (guest : Guest , bookingStatus : BookingStatus) -> [RoomBooking]
    {
        let bookings = hotel.getGuestBookings(guestNumber: guest.guestIdProperty)
        .filter { $0.bookingStatusProperty == bookingStatus }
        if bookings.isEmpty
        {
            return []
        }
        return bookings
    }
    func getRoomBookingDetails(bookingStatus : BookingStatus)
    {
        let rooms  =  hotel.hotelRoomsProperty
        for room in rooms
        {
            let roomNumber =  room.roomNumberProperty
            let bookings = hotel.getRoomBookings(roomNumber: roomNumber)
            let validBooking =  bookings.filter { $0.bookingStatusProperty == bookingStatus }
            bookingView!.displayBookingDetails(roomBookings: validBooking,roomNumber : roomNumber)
        }
    }
    func getRoomBookingDetails()
    {
        let rooms  =  hotel.hotelRoomsProperty
        for room in rooms
        {
            let roomNumber =  room.roomNumberProperty
            let bookings = hotel.getRoomBookings(roomNumber: roomNumber)
            bookingView!.displayBookingDetails(roomBookings: bookings,roomNumber : roomNumber)
        }
    }
    func getValidBooking (guest: Guest) -> [RoomBooking]
    {
        let bookings =  hotel.getGuestBookings(guestNumber: guest.guestIdProperty)
        if bookings.isEmpty
        {
            return []
        }
        return bookings.filter { $0.bookingStatusProperty == .confirmed }
    }
    func isValidBooking(guestBookings : [RoomBooking] , bookingId : Int) -> RoomBooking?
    {
        for roomBook in guestBookings
        {
            if roomBook.bookingIdProperty == bookingId && roomBook.bookingStatusProperty == .confirmed
            {
                let date : [Date] =  roomBook.roomBookingDateProperty
                if (date.first != nil && date.first! > Date())
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
        hotel.cacelBookingProperty[booking.bookingIdProperty] = roomcancelling
        let payments =  hotel.paymentDetailsProperty
        var payment  =  payments[booking.bookingIdProperty]!
        if  payment.paymentStatusProperty  == PaymentStatus.Pending
        {
           payment.setPaymentStatus(.No_Paid)
        }
        else
        {
            payment.setPaymentStatus(.Success)
        }
    }
    func checkBooking(bookingId: Int) -> (Bool,RoomBooking?)
    {
        if let roomBooking = hotel.bookingProperty[bookingId]
        {
            return (true,roomBooking)
        }
        return (false,nil)
    }
    func checkBooking(roomBooking : RoomBooking) -> Bool
    {
        if roomBooking.bookingStatusProperty == BookingStatus.confirmed  && roomBooking.roomBookingDateProperty.first! == Validation.convertDate(date: Date())
        {
            return true
        }
        return false
    }
    func setCheckInDetails(booking : RoomBooking)
    {
        booking.bookingStatusProperty = BookingStatus.checkin
        let rooms = hotel.hotelRoomsProperty
        let filteredRooms = rooms.filter { $0.roomNumberProperty == booking.roomNumberProperty }
        if var room = filteredRooms.first
        {
            room.changeAvailability(false)
            let currentDate = Validation.convertDateToString(formate:"yyyy-MM-dd",date: Date())
            let log =  LogMaintain(bookingId : booking.bookingIdProperty , checkIn : currentDate!)
            hotel.addLog(bookingId: booking.bookingIdProperty,log: log)
        }
    }
    func setCheckoutDetails(booking : RoomBooking)
    {
        booking.bookingStatusProperty = BookingStatus.checkout
        let rooms = hotel.hotelRoomsProperty
        let filteredRooms = rooms.filter { $0.roomNumberProperty == booking.roomNumberProperty }
        if var room = filteredRooms.first
        {
            room.changeAvailability(true)
            var log =  hotel.getLog(bookingId: booking.bookingIdProperty)!
            log.setCheckOut(Validation.convertDateToString(formate:"yyyy-MM-dd",date: Date())!)
            hotel.addLog(bookingId: booking.bookingIdProperty,log: log)
        }
    }
    func isAvailableCheckOut(bookingId : Int) -> (Bool,RoomBooking?)
    {
        let booking = hotel.bookingProperty[bookingId]
        if (booking != nil &&  booking?.bookingStatusProperty == BookingStatus.checkin)
        {
            return (true,booking)
        }
       return (false,nil)
    }
}
