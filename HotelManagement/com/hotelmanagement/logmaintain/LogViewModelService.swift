protocol LogViewModelService
{
    func addLoginData(booking : RoomBooking) throws
    func getLoginData(bookingId : Int) throws -> LogMaintain?
    func updateCheckOutDate(login : LogMaintain) throws
}
