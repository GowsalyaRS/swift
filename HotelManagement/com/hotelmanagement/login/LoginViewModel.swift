public class LoginViewModel : LoginViewModelService
{
     private weak var  loginView : LoginViewService?
     private let  hotel  =  HotelDataLayer.getInstance()
     func setLoginView( loginView : LoginViewService)
     {
           self.loginView = loginView;
     }
     func checkValidation(name: String, password: String) throws {

        guard let result = try? hotel.executeQueryData(query: "SELECT guestId FROM guest_authentication WHERE username = '\(name)' AND password = '\(password)'"),
              let guestId = result.first?["guestId"] as? Int else {
           print("Invalid username or password.")
            return
        }
        guard let guests = try? hotel.executeQueryData(query: "SELECT * FROM guests WHERE guestId = \(guestId)"), let guest = guests.first else {
            print ("Guest not found.")
            return
        }
        guard let guestId = guest["guestId"] as? Int,
              let name = guest["name"] as? String,
              let address = guest["address"] as? String,
              let roleId = guest["role_id"] as? Int else {
            print ("Guest not found.")
            return
        }
        if let role = GuestRole(rawValue: roleId)
        ,let phoneNoString = guest["phoneNo"] as? String, let phoneNo = Int64(phoneNoString)
        {
            let guestObject = Guest(guestId: guestId, name: name, phoneNo: phoneNo, address: address, role: role)
            if guestObject.roleProperty == .Guest
            {
                loginView?.onGuestSuccess(guest: guestObject)
            }
            else
            {
                loginView?.onAdminSuccess(guest: guestObject)
            }
        }
    }
}
