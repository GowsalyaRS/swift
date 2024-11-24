class GuestView : GuestViewService
{
    private var guestViewModel : GuestViewModelService
    init (guestViewModel : GuestViewModelService)
    {
        self.guestViewModel = guestViewModel
    }
    func inputGetGuestSignupDetails()
    {
        let phoneNo  = ValidInput.getPhoneNo(inputName :"Enter your phone number : ")
        if phoneNo == 0 { return }
        if  guestViewModel.isAvailablePhoneNo(phoneNo : phoneNo)
        {
            let name     = ValidInput.getName   (inputName :"Enter your name         : ")
            if name.isEmpty { return }
            let address  = ValidInput.getAddress(inputName :"Enter your address      : ")
            if address.isEmpty { return }
            let userNamePassword  = inputGetAuthendicationDetails()
            if userNamePassword.username.isEmpty || userNamePassword.password.isEmpty { return }
            let guest = guestViewModel.createGuest(name : name, phoneNo: phoneNo, address: address)
            guestViewModel.createAuthendication(guestId : guest.guestIdProperty, username : userNamePassword.username, password: userNamePassword.password)
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
                 switch choice
                 {
                     case BookingGuestOption.ListOfRoom.rawValue :
                      listRoom()
                     case BookingGuestOption.RoomBooking.rawValue:
                      roomBooking(guest : guest)
                     case BookingGuestOption.BookingHistory.rawValue:
                      bookingHistory(guest : guest)
                     case BookingGuestOption.CancelBooking.rawValue:
                       cancelBooking(guest : guest)
                     case  BookingGuestOption.CancelBookingHistory.rawValue:
                       cancelBookingHistory(guest : guest)
                     case BookingGuestOption.WriteFeedback.rawValue:
                        writeFeedback(guest : guest)
                     case BookingGuestOption.LogOut.rawValue:
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
    func listRoom() -> Bool
    {
        let roomViewModel : RoomViewModelService = RoomViewModel()
        let roomView : RoomViewService = RoomView(roomViewModel: roomViewModel)
        roomViewModel.setRoomView(roomView: roomView)
        let (isAvailable, rooms) = roomViewModel.isRoomChecking()
        if(isAvailable)
        {
            roomView.viewRoomDetails(room : rooms)
            return true
        }
        else
        {
            print (" room listings are not available at the hotel")
            return false
        }
    }
    func booking() -> (BookingView,BookingViewModel)
    {
        let bookingViewModel  = BookingViewModel()
        let bookingView    = BookingView(bookingViewModel: bookingViewModel)
        bookingViewModel.setBookingView(bookingView: bookingView)
        return (bookingView,bookingViewModel)
    }
    func roomBooking(guest : Guest)
    {
        if (listRoom())
        {
            let (bookingView,bookingViewModel) = booking()
            let roomViewModel : RoomViewModelService = RoomViewModel()
            let roomView : RoomViewService = RoomView(roomViewModel: roomViewModel)
            roomViewModel.setRoomView(roomView: roomView)
            bookingView.setDelegate(delegate: roomViewModel as! RoomDelegation)
            bookingView.getRoomBookingDetails(guest : guest)
        }
    }
    func bookingHistory (guest : Guest)
    {
        let (bookingView,bookingViewModel) = booking()
        let bookings = bookingViewModel.isAvailableBookingHistory(guest : guest ,bookingStatus: BookingStatus.confirmed)
        if !bookings.isEmpty
        {
            bookingView.displayRoomBookingDetails(bookings : bookings)
        }
        else
        {
           print ("No Booking History")
        }
    }
    func writeFeedback(guest : Guest)
    {
        let (bookingView,bookingViewModel) = booking()
        let bookingId =  bookingView.getInputBookingId()
        guard bookingId > 0 else { print("Invalid booking id"); return}
        let (isValid , booking) = bookingViewModel.checkBooking(bookingId: bookingId)
        if isValid
        {
             let  feedbackViewModel = FeedbackViewModel()
             let feedbackView = FeedbackView(feedbackViewModel: feedbackViewModel)
             feedbackViewModel.setFeedbackView(feedbackView)
             feedbackView.getInputFeedbackDetails(booking: booking!)
         }
         else
         {
            print("Invalid booking id")
         }
    }
    func cancelBooking(guest : Guest)
    {
        let (bookingView,bookingViewModel) = booking()
        let validBooking : [RoomBooking] = bookingViewModel.getValidBooking(guest: guest)
        if validBooking.isEmpty
        {
           print ("No Avilable booking found")
           return
        }
        for booking in validBooking
        {
            print (booking)
        }
        bookingView.getInputCancelBooking(booking: validBooking)
    }
    func cancelBookingHistory(guest : Guest)
    {
        let (bookingView,bookingViewModel) = booking()
        let bookings = bookingViewModel.isAvailableBookingHistory(guest : guest ,bookingStatus: BookingStatus.cancelled)
        if !bookings.isEmpty
        {
            bookingView.displayRoomBookingDetails(bookings : bookings)
        }
        else
        {
          print ("No Cancelling History")
        }
    }
}
