class FeedbackView : FeedbackViewService
{
    private  var feedbackViewModel  : FeedbackViewModelService
    init(feedbackViewModel: FeedbackViewModelService)
    {
        self.feedbackViewModel = feedbackViewModel
    }
    func  getInputFeedbackDetails(booking: RoomBooking) throws
    {
        if( try feedbackViewModel.isAvailableFeedback(booking: booking) == false )
        {
            throw Result.failure (msg :"Your added feedback already")
        }
        var rating  = 0
        while(true)
        {
            print ("Enter the rating (1-5) : " ,terminator: "")
            if let input = readLine(), let rate = Int(input)
            {
                if (rate >= 1 && rate <= 5)
                {
                    rating = rate
                    break
                }
            }
            else
            {
                print ("Enter the valid rating")
                return
            }
        }
        print ("Enter the feedback :",terminator: "")
        let feedback = readLine()!
        try feedbackViewModel.createFeedback(bookingId: booking.bookingIdProperty, rating: rating, comment: feedback)
    }
    func displayFeedback(feedback: [Feedback])
    {
        if feedback.isEmpty
        {
            print ("No feedback available")
            return
        }
        for feedback in feedback
        {
             print (feedback)
        }
    }
}
