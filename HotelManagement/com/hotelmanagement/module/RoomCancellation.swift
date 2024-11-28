import Foundation
struct RoomCancellation
{
    let bookingId          : Int
    let cancellationDate   : Date
    var cancellationReason : String
    init(bookingId: Int, cancellationReason: String)
    {
        self.bookingId          = bookingId
        self.cancellationDate   = Date()
        self.cancellationReason = cancellationReason
    }
}

