import Foundation
struct Feedback : CustomStringConvertible
{
    static var  count = 1
    private let feedbackId    : Int
    private let date          : String
    private var rating        : Int
    private var comment       : String
    init (rating: Int, comment: String)
    {
        self.feedbackId = Feedback.count
        Feedback.count += 1
        self.date       = Validation.convertDateToString(date: Date())!
        self.rating     = rating
        self.comment    = comment
    }
    
    var description: String
    {
        return """
                   ------------------------------------------
                   FeedbackId    : \(feedbackId), 
                   Date          : \(date) , 
                   Rating        : \(rating),
                   Comment       : \(comment)
                  ------------------------------------------
               """
    }
}

