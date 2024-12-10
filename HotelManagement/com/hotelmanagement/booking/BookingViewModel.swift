import Foundation
class BookingViewModel : BookingViewModelService
{
    private weak var bookingView : BookingViewService?
    private let bookingDataLayer =  BookingDataLayer()
    func setBookingView(bookingView: BookingViewService)
    {
        self.bookingView = bookingView
    }
    func
    addedConfirmBooking (guest : Guest, roomNumber: Int, dates: [Date], noOfGuest: Int, stayingDays : Int) throws ->  Result<RoomBooking,DatabaseError>
    {
        let booking : RoomBooking = RoomBooking(roomNumber: roomNumber, guestId: guest.guestIdProperty, noOfGuest: noOfGuest, roomBookingDate: dates,stayingDays: stayingDays)
        booking.bookingStatusProperty = .confirmed
        do
        {
           try bookingDataLayer.insertBookingData(booking: booking)
           return .success(booking)
        }
        catch
        {
            return .failure(DatabaseError.insertFailed(msg : " Booking Data storing failed"))
        }
    }
    func isAvailableBookingHistory(guest: Guest, bookingStatus: BookingStatus) throws -> [RoomBooking]
    {
        let bookings = try bookingDataLayer.getGuestStatusBookings(guestId: guest.guestIdProperty,bookingStatus : bookingStatus)
        if bookings.isEmpty
        {
            return []
        }
        return bookings
    }
    func getRoomBookingDetails(bookingStatus : BookingStatus) throws
    {
        let bookings = try bookingDataLayer.getStatusBookings(bookingStatus : bookingStatus)
        try bookingView?.displayBookingDetails(roomBookings: bookings )
    }
    func getRoomBookingDetails() throws
    {
        let  bookings = try bookingDataLayer.getAllBookings()
        try bookingView?.displayBookingDetails(roomBookings: bookings)
    }
    func getRoomBooking(bookingStatus : BookingStatus) throws -> [RoomBooking]
    {
        var bookings : [RoomBooking] =  []
        if(bookingStatus == .confirmed)
        {
            bookings = try bookingDataLayer.getStatusBookings(bookingStatus : bookingStatus).filter{$0.roomBookingDateProperty.first! < Date() }
        }
        else
        {
            bookings = try bookingDataLayer.getStatusBookings(bookingStatus : bookingStatus)
        }
        return bookings
    }
    func getValidBooking (guest: Guest) throws -> [RoomBooking]
    {
        let bookings = try bookingDataLayer.getGuestStatusBookings(guestId: guest.guestIdProperty, bookingStatus: BookingStatus.confirmed)
            .filter { $0.roomBookingDateProperty.first! > Date()}
        return bookings
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
    func setCancellationDetails(booking: RoomBooking, cancellationReason: String) throws
    {
        booking.bookingStatusProperty = BookingStatus.cancelled
        try bookingDataLayer.getUpdateBookingStatus(booking : booking)
        let roomCancellation = RoomCancellation (bookingId: booking.bookingIdProperty, cancellationReason: cancellationReason)
        try bookingDataLayer.insertCancelRoomRecord(roomCancellation: roomCancellation, booking : booking)
        let paymentViewModel = PaymentViewModel()
        try paymentViewModel.updateBookingStatus(bookingId : booking.bookingIdProperty)
    }
    func checkBooking(bookingId: Int) throws -> (Bool,RoomBooking?)
    {
        let roomBookings : [RoomBooking] =  try bookingDataLayer.getBookingIdData(bookingId: bookingId)
        if (roomBookings.isEmpty)
        {
            return (false,nil)
        }
        return (true,roomBookings.first!)
    }
    func checkBooking(roomBooking : RoomBooking) -> Bool
    {
        if roomBooking.bookingStatusProperty == BookingStatus.confirmed  && roomBooking.roomBookingDateProperty.first! == Validation.convertDate(formate :"dd-MM-yyyy" ,date: Date())
        {
            return true
        }
        return false
    }
    func setCheckInDetails(booking : RoomBooking) throws
    {
        booking.bookingStatusProperty = BookingStatus.checkin
        try bookingDataLayer.getUpdateBookingStatus(booking : booking)
        let paymentViewModel = PaymentViewModel()
        let payment = try paymentViewModel.getPayementDetails(bookingId: booking.bookingIdProperty)
        try paymentViewModel.updateBookingStatus(payment: payment!)
        let roomViewModel = RoomViewModel()
        try roomViewModel.updateRoomStatus(roomNumber : booking.roomNumberProperty,roomStatus : false)
        let logViewModel = LogMaintainViewModel()
        try logViewModel.addLoginData(booking : booking)
    }
    func setCheckoutDetails(booking : RoomBooking) throws
    {
        booking.bookingStatusProperty = BookingStatus.checkout
        try bookingDataLayer.getUpdateBookingStatus(booking : booking)
        let roomViewModel = RoomViewModel()
        try roomViewModel.updateRoomStatus(roomNumber : booking.roomNumberProperty,roomStatus : true)
        let logViewModel = LogMaintainViewModel()
        if  let login = try logViewModel.getLoginData(bookingId : booking.bookingIdProperty)
        {
            try logViewModel.updateCheckOutDate(login : login)
        }
    }
    func isAvailableCheckOut(bookingId : Int) throws-> (Bool,RoomBooking?)
    {
        let bookings = try bookingDataLayer.getBookingIdData(bookingId: bookingId)
        if (!bookings.isEmpty && bookings.first!.bookingStatusProperty == BookingStatus.checkin)
        {
            return (true,bookings.first!)
        }
        return (false,nil)
    }
    func getStatusBookings(bookingStatus:  BookingStatus, roomNumber : Int) throws -> [RoomBooking]
    {
        return try  bookingDataLayer.getStatusBookings(bookingStatus: bookingStatus, roomNumber : roomNumber)
    }
}
