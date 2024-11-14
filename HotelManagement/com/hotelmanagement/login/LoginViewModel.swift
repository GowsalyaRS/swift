public class LoginViewModel : LoginViewModelService
{
     private unowned var  loginView : LoginViewService?
     private  let  hotel  =  HotelDataLayer.getInstance()
     func setLoginView( loginView : LoginViewService)
     {
           self.loginView = loginView;
     }
     func checkValidation(name : String? ,password : String?)
     {
         if (name != nil && name == "zoho")
         {
             if(password != nil && password == "123")
             {
                 ValidInput.alert(msg : " Admin Login Success")
                 loginView?.onAdminSuccess()
             }
             else
             {
                 ValidInput.alert (msg : "Invalid Password")
             }
         }
         else
         {
             checkGuestValidation(name: name, password: password)
         }
     }
     func checkGuestValidation(name : String? ,password : String?)
     {
        let guests = hotel.getGuests()
        for guest in guests.values
        {
            let authendication = hotel.getAuthendication(guestId: guest.guestIdProperty)
            if ((authendication?.getUsername()) == name)
            {
                if ((authendication?.getPassword()) == password)
                {
                    ValidInput.alert(msg : "Guest Login Success")
                    loginView?.onGuestSuccess(guest : guest)
                    return
                }
                else
                {
                    ValidInput.alert (msg : "Invalid Password")
                }
            }
        }
        ValidInput.alert (msg : "Invalid Username")
     }
}
