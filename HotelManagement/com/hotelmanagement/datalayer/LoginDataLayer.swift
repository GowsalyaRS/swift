class LoginDataLayer
{
    private static var loginDataLayer : LoginDataLayer? = nil
    private init()
    {
    }
    public static func getInstance() -> LoginDataLayer
    {
        if loginDataLayer == nil
        {
            loginDataLayer = LoginDataLayer()
        }
        return loginDataLayer!
    }
    public func insertLoginData(loginData: LogMaintain) throws
    {
        let currentDate = Validation.convertDateToString(formate:"dd-MM-yyyy hh:mm:ss a",date: loginData.checkInProperty)
        let addLog = "insert into login(bookingId,checkIn) values       (\(loginData.bookingIdProperty),'\(currentDate!)')"
        try DataAccess.insertRecord(query: addLog)
    }
    public func updateLoginData(loginData: LogMaintain) throws
    {
        let currentDate = Validation.convertDateToString(formate:"dd-MM-yyyy hh:mm:ss a",date: loginData.checkOutProperty!)
        let updateLog = "update login set checkOut = '\(currentDate!)' where bookingId = \(loginData.bookingIdProperty)"
        try DataAccess.insertRecord(query: updateLog)
    }
    public func  getLoginData (bookingId: Int) throws -> LogMaintain?
    {
        let  loginQuery = "select * from login where bookingId = \(bookingId)"
        let logins = try DataAccess.executeQueryData(query: loginQuery)
        if  let  login = logins.first
        {
            let bookingId = login["bookingId"] as! Int
            let checkIndate = login["checkIn"] as! String
             if let checkIn = Validation.convertStringToDate(formate: "dd-MM-yyyy hh:mm:ss a", date:checkIndate)
            {
                 let loginMaintain =  LogMaintain(bookingId : bookingId, checkIn : checkIn)
                 return loginMaintain
            }
        }
        return nil
    }
}
