

protocol FeedbackViewService
{
    func  getInputFeedbackDetails(booking: RoomBooking)
    func displayFeedback(feedback: [Feedback])
}
