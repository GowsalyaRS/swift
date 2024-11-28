protocol FeedbackViewModelService : AnyObject
{
    func isAvailableFeedback(booking: RoomBooking) -> Bool
    func isValidWriteFeedback(booking: RoomBooking) -> Bool
    func createFeedback(bookingId : Int , rating : Int , comment : String)
    func getFeedback() -> [Feedback]
}
