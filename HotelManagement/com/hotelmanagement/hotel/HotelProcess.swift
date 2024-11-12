import Foundation
struct HotelProcess
{
    let hotelDataLayer = HotelDataLayer.getInstance()
    
    func hotelSetup()
    {
     let hotelName    = ValidInput.getName(inputName     :" Enter the Hotel Name     : ")
     let phoneNo      = ValidInput.getPhoneNo(inputName  :" Enter the PhoneNo        : ")
     let hotelAddress = ValidInput.getAddress(inputName  :" Enter the Hotel  Address : ")
     let email        = ValidInput.getEmail(inputName    :" Enter the Email          : ")
     let amenities    = ValidInput.getAmenities(inputName:" Enter the Amenities      : ")
     let hotel        = Hotel (hotelName: hotelName, phoneNo: phoneNo, address:hotelAddress, email: email, amenities: amenities)
        hotelDataLayer.hotelProperty = hotel
        print ("Hotel Setup Completed")
        print ("---------------------------------------","\n",hotel, "\n","---------------------------------------")  }
    
    func hotelInit()
    {
        print ("Welcome our \(hotelDataLayer.hotelProperty.hotelNameProperty) Hotel")
        while (true)
        {
            print ("---------------------------------")
            for hotelOption in HotelOption.allCases
            {
                print ("\(hotelOption.rawValue) . \(hotelOption)")
            }
            print ("---------------------------------")
            print ("Enter your choice :" ,terminator:"")
            if let input = readLine(), let choice = Int(input)
            {
                switch choice
                {
                   case HotelOption.Signin.rawValue :
                     loginProcess()
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
    
    func loginProcess()
    {
        let loginViewModel :  LoginViewModelService = LoginViewModel()
        let loginView : LoginViewService = LoginView(loginViewModel: loginViewModel)
        loginViewModel.setLoginView(loginView: loginView)
        loginView.getLoginData()
    }
    
    func guestSigninProcess(guest : Guest)
    {
        let roomViewModel = RoomViewModel()
        let roomView = RoomView(roomViewModel: roomViewModel)
        roomViewModel.setRoomView(roomView: roomView)
        roomView.roomGuestInit(guest : guest)
    }

    func guestSignupProcess()
    {
        let guestViewModel : GuestViewModel = GuestViewModel()
        let guestView : GuestView = GuestView(guestViewModel: guestViewModel)
        guestViewModel.setGuestView(guestView: guestView)
        guestView.inputGetGuestSignupDetails()
    }
}
