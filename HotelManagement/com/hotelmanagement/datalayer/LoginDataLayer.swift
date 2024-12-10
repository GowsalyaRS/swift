class LoginDataLayer
{
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
    public func getLoginData () throws -> [LogMaintain]
    {
        let  loginQuery = "select * from login"
        let logins = try DataAccess.executeQueryData(query: loginQuery)
        var logMaintains : [LogMaintain]  = []
        for  login in logins
        {
            let bookingId = login["bookingId"] as! Int
            let checkIndate = login["checkIn"] as! String
            if let checkIn = Validation.convertStringToDate(formate: "dd-MM-yyyy hh:mm:ss a", date:checkIndate)
            {
                var loginMaintain =  LogMaintain(bookingId : bookingId, checkIn : checkIn)
                if let checkOutdate = login["checkOut"] as? String,
                let checkOut = Validation.convertStringToDate(formate: "dd-MM-yyyy hh:mm:ss a", date: checkOutdate)
                {
                    loginMaintain.setCheckOut(checkOut)
                }
                logMaintains.append(loginMaintain)
            }
        }
        return logMaintains
    }
}
