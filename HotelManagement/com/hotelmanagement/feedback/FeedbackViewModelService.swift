protocol FeedbackViewModelService : AnyObject
{
    func isAvailableFeedback(booking: RoomBooking) throws -> Bool
    func createFeedback(bookingId : Int , rating : Int , comment : String) throws
    func getFeedback() throws -> [Feedback]
}
