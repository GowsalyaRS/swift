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
                do
                {
                    switch choice
                    {
                     case HotelOption.Signin.rawValue :
                         try getLoginData()
                     case HotelOption.Signup.rawValue :
                         try guestSignupProcess()
                     case HotelOption.ForgetPassword.rawValue :
                          try forgetPassword()
                     case HotelOption.Exit.rawValue  :
                         try DataAccess.closeDatabase()
                        return
                     default : print("Invalid choice")
                    }
                }
                catch let error as DatabaseError
                {
                    print ("\(error.localizedDescription)")
                }
                catch
                {
                    print ("\(error.localizedDescription)")
                }
            }
            else
            {
                print("Invalid input, Please enter a valid choice")
            }
        }
    }
    func guestSignupProcess() throws
     {
        let guestViewModel = GuestViewModel()
        let guestView : GuestViewService = GuestView(guestViewModel: guestViewModel)
        guestViewModel.setGuestView(guestView: guestView)
        try guestView.inputGetGuestSignupDetails()
     }
    func getLoginData() throws
     {
         let name : String = ValidInput.isEmptyValidation(inputName: "Enter the username : ")
         let password : String = ValidInput.isEmptyValidation(inputName:"Enter the password : ")
         try loginViewModel.checkValidation(name: name, password: password)
     }
     func forgetPassword() throws
     {
         let guestViewModel = GuestViewModel()
         let guestView  = GuestView(guestViewModel: guestViewModel)
         guestViewModel.setGuestView(guestView: guestView)
         try guestView.inputGetChangePassword()
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

