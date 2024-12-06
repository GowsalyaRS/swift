import Foundation
struct RoomCancellation
{
    private let bookingId          : Int
    private let cancellationDate   : Date
    private var cancellationReason : String
    init(bookingId: Int, cancellationReason: String)
    {
        self.bookingId          = bookingId
        self.cancellationDate   = Date()
        self.cancellationReason = cancellationReason
    }
    var bookingIdproperty         : Int { return bookingId }
    var cancellationDateproperty  : Date { return cancellationDate }
    var cancellationReasonproperty: String { return cancellationReason }
}

