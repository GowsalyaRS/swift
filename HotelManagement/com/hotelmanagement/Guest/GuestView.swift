class GuestView : GuestViewService
{
    private var guestViewModel : GuestViewModelService
    init (guestViewModel : GuestViewModelService)
    {
        self.guestViewModel = guestViewModel
    }
    func inputGetGuestSignupDetails() throws
    {
        let phoneNo  = ValidInput.getPhoneNo(inputName :"Enter your phone number : ")
        if phoneNo == 0 { return }
        if try guestViewModel.isAvailablePhoneNo(phoneNo : (phoneNo))
        {
            let name     = ValidInput.getName   (inputName :"Enter your name         : ")
            if name.isEmpty { return }
            let address  = ValidInput.getAddress(inputName :"Enter your address      : ")
            if address.isEmpty { return }
            let userNamePassword  = inputGetAuthendicationDetails()
            if userNamePassword.username.isEmpty || userNamePassword.password.isEmpty { return }
            let guest = try guestViewModel.createGuest(name : name, phoneNo: phoneNo, address: address)
            let _ = try guestViewModel.createAuthendication(guestId : guest.guestIdProperty, username : userNamePassword.username, password: userNamePassword.password)
            print ("Guest Added Successfully :  Your Guest Id is \(guest.guestIdProperty)")
            guestInit(guest: guest)
        }
        else
        {
            print ("Already signup with this phone number")
        }
    }
    func inputGetAuthendicationDetails() -> (username: String, password: String)
    {
        let username = ValidInput.getusername(inputName : "Enter your username    : ")
        if username.isEmpty { return (username: "", password: "") }
        let password = ValidInput.getPassword(inputName : "Enter your password    : ")
        if password.isEmpty { return (username: "", password: "") }
        return (username: username, password: password)
    }
    func displayGuestDetails(guests : [Guest])
    {
        if guests.isEmpty
        {
            print("No guest found")
            return
        }
        for guest in guests
        {
            print (guest)
        }
    }
    func guestInit(guest : Guest)
    {
        print("-----------------------------------------------")
        print ("\t\tWelcome to \(guest.nameProperty) Guest")
        print("-----------------------------------------------")
         while (true)
         {
             print ("----------------------------------")
             for  roomBooking in BookingGuestOption.allCases
             {
                 print ("\t\t",roomBooking.rawValue,".",roomBooking)
             }
             print ("----------------------------------")
             print ("Enter your choice : " , terminator: "")
             if let input = readLine(), let choice = Int(input)
             {
                 do
                 {
                     switch choice
                     {
                     case BookingGuestOption.ListOfRoom.rawValue :
                        try listRoom()
                     case BookingGuestOption.RoomBooking.rawValue:
                        try roomBooking(guest : guest)
                     case BookingGuestOption.BookingHistory.rawValue:
                        try bookingHistory(guest : guest)
                     case BookingGuestOption.CancelBooking.rawValue:
                        try cancelBooking(guest : guest)
                     case  BookingGuestOption.CancelBookingHistory.rawValue:
                        try cancelBookingHistory(guest : guest)
                     case BookingGuestOption.WriteFeedback.rawValue:
                        try writeFeedback(guest : guest)
                     case BookingGuestOption.LogOut.rawValue:
                         return
                     default : print("Invalid choice")
                     }
                 }
                 catch
                 {
                     print ("\(error.localizedDescription)")
                 }
             }
             else
             {
                 print("Invalid input")
             }
         }
    }
    func listRoom() throws
    {
        let roomViewModel : RoomViewModelService = RoomViewModel()
        let roomView : RoomViewService = RoomView(roomViewModel: roomViewModel)
        roomViewModel.setRoomView(roomView: roomView)
        let (rooms) = try roomViewModel.isRoomChecking()
        try roomView.viewRoomDetails(room : rooms)
    }
    func booking() -> (BookingView,BookingViewModel)
    {
        let bookingViewModel  = BookingViewModel()
        let bookingView    = BookingView(bookingViewModel: bookingViewModel)
        bookingViewModel.setBookingView(bookingView: bookingView)
        return (bookingView,bookingViewModel)
    }
    func roomBooking(guest : Guest)  throws
    {
        let (bookingView,_) = booking()
        let roomViewModel : RoomViewModelService = RoomViewModel()
        let roomView : RoomViewService = RoomView(roomViewModel: roomViewModel)
        roomViewModel.setRoomView(roomView: roomView)
        bookingView.setDelegate(delegate: roomViewModel as! RoomDelegation)
        try listRoom()
        try bookingView.getRoomBookingDetails(guest : guest)
    }
    func bookingHistory (guest : Guest)  throws
    {
        let (bookingView,bookingViewModel) = booking()
        let bookings = try bookingViewModel.isAvailableBookingHistory(guest : guest ,bookingStatus: BookingStatus.confirmed)
        try bookingView.displayRoomBookingDetails(bookings : bookings)
    }
    func writeFeedback(guest : Guest) throws
    {
        let (bookingView,bookingViewModel) = booking()
        let bookings  = try bookingViewModel.isAvailableBookingHistory(guest: guest, bookingStatus: BookingStatus.checkout)
        if bookings.isEmpty
        {
            throw Result.failure(msg :"No one have feedback")
        }
        bookingView.displayBookingDetails(roomBookings: bookings)
        let bookingId =  bookingView.getInputBookingId()
        guard bookingId > 0 else { print("Invalid booking id"); return}
        for booking in bookings
        {
            if booking.bookingIdProperty == bookingId
            {
                let  feedbackViewModel = FeedbackViewModel()
                let feedbackView = FeedbackView(feedbackViewModel: feedbackViewModel)
                feedbackViewModel.setFeedbackView(feedbackView)
                try feedbackView.getInputFeedbackDetails(booking: booking)
                return
            }
        }
        print ("Invalid Booking Id")
    }
    func cancelBooking(guest : Guest) throws
    {
        let (bookingView,bookingViewModel) = booking()

           let validBooking : [RoomBooking] = try bookingViewModel.getValidBooking(guest: guest)
           for booking in validBooking
           {
               print (booking)
               print ("----------------------------------")
           }
          try bookingView.getInputCancelBooking(booking: validBooking)
    }
    func cancelBookingHistory(guest : Guest) throws
    {
        let (bookingView,bookingViewModel) = booking()
        let bookings =  try bookingViewModel.isAvailableBookingHistory(guest : guest ,bookingStatus: BookingStatus.cancelled)
        try bookingView.displayRoomBookingDetails(bookings : bookings)
    }
    func inputGetChangePassword() throws
    {
        let phoneNo = ValidInput.getPhoneNo(inputName: "Enter the phoneNo ")
        if try !guestViewModel.isAvailablePhoneNo(phoneNo: phoneNo)
        {
            let username = ValidInput.isEmptyValidation(inputName: "Enter the username ")
            let password = ValidInput.getPassword(inputName: "Enter the new password ") 
            try guestViewModel.changePassword(phoneNo: phoneNo , userName: username,password : password)
        }
        else
        {
            print("Your Phoneno is Invalid")
        }
    }
}
