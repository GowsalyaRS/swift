class GuestDataLayer
{
    func getGuestDetails(query : String) throws -> [Guest]
    {
        var guestsArray : [Guest] = []
        let guests = try DataAccess.executeQueryData(query: query )
        for guest in guests
        {
            let guestId = guest["guestId"] as! Int
            let name = guest["name"] as! String
            let address = guest["address"] as! String
            let roleId = guest["role_id"] as! Int
            if let roleType = GuestRole(rawValue: roleId), let phoneNo = Int64(guest["phoneNo"] as! String)
            {
                let guestDetails : Guest = Guest(guestId: guestId, name: name, phoneNo: phoneNo, address: address, role: roleType)
                guestsArray.append(guestDetails)
            }
            else
            {
               print("Invalid Role type")
            }
        }
        return guestsArray
    }
    func getGuest() throws -> [Guest]
    {
        let guestQuery = "SELECT * FROM guests"
        return try getGuestDetails(query: guestQuery)
    }
    func getAuthendicationData(query : String) throws -> [GuestAuthentication]
    {
        var guestAuthenticationArray : [GuestAuthentication] = []
        let guestAuthentications = try DataAccess.executeQueryData(query: query)
        for guestAuthentication in guestAuthentications
        {
            let guestId = guestAuthentication["guestId"] as! Int
            let username = guestAuthentication["username"] as! String
            let password = guestAuthentication["password"] as! String
            let guestAuthenticationDetails : GuestAuthentication = GuestAuthentication(guestId: guestId, username: username, password: password)
            guestAuthenticationArray.append(guestAuthenticationDetails)
        }
        return guestAuthenticationArray
    }
    func getAuthendicationData() throws -> [GuestAuthentication]
    {
        let guestAuthenticationQuery = "SELECT * FROM guest_authentication"
        return try getAuthendicationData(query : guestAuthenticationQuery)
    }
    func insertGuestData(guest: Guest)  throws
    {
        let guestInsertQuery = """
                                insert into guests values (\(guest.guestIdProperty), '\(guest.nameProperty)', \(guest.phoneNoProperty), '\(guest.addressProperty)', '\(guest.roleProperty.rawValue)')
                               """
        try DataAccess.insertRecord(query: guestInsertQuery)
    }
    func insertAuthendicationData(guestAuthentication : GuestAuthentication) throws
    {
          let guestAuthenticationInsertQuery = """
                                                insert into guest_authentication(guestId,username,password) values (\(guestAuthentication.guestIdProperty), '\(guestAuthentication.usernameProperty)', '\(guestAuthentication.passwordProperty)')
                                               """
        try  DataAccess.insertRecord(query: guestAuthenticationInsertQuery )
    }
    func updatePasswordData(guestAuthentication : GuestAuthentication) throws
    {
        let updateQuery = """
                          UPDATE guest_authentication 
                          SET password ='\(guestAuthentication.passwordProperty)' 
                          WHERE username ='\(guestAuthentication.usernameProperty)' 
                          AND guestId =\(guestAuthentication.guestIdProperty)
                          """
        try  DataAccess.insertRecord(query: updateQuery)
    }
    func getGuest(phoneNo : Int64) throws -> [Guest]
    {
        let phoneNoString = String(phoneNo)
        let query = "select * from guests where phoneNo = \(phoneNoString)"
        return try getGuestDetails(query: query)
    }
    func getGuest(username : String , password : String) throws -> [Guest]
    {
        let guestQuery = """
                          select * from guests  where guestId in ( select guestId  from guest_authentication where  username = '\(username)' and password = '\(password)')
                         """
        return try getGuestDetails(query: guestQuery)
    }
    func isAvailableUserName (username: String) throws -> Bool
    {
        let query = "select * from guest_authentication where username = '\(username)'"
        let authenticationData = try getAuthendicationData(query: query)
        if authenticationData.isEmpty
        {
            return true
        }
        return false
    }
}

