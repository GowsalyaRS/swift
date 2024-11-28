import Foundation
struct Feedback : CustomStringConvertible
{
    private let bookingId    : Int
    private let date          : String
    private var rating        : Int
    private var comment       : String
    init (bookingId: Int,rating: Int, comment: String)
    {
        self.bookingId  = bookingId
        self.date       = Validation.convertDateToString(formate:"yyyy-MM-dd",date: Date())!
        self.rating     = rating
        self.comment    = comment.replacingOccurrences(of: "'", with: "")
    }
    var description: String
    {
        return """
                   ------------------------------------------
                   Booking Id    : \(bookingId), 
                   Date          : \(date) , 
                   Rating        : \(rating),
                   Comment       : \(comment)
                  ------------------------------------------
               """
    }
}

