class GuestViewModel : GuestViewModelService
{
    private weak var guestView : GuestViewService?
    private let hotel = HotelDataLayer.getInstance()
    func setGuestView(guestView: GuestViewService)
    {
        self.guestView = guestView
    }
    func createGuest (name : String, phoneNo : Int64 , address : String) throws -> Guest
    {
        let guest = Guest(name: name, phoneNo: phoneNo, address: address)
        try hotel.insertRecord(query: "insert into guests values (\(guest.guestIdProperty), '\(guest.nameProperty)', \(guest.phoneNoProperty), '\(guest.addressProperty)', '\(guest.roleProperty.rawValue) ')")
        return guest
    }
    func isAvailablePhoneNo(phoneNo : Int64) throws -> Bool
    {
       let validPhoneNo  = try hotel.executeQueryData(query: "select * from guests where phoneNo = \(phoneNo)")
        return (validPhoneNo.isEmpty)
    }
    func createAuthendication(guestId: Int, username: String, password: String) throws -> GuestAuthentication
    {
        let guestAuthentication : GuestAuthentication = GuestAuthentication(guestId: guestId, username: username, password: password)
        try  hotel.insertRecord(query: "insert into guest_authentication(guestId,username,password) values (\(guestAuthentication.guestIdProperty), '\(guestAuthentication.usernameProperty)', '\(guestAuthentication.passwordProperty)')" )
        return guestAuthentication
    }
    func getGuestDeatils() throws -> [Guest]
    {
        let guestsArray : [Guest] = try getGuestDeatils(query : "select * from guests" )
        return guestsArray
    }
    func getGuestDeatils(query : String) throws -> [Guest]
    {
        var guestsArray : [Guest] = []
        let guests = try hotel.executeQueryData(query: query)
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
    func changePassword(phoneNo : Int64 , userName : String , password : String) throws
    {
        let phoneNoString = String(phoneNo)
        let query  = """
                     SELECT * FROM guests WHERE phoneNo = '\(phoneNoString)'
                     """
        let guestsArray : [Guest] = try getGuestDeatils(query :query)
        let guest = guestsArray.first
        let guestId = guest!.guestIdProperty
        print ("GuestId",guestId)
        let updateQuery = """
                          UPDATE guest_authentication 
                          SET password ='\(password)' 
                          WHERE username ='\(userName)' 
                          AND guestId =\(guestId)
                          """
       do
       {
            try hotel.insertRecord(query: updateQuery)
       }
       catch
       {
            throw Result.failure(msg : "No Change  paswword  your details is wrong ")
       }
       print( "Change Password Successfully")
    }
}
 
