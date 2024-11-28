protocol FeedbackViewService : AnyObject
{
    func  getInputFeedbackDetails(booking: RoomBooking)
    func displayFeedback(feedback: [Feedback])
}
