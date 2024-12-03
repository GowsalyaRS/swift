protocol FeedbackViewService : AnyObject
{
    func getInputFeedbackDetails(booking: RoomBooking) throws
    func displayFeedback(feedback: [Feedback])
}
