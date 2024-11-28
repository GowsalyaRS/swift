class GuestViewModel : GuestViewModelService
{
    private weak var guestView : GuestViewService?
    private let hotel = HotelDataLayer.getInstance()
    func setGuestView(guestView: GuestViewService)
    {
        self.guestView = guestView
    }
    func createGuest (name : String, phoneNo : Int64 , address : String) -> Guest
    {
        let guest = Guest(name: name, phoneNo: phoneNo, address: address)
        let _  = hotel.insertRecord(query: "insert into guests values (\(guest.guestIdProperty), '\(guest.nameProperty)', \(guest.phoneNoProperty), '\(guest.addressProperty)', '\(guest.roleProperty.rawValue) ')")
        return guest
    }
    func isAvailablePhoneNo(phoneNo : Int64) -> Bool
    {
       let validPhoneNo  = hotel.executeQueryData(query: "select * from guests where phoneNo = \(phoneNo)")
        return ((validPhoneNo?.isEmpty) ?? false)
    }
    func createAuthendication(guestId: Int, username: String, password: String) -> GuestAuthentication
    {
        let guestAuthentication : GuestAuthentication = GuestAuthentication(guestId: guestId, username: username, password: password)
        let _ =  hotel.insertRecord(query: "insert into guest_authentication(guestId,username,password) values (\(guestAuthentication.guestIdProperty), '\(guestAuthentication.usernameProperty)', '\(guestAuthentication.passwordProperty)')" )
        return guestAuthentication
    }
    func getGuestDeatils() -> [Guest]
    {
        let guests =  hotel.executeQueryData(query: "select * from guests")
        if   guests!.isEmpty
        {
            return []
        }
        var guestsArray : [Guest] = []
        for guest in guests!
        {
            let guestId = guest["guestId"] as! Int
            let name = guest["name"] as! String
            let address = guest["address"] as! String
            let roleId = guest["role_id"] as! Int
            if let roleType = GuestRole(rawValue: roleId), let phoneNo  = Int64(guest["phoneNo"] as! String)
            {
                let guestDetails : Guest = Guest(guestId: guestId, name: name, phoneNo: phoneNo, address: address, role: roleType)
                guestsArray.append(guestDetails)
            }
            else
            {
                print("Invalid role type")
            }
        }
        return guestsArray
    }
}
