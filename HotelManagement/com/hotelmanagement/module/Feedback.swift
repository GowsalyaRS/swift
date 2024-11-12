import Foundation
struct Feedback
{
    static var  count = 1
    let feedbackId    : Int
    let date          : Date
    var rating        : Int
    var comment       : String
    init (rating: Int, comment: String)
    {
        self.feedbackId = Feedback.count
        Feedback.count += 1
        self.date       = Date()
        self.rating     = rating
        self.comment    = comment
    }
}

