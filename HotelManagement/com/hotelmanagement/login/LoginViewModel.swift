import Foundation
public class LoginViewModel : LoginViewModelService
{
     private weak var  loginView : LoginViewService?
     func setLoginView( loginView : LoginViewService)
     {
           self.loginView = loginView;
     }
     func checkValidation(name: String, password: String) throws
     {
         let guestViewModel = GuestViewModel()
         let guest = try guestViewModel.getGuest(username: name, password: password)
         switch guest
         {
             case .success (let guest):
             if guest.roleProperty == .Guest
             {
                 loginView?.onGuestSuccess(guest: guest)
             }
             else
             {
                 loginView?.onAdminSuccess(guest: guest)
             }
             break
             case .failure(let error):
             throw error
         }
    }
}
