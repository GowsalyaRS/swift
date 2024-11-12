class GuestViewModel : GuestViewModelService
{
    private var guestView : GuestViewService?
    private let hotel = HotelDataLayer.getInstance()
    
    func setGuestView(guestView: GuestViewService)
    {
        self.guestView = guestView
    }
    
    func createGuest (name : String, phoneNo : Int64 , address : String) -> Guest
    {
        let guest = Guest(name: name, phoneNo: phoneNo, address: address)
        hotel.addGuest(guest : guest)
        return guest
    }
    
    func isAvailablePhoneNo(phoneNo : Int64) -> Bool
    {
         for guest in hotel.getGuests()
         {
             if guest.key == phoneNo
             {
                 return false
             }
         }
        return true
    }
    
    func createAuthendication(guestId: Int, username: String, password: String) -> GuestAuthentication
    {
        let guestAuthentication : GuestAuthentication = GuestAuthentication(guestId: guestId, username: username, password: password)
        hotel.setAuthendication(guestAuthentication :  guestAuthentication);
        return guestAuthentication
    }
    
    func  isValidAuthentication(authedication : GuestAuthentication ,username : String , password : String ) -> Bool
    {
        if authedication.getUsername() == username
        {
            if authedication.getPassword() == Validation.hashPassword(password: password)
            {
                ValidInput.alert(msg: "Login Successfully" )
                return true
            }
            else
            {
                ValidInput.alert(msg: "Invalid Password" )
                return false
            }
        }
        else
        {
            ValidInput.alert(msg: "Invalid Username" )
            return false
        }
    }
}
