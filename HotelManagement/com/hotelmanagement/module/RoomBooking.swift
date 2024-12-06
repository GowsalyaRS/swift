import Foundation
class RoomBooking :  CustomStringConvertible
{
    private static var count    = 10001
    private var bookingId        : Int
    private var bookingDate      : Date
    private  let roomNumber      : Int
    private  let guestId         : Int
    private var noOfGuest        : Int
    private let roomBookingDate  : [Date]
    private let stayingDays      : Int
    private var bookingStatus    : BookingStatus = .pending
    {
        didSet
        {
            print(" Booking is  \(bookingStatus) " )
        }
    }
    init (roomNumber: Int, guestId: Int, noOfGuest: Int, roomBookingDate: [Date],stayingDays : Int)
    {
        RoomBooking.count    += 1
        bookingId             = RoomBooking.count
        bookingDate           = Date()
        self.roomNumber       = roomNumber
        self.guestId          = guestId
        self.noOfGuest        = noOfGuest
        self.roomBookingDate  = roomBookingDate
        self.stayingDays      = stayingDays
    }
    init (bookingId : Int,bookingDate :Date,roomNumber: Int,guestId: Int,noOfGuest: Int,roomBookingDate: [Date],bookingStatus: BookingStatus,stayingDays : Int)
    {
        self.bookingId       = bookingId
        self.bookingDate     = bookingDate
        self.roomNumber      = roomNumber
        self.guestId         = guestId
        self.noOfGuest       = noOfGuest
        self.roomBookingDate = roomBookingDate
        self.bookingStatus   = bookingStatus
        self.stayingDays     = stayingDays
    }
    var bookingIdProperty: Int
    {
        return bookingId
    }
    var roomBookingDateProperty: [Date]
    {
        return roomBookingDate
    }
    var bookingDateProperty: Date
    {
        return bookingDate
    }
    var roomNumberProperty: Int
    {
        return roomNumber
    }
    var guestIdProperty: Int
    {
        return guestId
    }
    var noOfGuestProperty: Int
    {
        return noOfGuest
    }
    var stayingDaysProperty: Int
    {
        return stayingDays
    }
    var bookingStatusProperty: BookingStatus
    {
        get { return bookingStatus }
        set { bookingStatus = newValue }
    }
    static var countProperty: Int
    {
        get { return count }
        set { count = newValue }
    }
    var description: String
    {
        let bookingDate = Validation.convertDateToString(formate:"dd-MM-yyyy hh:mm:ss a",date: bookingDate) ?? ""
        let startDate = Validation.convertDateToString(formate:"dd-MM-yyyy",date: roomBookingDate.first!) ?? ""
        let endDate   = Validation.convertDateToString(formate:"dd-MM-yyyy",date: roomBookingDate.last!) ?? ""
        return """
                ---------------------------------------------------------
                Booking Id             :  \(bookingId)
                Booking Date           :  \(bookingDate)
                Room Number            :  \(roomNumber)
                No of Guest            :  \(noOfGuest)
                Room Booking Date      :  [\(startDate) - \(endDate)]
               """
    }
}


