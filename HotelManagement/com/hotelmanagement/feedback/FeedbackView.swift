class FeedbackView : FeedbackViewService
{
    private var feedbackViewModel  : FeedbackViewModelService
    
    init(feedbackViewModel: FeedbackViewModelService)
    {
        self.feedbackViewModel = feedbackViewModel
    }
    
    func  getInputFeedbackDetails(booking: RoomBooking)
    {
       
        if(feedbackViewModel.isAvailableFeedback(booking: booking) == false )
        {
            print ("Your added feedback already")
            return
        }
        if (feedbackViewModel.isValidWriteFeedback(booking: booking) == false)
        {
           print ("feedback only writing stayed people")
           return
        }
        var rating  = 0
        while(true)
        {
            print ("Enter the rating (1-5)")
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
        print ("Enter the feedback ")
        let feedback = readLine()!
        feedbackViewModel.createFeedback(bookingId: booking.bookingIdProperty, rating: rating, comment: feedback)
        print (" Feedback added successfully ")
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
