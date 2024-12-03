protocol GuestViewModelService : AnyObject
{
    func isAvailablePhoneNo(phoneNo : Int64) throws-> Bool
    func getGuestDeatils() throws -> [Guest]
    func changePassword(phoneNo : Int64 , userName : String , password : String) throws
    func createGuest (name : String, phoneNo : Int64 , address : String) throws -> Guest
    func createAuthendication(guestId: Int, username: String, password: String) throws -> GuestAuthentication
}

