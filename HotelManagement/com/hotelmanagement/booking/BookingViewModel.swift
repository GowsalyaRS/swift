import Foundation
class BookingViewModel : BookingViewModelService
{
    private weak var bookingView : BookingViewService?
    private let bookingDataLayer =  BookingDataLayer.getInstance()
    private let paymentDataLayer = PaymentDataLayer.getInstance()
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
        let bookings = try bookingDataLayer.getGuestBookings(guestId: guest.guestIdProperty)
                .filter { $0.bookingStatusProperty == bookingStatus }
        if bookings.isEmpty
        {
            return []
        }
        return bookings
    }
    func getRoomBookingDetails(bookingStatus : BookingStatus) throws
    {
        let bookings = try bookingDataLayer.getAllBookings()
            .filter { $0.bookingStatusProperty == bookingStatus}
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
             bookings = try bookingDataLayer.getAllBookings().filter { $0.bookingStatusProperty == bookingStatus &&  $0.roomBookingDateProperty.first! < Date() }
        }
        else
        {
            bookings = try bookingDataLayer.getAllBookings().filter { $0.bookingStatusProperty == bookingStatus }
        }
        return bookings
    }
    func getValidBooking (guest: Guest) throws -> [RoomBooking]
    {
        let bookings = try bookingDataLayer.getGuestBookings(guestId: guest.guestIdProperty)
            .filter { $0.bookingStatusProperty == .confirmed &&  $0.roomBookingDateProperty.first! > Date() }
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
        let payments   = try PaymentDataLayer.getInstance().getPaymentData()
        var payment    = payments[booking.bookingIdProperty]!
        if payment.paymentStatusProperty == PaymentStatus.Success
        {
            payment.setPaymentStatus(PaymentStatus.Refunded)
        }
        else
        {
            payment.setPaymentStatus(PaymentStatus.No_Paid)
        }
        try paymentDataLayer.updatePaymentStatus (payment: payment)
    }
    func checkBooking(bookingId: Int) throws -> (Bool,RoomBooking?)
    {
        let bookings : [RoomBooking] = try bookingDataLayer.getAllBookings()
        let roomBookings : [RoomBooking] =  bookings.filter { $0.bookingIdProperty == bookingId }
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
        let payments = try paymentDataLayer.getPaymentData()
        var payment = payments[booking.bookingIdProperty]
        if payment != nil && payment!.paymentStatusProperty == PaymentStatus.Pending
        {
            payment?.setPaymentStatus(PaymentStatus.Success)
            try paymentDataLayer.updatePaymentStatus(payment: payment!)
        }
        let hotelRooms = try RoomDataLayer.getInstance().getHotelRoomData()
            .filter { $0.roomNumberProperty == booking.roomNumberProperty }
        var hotelRoom = hotelRooms.first!
        hotelRoom.changeAvailability(false)
        try RoomDataLayer.getInstance().updateHotelRoomData(hotelRoom: hotelRoom)
        let login =  LogMaintain(bookingId : booking.bookingIdProperty , checkIn : Date())
        try LoginDataLayer.getInstance().insertLoginData(loginData : login)
    }
    func setCheckoutDetails(booking : RoomBooking) throws
    {
        let loginDataLayer = LoginDataLayer.getInstance()
        booking.bookingStatusProperty = BookingStatus.checkout
        try bookingDataLayer.getUpdateBookingStatus(booking : booking)
        let hotelRooms = try RoomDataLayer.getInstance().getHotelRoomData()
            .filter { $0.roomNumberProperty == booking.roomNumberProperty }
        var hotelRoom = hotelRooms.first!
        hotelRoom.changeAvailability(true)
        try RoomDataLayer.getInstance().updateHotelRoomData(hotelRoom: hotelRoom)
        if  var login = try loginDataLayer.getLoginData(bookingId : booking.bookingIdProperty)
        {
            login.setCheckOut(Date())
            try loginDataLayer.updateLoginData(loginData : login)
        }
    }
    func isAvailableCheckOut(bookingId : Int) throws-> (Bool,RoomBooking?)
    {
        let bookings = try bookingDataLayer.getAllBookings().filter {$0.bookingIdProperty == bookingId  && $0.bookingStatusProperty == BookingStatus.checkin }
        if (bookings.isEmpty)
        {
            return (false,nil)
        }
        return (true,bookings.first!)
    }
}
