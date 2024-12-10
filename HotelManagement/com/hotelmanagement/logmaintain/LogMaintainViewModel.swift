import Foundation
class LogMaintainViewModel : LogViewModelService
{
    private var logMaintainView: LogViewService?
    private let  loginDataLayer = LoginDataLayer()
    func setLogView(logMaintainView: LogViewService)
    {
        self.logMaintainView = logMaintainView
    }
    func addLoginData(booking : RoomBooking) throws
    {
        let login =  LogMaintain(bookingId : booking.bookingIdProperty , checkIn : Validation.convertDate(formate: "dd-MM-yyyy  hh:mm:ss a", date: Date())!)
        try loginDataLayer.insertLoginData(loginData : login)
    }
    func getLoginData(bookingId : Int) throws -> LogMaintain?
    {
        return try loginDataLayer.getLoginData(bookingId : bookingId)
    }
    func updateCheckOutDate(login : LogMaintain) throws
    {
        var login = login
        login.setCheckOut(Validation.convertDate(formate: "dd-MM-yyyy hh:mm:ss a", date: Date())!)
        try loginDataLayer.updateLoginData(loginData : login)
    }
    func getLogDetails() throws -> [LogMaintain]
    {
       return try loginDataLayer.getLoginData()
    }
}

