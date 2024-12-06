protocol FeedbackViewModelService : AnyObject
{
    func isAvailableFeedback(booking: RoomBooking) throws -> Bool
    func createFeedback(bookingId : Int , rating : Int , comment : String) throws -> Result<Feedback, DatabaseError>
    func getFeedback() throws -> [Feedback] 
}
