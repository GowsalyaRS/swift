import Foundation
class FeedbackViewModel : FeedbackViewModelService
{
    private weak var feedbackView  : FeedbackViewService?
    private var feedbackDataLayer   = FeedbackDataLayer.getInstance()
    func setFeedbackView(_ feedbackView: FeedbackViewService)
    {
        self.feedbackView  = feedbackView
    }
    func isAvailableFeedback(booking: RoomBooking) throws -> Bool
    {
        let feedback : [Feedback] = try feedbackDataLayer.getFeedback(bookingId : booking.bookingIdProperty)
        if feedback.isEmpty
        {
            return true
        }
        return false
    }
    func createFeedback(bookingId : Int , rating : Int , comment : String) throws -> Result<Feedback, DatabaseError>
    {
        let feedback : Feedback = Feedback(bookingId: bookingId, rating: rating, comment: comment)
        do
        {
            try  feedbackDataLayer.insertFeedback(feedback: feedback)
            return .success(feedback)
        }
        catch
        {
            return .failure(DatabaseError.insertFailed(msg: "Feedback insertion failed"))
        }
    }
    func getFeedback() throws -> [Feedback] 
    {
         return try feedbackDataLayer.getFeedback()
    }
}
