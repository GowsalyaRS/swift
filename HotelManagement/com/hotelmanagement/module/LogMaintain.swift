import Foundation
struct LogMaintain
{
    private let bookingId : Int
    private var checkIn   : String
    private var checkOut  : String
    {
        didSet { print("checkOut : \(checkOut)  successfully") }
    }
    init (bookingId : Int, checkIn : String, checkOut : String)
    {
        self.bookingId = bookingId
        self.checkIn   = checkIn
        self.checkOut  = checkOut
    }
    init(bookingId : Int, checkIn : String)
    {
        self.init(bookingId: bookingId, checkIn: checkIn , checkOut: "")
        print("checkIn : \(checkIn)  successfully")
    }
    mutating func setCheckOut(_ checkOut : String)
    {
        self.checkOut = checkOut
    }
}
