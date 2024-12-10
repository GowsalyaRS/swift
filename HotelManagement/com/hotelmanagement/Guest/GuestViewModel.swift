class GuestViewModel : GuestViewModelService
{
    private weak var guestView : GuestViewService?
    private let guestDataLayer = GuestDataLayer()
    func setGuestView(guestView: GuestViewService)
    {
        self.guestView = guestView
    }
    func createGuest (name : String, phoneNo : Int64 , address : String) throws -> Result  <Guest,DatabaseError>
    {
        let guest = Guest(name: name, phoneNo: phoneNo, address: address)
        do
        {
            try guestDataLayer.insertGuestData(guest: guest)
        }
        catch
        {
            return .failure( DatabaseError.insertFailed(msg: "Guest data add failed"))
        }
        return .success(guest)
    }
    func isAvailablePhoneNo(phoneNo : Int64) throws -> Bool
    {
        let guests = try guestDataLayer.getGuest(phoneNo : phoneNo)
        if guests.isEmpty
        {
            return false
        }
        return true
    }
    func createAuthendication(guestId: Int, username: String, password: String) throws ->  Result <GuestAuthentication,DatabaseError>
    {
        let guestAuthentication : GuestAuthentication = GuestAuthentication(guestId: guestId, username: username, password: password)
        do
        {
            try guestDataLayer.insertAuthendicationData(guestAuthentication : guestAuthentication)
        }
        catch
        {
            return .failure( DatabaseError.insertFailed(msg: "Guest Authendications  data add failed"))
        }
        return  .success(guestAuthentication)
    }
    func changePassword(phoneNo : Int64 , userName : String , password : String) throws -> Result<Void,DatabaseError>
    {
        let guestsArray : [Guest] = try guestDataLayer.getGuest(phoneNo : phoneNo)
        if guestsArray.isEmpty
        {
            throw DatabaseError.noRecordFound(msg : "Phone number is not found")
        }
        let guest = guestsArray.first
        let guestId = guest!.guestIdProperty
        let guestAuthentication : GuestAuthentication = GuestAuthentication(guestId: guestId, username: userName, password: password)
       do
       {
           try guestDataLayer.updatePasswordData(guestAuthentication : guestAuthentication)
       }
       catch
       {
           return .failure(DatabaseError.updateFailed( msg : "No Change  paswword  your details is wrong "))
       }
        return .success(())
    }
    func getGuestData() throws -> [Guest]
    {
        return try guestDataLayer.getGuest()
    }
    func getGuest(username : String , password : String) throws  -> Result<Guest, DatabaseError>
    {
        let guest = try guestDataLayer.getGuest(username : username , password : password)
        if guest.isEmpty
        {
            throw DatabaseError.noRecordFound(msg : "Username or password is wrong")
        }
        return .success(guest.first!)
    }
    func isAvailableUserName (username: String) throws -> Bool
    {
        return  try guestDataLayer.isAvailableUserName (username: username)
    }
}
 
