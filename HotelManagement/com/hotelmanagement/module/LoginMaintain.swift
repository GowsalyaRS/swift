import Foundation
struct LoginMaintain
{
    private let BookingId : String
    private var CheckIn   : Date
    private var CheckOut  : Date
    init(BookingId : String, CheckIn : Date, CheckOut : Date)
    {
        self.BookingId = BookingId
        self.CheckIn   = CheckIn
        self.CheckOut  = CheckOut   
    }
}
