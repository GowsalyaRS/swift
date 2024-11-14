class GuestView : GuestViewService
{
    private unowned var guestViewModel : GuestViewModelService
    init (guestViewModel : GuestViewModelService)
    {
        self.guestViewModel = guestViewModel
    }
    
    func inputGetGuestSignupDetails()
    {
        let phoneNo  = ValidInput.getPhoneNo(inputName :"Enter your phone number : ")
        if  guestViewModel.isAvailablePhoneNo(phoneNo : phoneNo)
        {
            let name     = ValidInput.getName   (inputName :"Enter your name         : ")
            let address  = ValidInput.getAddress(inputName :"Enter your address      : ")
           let userNamePassword  = inputGetAuthendicationDetails()
           let guest = guestViewModel.createGuest(name : name, phoneNo: phoneNo, address: address)
            guestViewModel.createAuthendication(guestId : guest.guestIdProperty, username : userNamePassword.username, password: userNamePassword.password)
            print ("Guest Added Successfully :  Your Guest Id is \(guest.guestIdProperty)")
            roomProcess(guest: guest)
        }
        else
        {
            print ("Already signup with this phone number")
        }
    }
    
    func inputGetAuthendicationDetails() -> (username: String, password: String)
    {
        let username = ValidInput.getusername(inputName : "Enter your username   : ")
        let password = ValidInput.getPassword(inputName : "Enter your password   : ")
        return (username: username, password: password)
    }
    
    func displayGuestDetails(guests : [Int64 : Guest])
    {
        if (guests.isEmpty)
        {
            print ("No guest found")
            return;
        }
        for guest in guests
        {
            print (guest.value)
        }
    }
    
    func roomProcess(guest : Guest)
    {
        let roomViewModel = RoomViewModel()
        let roomView = RoomView(roomViewModel: roomViewModel)
        roomViewModel.setRoomView(roomView: roomView)
        roomView.guestAccessRoom (guest : guest)
    }
}
