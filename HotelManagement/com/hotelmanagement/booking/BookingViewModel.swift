import Foundation
class BookingViewModel : BookingViewModelService
{
    private weak var bookingView : BookingViewService?
    private let hotel  =  HotelDataLayer.getInstance()
    func setBookingView(bookingView: BookingViewService)
    {
        self.bookingView = bookingView
    }
    func
    addedConfirmBooking (guest : Guest, roomNumber: Int, dates: [Date], noOfGuest: Int, stayingDays : Int) throws -> RoomBooking 
    {
        let booking : RoomBooking = RoomBooking(roomNumber: roomNumber, guestId: guest.guestIdProperty, noOfGuest: noOfGuest, roomBookingDate: dates,stayingDays: stayingDays)
        booking.bookingStatusProperty = .confirmed
        let startDate = Validation.convertDateToString(formate: "dd-MM-yyyy", date: dates.first!)
        let endDate   = Validation.convertDateToString(formate: "dd-MM-yyyy", date: dates.last!)
        let bookingDate = Validation.convertDateToString(formate:"dd-MM-yyyy hh-mm-ss a" , date:  booking.bookingDateProperty)
        let query = """
        INSERT INTO booking (
            bookingId,bookingDate,roomNumber,guestId,noOfGuest,stayingDays, bookingStartDate,bookingEndDate,bookingStatusId
        ) VALUES (
            \(booking.bookingIdProperty), 
            '\(bookingDate!)', 
            \(roomNumber), 
            \(guest.guestIdProperty), 
            \(noOfGuest), 
            \(stayingDays),
            '\(startDate!)', 
            '\(endDate!)',
             \(booking.bookingStatusProperty.rawValue)
        )
        """
        let _ =  try hotel.insertRecord(query: query)
        return booking
    }
    func isAvailableBookingHistory(guest: Guest, bookingStatus: BookingStatus) -> [RoomBooking]
    {
        let query = """
                    SELECT * 
                    FROM booking 
                    WHERE guestId = \(guest.guestIdProperty) 
                    AND bookingStatusId = \(bookingStatus.rawValue)
                    """
      
            return  try getRoomBookingDetails(query: query)
    }
    func getRoomBookingDetails(query: String) -> [RoomBooking]
    {
        var roomBookings: [RoomBooking] = []
        if let bookings = hotel.executeQueryData(query: query), !bookings.isEmpty
        {
            for booking in bookings
            {
                  let bookingId   = booking ["bookingId"] as! Int
                  let bookingDate = booking ["bookingDate"] as! String
                  let roomNumber  = booking ["roomNumber"] as! Int
                  let guestId     = booking ["guestId"] as! Int
                  let noOfGuest   = booking ["noOfGuest"] as! Int
                  let stayingDays = booking ["stayingDays"] as! Int
                  let startDate   = booking ["bookingStartDate"] as! String
                  let endDate     = booking ["bookingEndDate"] as! String
                  let bookingStatusId = booking ["bookingStatusId"] as! Int
                if  let startDates = Validation.convertStringToDate(formate: "dd-MM-yyyy", date:startDate),
                    let bookingDates = Validation.convertStringToDate(formate: "dd-MM-yyyy hh:mm:ss a", date:bookingDate),
                    let endDates = Validation.convertStringToDate(formate: "dd-MM-yyyy", date:endDate)
                  {
                     let bookingStatus = BookingStatus(rawValue: bookingStatusId)
                     var booking : [Date]   = []
                     booking.append(startDates)
                     booking.append(endDates)
                    let room = RoomBooking(bookingId: bookingId, bookingDate: bookingDates, roomNumber: roomNumber, guestId: guestId, noOfGuest: noOfGuest,roomBookingDate : booking , bookingStatus: bookingStatus!,stayingDays : stayingDays)
                     roomBookings.append(room)
                 }
            }
        }
        return roomBookings
    }

    func getRoomBookingDetails(bookingStatus : BookingStatus)
    {
        let query = """
                    select * from booking 
                    where bookingStatusId = \(bookingStatus.rawValue)
                    """
        bookingView?.displayBookingDetails(roomBookings: getRoomBookingDetails(query: query))
    }
    func getRoomBookingDetails()
    {
        let query = """
                      select * from booking 
                    """
        bookingView?.displayBookingDetails(roomBookings: getRoomBookingDetails(query: query))
    }
    func getValidBooking (guest: Guest) -> [RoomBooking]
    {
        let query = """
                     select * from  booking where
                     guestId = \(guest.guestIdProperty) and bookingStatusId = \(BookingStatus.confirmed.rawValue)
                    """
        return getRoomBookingDetails (query: query)
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
        let updateBookingStatus = """
                                   update booking set bookingStatusId = \(BookingStatus.cancelled.rawValue) 
                                   where bookingId = \(booking.bookingIdProperty)
                                  """
        hotel.insertRecord(query: updateBookingStatus)
        let date = Validation.convertDateToString(formate: "dd-MM-yyyy", date: Date())
        let insertCancelRecord = """
                                 insert into cancel_booking (bookingId,cancellationDate,cancellationReason)
                                 values (\(booking.bookingIdProperty),'\(date!)', '\(cancellationReason)');
                                 """
        hotel.insertRecord(query: insertCancelRecord)
        let paymentS  =  """
                          select payment_status_id from payment 
                          where bookingId = \(booking.bookingIdProperty) 
                          """
        if let payments =  hotel.executeQueryData(query: paymentS), let payment = payments.first
        {
             let payment_id =  payment["payment_status_id"] as! Int
             let PaymentStatusUpdate = PaymentStatus(rawValue: payment_id)
             print (PaymentStatusUpdate)
             let paymentId = (PaymentStatusUpdate == .Success) ? PaymentStatus.Refunded : PaymentStatus.No_Paid
             let updatePaymentStatus = """
                                        update payment
                                        set payment_status_id = \(paymentId.rawValue)
                                        where bookingId = \(booking.bookingIdProperty) 
                                        """
            hotel.executeQueryData(query:updatePaymentStatus )
        }
    }
    func checkBooking(bookingId: Int) -> (Bool,RoomBooking?)
    {
        let query = "select * from booking where bookingId = \(bookingId)"
        let bookings : [RoomBooking] =  getRoomBookingDetails(query: query)
        if (bookings.isEmpty)
        {
            return (false,nil)
        }
        return (true,bookings.first!)
    }
    func checkBooking(roomBooking : RoomBooking) -> Bool
    {
        if roomBooking.bookingStatusProperty == BookingStatus.confirmed  && roomBooking.roomBookingDateProperty.first! == Validation.convertDate(formate :"dd-MM-yyyy" ,date: Date())
        {
            return true
        }
        return false
    }
    func setCheckInDetails(booking : RoomBooking)
    {
        booking.bookingStatusProperty = BookingStatus.checkin
        let  bookingStatus =  "update booking set bookingStatusId = \(booking.bookingStatusProperty.rawValue) where bookingId = \(booking.bookingIdProperty)"
        hotel.executeQueryData(query: bookingStatus)
        let  roomNumber = "update hotel_rooms set available = \(0) where roomNumber = \(booking.roomNumberProperty)"
        hotel.executeQueryData(query: roomNumber)
        let currentDate = Validation.convertDateToString(formate:"dd-MM-yyyy hh:mm:ss a",date: Date())
        let log =  LogMaintain(bookingId : booking.bookingIdProperty , checkIn : Date())
        let addLog = "insert into login(bookingId,checkIn) values (\(booking.bookingIdProperty),'\(currentDate!)')"
        hotel.executeQueryData(query: addLog)
    }
    func setCheckoutDetails(booking : RoomBooking)
    {
        booking.bookingStatusProperty = BookingStatus.checkout
        let  bookingStatus =  "update booking set bookingStatusId = \(booking.bookingStatusProperty.rawValue) where bookingId = \(booking.bookingIdProperty)"
        hotel.executeQueryData(query: bookingStatus)
        let  roomNumber = "update hotel_rooms set available = \(1) where roomNumber = \(booking.roomNumberProperty)"
        hotel.executeQueryData(query: roomNumber)
        let currentDate = Validation.convertDateToString(formate:"dd-MM-yyyy hh:mm:ss a",date: Date())
        let addLog = "update login set checkOut = '\(currentDate!)' where bookingId =(\(booking.bookingIdProperty))"
        hotel.executeQueryData(query: addLog)
    }
    func isAvailableCheckOut(bookingId : Int) -> (Bool,RoomBooking?)
    {
        let query = "select * from booking where bookingId = \(bookingId) and bookingStatusId = \(BookingStatus.checkin.rawValue)"
        let bookings = getRoomBookingDetails (query: query)
        if (bookings.isEmpty)
        {
            return (false,nil)
        }
        return (true,bookings.first!)
    }
}
