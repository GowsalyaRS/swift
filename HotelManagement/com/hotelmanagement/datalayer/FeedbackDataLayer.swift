class FeedbackDataLayer
{
    private static var  feedbackDataLayer : FeedbackDataLayer? = nil
    private init()
    {
    }
    public static func getInstance() -> FeedbackDataLayer
    {
        if feedbackDataLayer  == nil
        {
            feedbackDataLayer = FeedbackDataLayer()
        }
        return feedbackDataLayer!
    }
    func getFeedback() throws -> [Feedback]
    {
        let selectfeedbackQuery = """
                                  select * from feedback
                                  """
        var feedbackArray : [Feedback] = []
        let feedbacks = try  DataAccess.executeQueryData(query: selectfeedbackQuery)
        for feedback in feedbacks
        {
            let bookingId = feedback["bookingId"] as! Int
            let feedbackDate = feedback["date"] as! String
            let rating = feedback["rating"] as! Int
            let comment = feedback["comment"] as! String
            if let feedbackDate = Validation.convertStringToDate(formate:"dd-MM-yyyy hh:mm:ss a", date: feedbackDate)
            {
                feedbackArray.append(Feedback(bookingId: bookingId,date : feedbackDate ,rating: rating,comment: comment))
            }
        }
        return feedbackArray
    }
    func insertFeedback(feedback: Feedback) throws
    {
        let date = Validation.convertDateToString(formate:"dd-MM-yyyy hh:mm:ss a", date: feedback.dateProperty)
        let insertfeedbackQuery = """
                                  INSERT INTO feedback (bookingId, date, rating, comment)
                                  VALUES (\(feedback.bookingIdProperty), '\(date!)', \(feedback.ratingProperty), '\(feedback.commentProperty)');
                                  """
        try DataAccess.insertRecord(query: insertfeedbackQuery)
    }
}
