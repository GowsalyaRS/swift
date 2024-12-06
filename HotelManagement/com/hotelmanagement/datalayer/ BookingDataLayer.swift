import Foundation
class BookingDataLayer
{
    private static var bookingDataLayer :BookingDataLayer? = nil
    private init()
    {
    }
    public static func getInstance() -> BookingDataLayer
    {
        if bookingDataLayer == nil
        {
            bookingDataLayer = BookingDataLayer()
        }
        return bookingDataLayer!
    }
    func insertBookingData (booking : RoomBooking) throws
    {
        let dates = booking.roomBookingDateProperty
        let startDate = Validation.convertDateToString(formate: "dd-MM-yyyy", date: dates.first!)
        let endDate   = Validation.convertDateToString(formate: "dd-MM-yyyy", date: dates.last!)
        let bookingDate = Validation.convertDateToString(formate:"dd-MM-yyyy hh-mm-ss a" , date:  booking.bookingDateProperty)
        let inserBookingQuery = """
        INSERT INTO booking (
            bookingId,bookingDate,roomNumber,guestId,noOfGuest,stayingDays, bookingStartDate,bookingEndDate,bookingStatusId
        ) VALUES (
            \(booking.bookingIdProperty), 
            '\(bookingDate!)', 
            \(booking.roomNumberProperty), 
            \(booking.guestIdProperty), 
            \(booking.noOfGuestProperty), 
            \(booking.stayingDaysProperty),
            '\(startDate!)', 
            '\(endDate!)',
             \(booking.bookingStatusProperty.rawValue)
        )
        """
        try DataAccess.insertRecord(query: inserBookingQuery)
    }
    func getRoomBookingDetails(query: String) throws -> [RoomBooking]
    {
        var roomBookings: [RoomBooking] = []
        let bookings = try DataAccess.executeQueryData(query: query)
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
        return roomBookings
    }
    func getGuestBookings(guestId: Int) throws -> [RoomBooking]
    {
        let bookingStatusQuery = """
                                 SELECT * 
                                 FROM booking 
                                 WHERE guestId = \(guestId) 
                                 """
        return  try getRoomBookingDetails(query: bookingStatusQuery)
    }
    func getAllBookings() throws -> [RoomBooking]
    {
        return try getRoomBookingDetails(query: "select * from booking")
    }
    func getUpdateBookingStatus (booking : RoomBooking) throws -> Void
    {
        let updateBookingStatus = """
                                   update booking set bookingStatusId = \(booking.bookingStatusProperty.rawValue) 
                                   where bookingId = \(booking.bookingIdProperty)
                                  """
        try DataAccess.insertRecord(query: updateBookingStatus)
    }
    func insertCancelRoomRecord(roomCancellation: RoomCancellation , booking : RoomBooking) throws
    {
        let date = Validation.convertDateToString(formate: "dd-MM-yyyy", date: roomCancellation.cancellationDateproperty)
        let cancelRecord = """
                                 insert into cancel_booking (bookingId,cancellationDate,cancellationReason)
                                 values (\(booking.bookingIdProperty),'\(date!)', '\(roomCancellation.cancellationReasonproperty)');
                                 """
        try DataAccess.insertRecord(query: cancelRecord)
    }
    func getGuestStatusBookings(guestId: Int,bookingStatus : BookingStatus) throws -> [RoomBooking]
    {
        let bookingStatusQuery = """
                                 SELECT * 
                                 FROM booking 
                                 WHERE guestId = \(guestId)  and bookingStatusId = \(bookingStatus.rawValue)
                                 """
        return  try getRoomBookingDetails(query: bookingStatusQuery)
    }
    func getStatusBookings(bookingStatus : BookingStatus)  throws -> [RoomBooking]
    {
        let bookingStatusQuery = """
                                 SELECT * 
                                 FROM booking 
                                 WHERE bookingStatusId = \(bookingStatus.rawValue)
                                 """
        return  try getRoomBookingDetails(query: bookingStatusQuery)
    }
    func getBookingIdData (bookingId: Int) throws -> [RoomBooking]
    {
        let bookingStatusQuery = """
                                 SELECT * 
                                 FROM booking 
                                 WHERE  bookingId = \(bookingId)
                                 """
        return  try getRoomBookingDetails(query: bookingStatusQuery)
    }
    func getStatusBookings(bookingStatus:  BookingStatus, roomNumber : Int) throws -> [RoomBooking]
    {
        let bookingStatusQuery = """
                                 SELECT * 
                                 FROM booking 
                                 WHERE bookingStatusId = \(bookingStatus.rawValue)
                                 and roomNumber = \(roomNumber)
                                 """
        return  try getRoomBookingDetails(query: bookingStatusQuery)
    }
}




