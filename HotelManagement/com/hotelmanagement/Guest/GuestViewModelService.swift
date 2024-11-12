protocol GuestViewModelService
{
    func isAvailablePhoneNo(phoneNo : Int64) -> Bool
    func createGuest (name : String, phoneNo : Int64 , address : String) -> Guest
    func createAuthendication(guestId: Int, username: String, password: String) -> GuestAuthentication
    func setGuestView(guestView: GuestViewService)
}

