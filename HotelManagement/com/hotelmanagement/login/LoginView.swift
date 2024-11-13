public class LoginView : LoginViewService
{
    private weak  var  loginViewModel : LoginViewModelService?
    
     init( loginViewModel : LoginViewModelService)
     {
           self.loginViewModel = loginViewModel;
     }
     func getLoginData()
     {
         print("Enter the username : ", terminator: "")
         let name : String = readLine()!
         print("Enter the password : ", terminator: "")
         let password : String = readLine()!
         loginViewModel?.checkValidation(name: name, password: password)
     }
    func onAdminSuccess()
    {
        let adminProcess : AdminProcess = AdminProcess()
        adminProcess.adminInit()
    }
    func onGuestSuccess( guest : Guest)
    {
        let hotelProcess : HotelProcess = HotelProcess()
        hotelProcess.guestSigninProcess(guest : guest)
    }
}

