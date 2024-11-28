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
        let feedback =  hotel.getFeedback(bookingId: booking.bookingIdProperty)
        if feedback == nil
        {
            return true
        }
        return false
    }
    func isValidWriteFeedback(booking: RoomBooking) -> Bool
    {
        if booking.bookingStatusProperty == .checkout
        {
            return true
        }
        return false
    }
    func createFeedback(bookingId : Int , rating : Int , comment : String)
    {
        let feedback : Feedback = Feedback(bookingId : bookingId ,rating: rating, comment: comment)
        hotel.addFeedback(bookingId: bookingId, feedback: feedback)
    }
    func getFeedback() -> [Feedback]
    {
        return hotel.getAllFeedback()
    }
}
