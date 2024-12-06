class FeedbackView : FeedbackViewService
{
    private  var feedbackViewModel  : FeedbackViewModelService
    init(feedbackViewModel: FeedbackViewModelService)
    {
        self.feedbackViewModel = feedbackViewModel
    }
    func  getInputFeedbackDetails(booking: RoomBooking) throws -> Result<Void,Error>
    {
        if( try feedbackViewModel.isAvailableFeedback(booking: booking) == false )
        {
            return .failure (DatabaseError.noRecordFound(msg :"Your added feedback already"))
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
                break
            }
        }
        print ("Enter the feedback :",terminator: "")
        let feedbackMsg = readLine()!
        let feedback = try feedbackViewModel.createFeedback(bookingId: booking.bookingIdProperty, rating: rating, comment: feedbackMsg)
        switch feedback
        {
           case .success (_):
                print ("Feedback added successfully")
                return .success(())
            case .failure (let error):
                throw error
        }
        
    }
    func displayFeedback(feedback: [Feedback])  throws
    {
        if feedback.isEmpty
        {
            throw DatabaseError.noRecordFound (msg : "No feedback available")
        }
        for feedback in feedback
        {
             print (feedback)
        }
    }
}
