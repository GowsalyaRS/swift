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
    private var bookingStatus    : BookingStatus = .pending
    {
        didSet
        {
            print(" Booking is  \(bookingStatus) " )
        }
    }
    init (roomNumber: Int, guestId: Int, noOfGuest: Int, roomBookingDate: [Date])
    {
        RoomBooking.count += 1
        bookingId       = RoomBooking.count
        bookingDate     = Date()
        self.roomNumber = roomNumber
        self.guestId    = guestId
        self.noOfGuest  = noOfGuest
        self.roomBookingDate = roomBookingDate
    }
    var roomBookingDateProperty: [Date]
    {
        return roomBookingDate
    }
    var roomNumberProperty: Int
    {
        return roomNumber
    }
    var bookingIdProperty: Int
    {
        return bookingId
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
        let startDate = Validation.convertDateToString(formate:"yyyy-MM-dd",date: roomBookingDate.first!) ?? ""
        let endDate   = Validation.convertDateToString(formate:"yyyy-MM-dd",date: roomBookingDate.last!) ?? ""
        return """
                --------------------------------------
                Booking Id        :  \(bookingId)
                Room Number       :  \(roomNumber)
                No of Guest       :  \(noOfGuest)
                Booking Date      : [\(startDate) - \(endDate)]
               """
    }
}


