class FeedbackDataLayer
{
    func getFeedbackDetails(query : String) throws -> [Feedback]
    {
        var feedbackArray : [Feedback] = []
        let feedbacks = try  DataAccess.executeQueryData(query: query)
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
    func getFeedback() throws -> [Feedback]
    {
        let selectfeedbackQuery = """
                                  select * from feedback
                                  """
        return  try getFeedbackDetails(query: selectfeedbackQuery)
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
    func getFeedback(bookingId : Int) throws -> [Feedback]
    {
        let feedbackQuery = """
                              select * from feedback 
                              where bookingId = \(bookingId)
                            """
        return  try getFeedbackDetails(query: feedbackQuery)
    }
}
