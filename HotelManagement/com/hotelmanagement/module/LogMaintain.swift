import Foundation
struct LogMaintain : CustomStringConvertible
{
    private let bookingId : Int
    private var checkIn   : Date
    {
        didSet { print("checkIn : \(String(describing: Validation.convertDateToString(formate: "dd-MM-yyyy HH:mm:ss a", date: Date())))  successfully") }
    }
    private var checkOut  : Date?
    {
        didSet { print("checkOut : \(String(describing: Validation.convertDateToString(formate: "dd-MM-yyyy HH:mm:ss a", date: Date())))  successfully") }
    }
    init (bookingId : Int, checkIn : Date, checkOut : Date)
    {
        self.bookingId = bookingId
        self.checkIn   = checkIn
        self.checkOut  = checkOut
    }
    init(bookingId : Int, checkIn : Date)
    {
        self.bookingId = bookingId
        self.checkIn   = checkIn
    }
    var bookingIdProperty : Int
    {
         return bookingId
    }
    var checkInProperty : Date
    {
        return checkIn
    }
    var checkOutProperty : Date?
    {
        return checkOut
    }
    mutating func setCheckOut(_ checkOut : Date)
    {
        self.checkOut = checkOut
    }
     var description : String
    {
        let checkIn = Validation.convertDateToString(formate:"dd-MM-yyyy hh:mm:ss  a",date: checkIn) ?? ""
        var checkout = "Checkout has not been completed yet"
        if checkOut != nil
        {
            checkout =  Validation.convertDateToString(formate:"dd-MM-yyyy hh:mm:ss a ",date: checkOut!) ?? ""
        }
        return "BookingId : \(bookingIdProperty) \nCheckIn  : \(checkIn) \nCheckOut : \(checkout) "
    }
}
