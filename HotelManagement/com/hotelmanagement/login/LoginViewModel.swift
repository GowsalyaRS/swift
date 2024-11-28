public class LoginViewModel : LoginViewModelService
{
     private weak var  loginView : LoginViewService?
     private let  hotel  =  HotelDataLayer.getInstance()
     func setLoginView( loginView : LoginViewService)
     {
           self.loginView = loginView;
     }
     func checkValidation(name : String ,password : String)
     {
         if let result = hotel.executeQueryData(query: "SELECT guestId FROM guest_authentication WHERE username = '\(name)' AND password = '\(password)'"),
            let guestId = result.first?["guestId"] as? Int
            {
             if let guests = hotel.executeQueryData(query: "select * from guests where guestId = \(guestId)")
             {
                 let guestId = guests.first?["guestId"] as! Int
                 let name = guests.first?["name"] as! String
                 let address = guests.first?["address"] as! String
                 let roleId  = guests.first?["role_id"] as! Int
                 if let role = GuestRole(rawValue : roleId), let phoneno = Int64(guests.first?["phoneNo"] as! String)
                 {
                     let guest = Guest(guestId: guestId, name: name, phoneNo: Int64(phoneno), address: address, role: role)
                     if guest.roleProperty == GuestRole.Guest
                     {
                         loginView?.onGuestSuccess(guest: guest)
                     }
                     else
                     {
                         loginView?.onAdminSuccess(guest: guest)
                     }
                 }
             }
             else
             {
                 ValidInput.alert(msg: "Guest not found.")
             }
         }
         else
         {
            
             ValidInput.alert(msg: "Invalid Username or Password")
         }
     }
}
