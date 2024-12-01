import Foundation
class FeedbackViewModel : FeedbackViewModelService
{
    private weak var feedbackView  : FeedbackViewService?
    private var hotel = HotelDataLayer.getInstance()
    func setFeedbackView(_ feedbackView: FeedbackViewService)
    {
        self.feedbackView  = feedbackView
    }
    func isAvailableFeedback(booking: RoomBooking) -> Bool
    {
        let query =  """
                      select * from feedback
                      where bookingId = \(booking.bookingIdProperty)
                     """
        let feedback = hotel.executeQueryData(query: query)
        if ((feedback?.isEmpty) != nil)
        {
            return true
        }
        return false
    }
    func isValidWriteFeedback(booking: RoomBooking) -> Bool
    {
        let query = """
                     select * from 
                     where bookingStatusId = \(BookingStatus.checkout.rawValue)
                    """
        let feedback = hotel.executeQueryData(query: query)
        if !(feedback?.isEmpty == nil)
        {
            return true
        }
        return false
    }
    func createFeedback(bookingId : Int , rating : Int , comment : String)
    {
        let query = """
            INSERT INTO feedback (bookingId, feedbackDate, comment)
            VALUES (\(bookingId), '\(Validation.convertDateToString(formate:"dd-MM-yyyy hh:mm:ss a", date: Date()))', '\(comment)');
        """
        hotel.executeQueryData(query: query)
    }
    func getFeedback() -> [Feedback]
    {
        let query = """
                     select * from feedback
                    """
        var feedbackArray : [Feedback] = []
        if let feedbacks = hotel.executeQueryData(query: query)
        {
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
        }
        return feedbackArray
    }
}
