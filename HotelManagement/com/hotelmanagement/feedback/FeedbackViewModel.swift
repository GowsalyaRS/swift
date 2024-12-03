import Foundation
class FeedbackViewModel : FeedbackViewModelService
{
    private weak var feedbackView  : FeedbackViewService?
    private var hotel = HotelDataLayer.getInstance()
    func setFeedbackView(_ feedbackView: FeedbackViewService)
    {
        self.feedbackView  = feedbackView
    }
    func isAvailableFeedback(booking: RoomBooking) throws -> Bool
    {
        let feedbackQuery =  """
                      select * from feedback
                      where bookingId = \(booking.bookingIdProperty)
                     """
       
        if  try hotel.executeQueryData(query: feedbackQuery).isEmpty
        {
            return true
        }
       return false
    }
    func createFeedback(bookingId : Int , rating : Int , comment : String) throws
    {
        let date = Validation.convertDateToString(formate:"dd-MM-yyyy hh:mm:ss a", date: Date())
        let insertfeedbackQuery = """
                     INSERT INTO feedback (bookingId, date, rating, comment)
                     VALUES (\(bookingId), '\(date!)', \(rating), '\(comment)');
                    """
        do
        {
            try hotel.insertRecord(query: insertfeedbackQuery)
            print ("Feedback Added Successfully")
        }
        catch
        {
            throw Result.success(msg: "No Added Feedback")
        }
    }
    func getFeedback() throws -> [Feedback]
    {
        let selectfeedbackQuery = """
                     select * from feedback
                    """
        var feedbackArray : [Feedback] = []
         let feedbacks = try hotel.executeQueryData(query: selectfeedbackQuery)
        
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
}
