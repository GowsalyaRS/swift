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
         if let guestId = hotel.authendicationsProperty.first(where: { $0.getUsername() == name && $0.getPassword() == password })?.getGuestId()
         {
               if let guest = hotel.guestProperty.first(where: { $0.value.guestIdProperty == guestId })?.value
                {
                   if (guest.roleProperty == .Guest)
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
             ValidInput.alert(msg: "Invalid Username or Password")
         }
     }
}
