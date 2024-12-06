protocol FeedbackViewService : AnyObject
{
    func getInputFeedbackDetails(booking: RoomBooking) throws -> Result<Void,Error>
    func displayFeedback(feedback: [Feedback]) throws
}
