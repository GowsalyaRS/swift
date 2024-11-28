public class LoginView : LoginViewService
{
     private var  loginViewModel : LoginViewModelService
     init( loginViewModel : LoginViewModelService)
     {
           self.loginViewModel = loginViewModel;
     }
     func LoginInit()
     {
        print ("\t\t---------------------------------------------")
        print ("\t\t Welcome to \"Amirtha\" Hotel Booking System   ")
        print ("\t\t---------------------------------------------")
        while (true)
        {
            print ("---------------------------------")
            for hotelOption in HotelOption.allCases
            {
                print ("\t\t\(hotelOption.rawValue).\(hotelOption)")
            }
            print ("---------------------------------")
            print ("Enter your choice :" ,terminator:"")
            if let input = readLine(), let choice = Int(input)
            {
                switch choice
                {
                   case HotelOption.Signin.rawValue :
                     getLoginData()
                   case HotelOption.Signup.rawValue :
                     guestSignupProcess()
                   case HotelOption.Exit.rawValue  :
                     return
                   default : print("Invalid choice")
                }
            }
            else
            {
                print("Invalid input")
            }
        }
    }
     func guestSignupProcess()
     {
        let guestViewModel = GuestViewModel()
        let guestView : GuestViewService = GuestView(guestViewModel: guestViewModel)
        guestViewModel.setGuestView(guestView: guestView)
        guestView.inputGetGuestSignupDetails()
     }
     func getLoginData()
     {
         let name : String = ValidInput.isEmptyValidation(inputName: "Enter the username : ")
         let password : String = ValidInput.isEmptyValidation(inputName:"Enter the password : ")
         loginViewModel.checkValidation(name: name, password: password)
     }
     func onAdminSuccess(guest : Guest)
     {
        let adminProcess : AdminProcess = AdminProcess()
         adminProcess.adminInit(guest : guest)
     }
     func onGuestSuccess(guest : Guest)
     {
        let guestViewModel = GuestViewModel()
        let guestView  = GuestView(guestViewModel: guestViewModel)
        guestViewModel.setGuestView(guestView: guestView)
        guestView.guestInit(guest : guest)
     }
}

