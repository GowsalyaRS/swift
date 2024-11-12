protocol FeedbackViewModelService
{
    func setFeedbackView(_ feedbackView: FeedbackViewService)
    func isAvailableFeedback(booking: RoomBooking) -> Bool
    func isValidWriteFeedback(booking: RoomBooking) -> Bool
    func createFeedback(bookingId : Int , rating : Int , comment : String)
    func getFeedback() -> [Feedback]
}
