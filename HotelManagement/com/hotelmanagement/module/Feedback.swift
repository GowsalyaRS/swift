import Foundation
struct Feedback : CustomStringConvertible
{
    private let bookingId    : Int
    private let date          : Date
    private var rating        : Int
    private var comment       : String
    init (bookingId: Int,rating: Int, comment: String)
    {
        self.bookingId  = bookingId
        self.date       = Validation.convertDate(formate: "dd-MM-yyyy hh:mm:ss a", date: Date())!
        self.rating     = rating
        self.comment    = comment.replacingOccurrences(of: "'", with: "")
    }
    init (bookingId: Int,date : Date ,rating: Int,comment: String)
    {
        self.bookingId  = bookingId
        self.date       = date
        self.rating     = rating
        self.comment    = comment.replacingOccurrences(of: "'", with: "")
    }
    var description: String
    {
        let feedbackDate = Validation.convertDateToString(formate: "dd-MM-yyyy hh:mm:ss a", date: date)!
        return """
                   -----------------------------------------
                     Booking Id    : \(bookingId), 
                     Date          : \(feedbackDate), 
                     Rating        : \(rating),
                     Comment       : \(comment)
                  ------------------------------------------
               """
    }
}

