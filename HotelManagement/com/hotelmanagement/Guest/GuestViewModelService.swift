protocol GuestViewModelService : AnyObject
{
    func isAvailablePhoneNo(phoneNo : Int64) throws-> Bool
    func changePassword(phoneNo : Int64 , userName : String , password : String) throws -> Result <Void,DatabaseError>
    func createGuest (name : String, phoneNo : Int64 , address : String) throws  -> Result <Guest,DatabaseError>
    func createAuthendication(guestId: Int, username: String, password: String) throws -> Result <GuestAuthentication,DatabaseError>
}

