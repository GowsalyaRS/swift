public class LoginViewModel : LoginViewModelService
{
     private weak var  loginView : LoginViewService?
     func setLoginView( loginView : LoginViewService)
     {
           self.loginView = loginView;
     }
     func checkValidation(name: String, password: String) throws
     {
         let guestDataLayer = GuestDataLayer.getInstance()
             if let guestId = try guestDataLayer.getAuthendicationData().first(where: { $0.usernameProperty == name && $0.passwordProperty == password })?.guestIdProperty
           {
                 if let guest = try guestDataLayer.getGuest().first(where: { $0.guestIdProperty == guestId })
                 {
                     if guest.roleProperty == .Guest
                     {
                         loginView?.onGuestSuccess(guest: guest)
                     }
                     else
                     {
                         loginView?.onAdminSuccess(guest: guest)
                     }
                 }
                 else
                 {
                     throw DatabaseError.noRecordFound(msg: "Guest not found")
                 }
             }
             else
             {
                 throw DatabaseError.executionFailed(msg: "Invalid Username or Password")
             }
      }
}
