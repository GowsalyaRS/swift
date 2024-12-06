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
        if try guestViewModel.isAvailablePhoneNo(phoneNo : phoneNo) == false
        {
            let name     = ValidInput.getName   (inputName :"Enter your name         : ")
            if name.isEmpty { return }
            let address  = ValidInput.getAddress(inputName :"Enter your address      : ")
            if address.isEmpty { return }
            let userNamePassword  = inputGetAuthendicationDetails()
            if userNamePassword.username.isEmpty || userNamePassword.password.isEmpty { return }
            let guest = try guestViewModel.createGuest(name : name, phoneNo: phoneNo, address: address)
            switch guest
            {
                case .success (let guest):
                  let authentication = try guestViewModel.createAuthendication(guestId : guest.guestIdProperty, username : userNamePassword.username, password: userNamePassword.password)
                switch authentication
                {
                 case .success( _):
                     print ("Guest Added Succefully")
                    guestInit(guest: guest)
                  case .failure(let error):
                    throw error
                }
                case .failure(let error):
                throw error
            }
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
    func displayGuestDetails(guests : [Guest]) throws
    {
        if guests.isEmpty
        {
            throw DatabaseError.noRecordFound (msg : "No Guest Record Found")
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
                 catch let error as DatabaseError
                 {
                     print ("\(error.localizedDescription)")
                 }
                 catch let error
                 {
                     print (" \(error.localizedDescription)")
                 }
             }
             else
             {
                 print("Invalid input, Please enter a valid choice")
             }
         }
    }
    func listRoom() throws
    {
        let roomViewModel : RoomViewModelService = RoomViewModel()
        let roomView : RoomViewService = RoomView(roomViewModel: roomViewModel)
        roomViewModel.setRoomView(roomView: roomView)
        let (rooms) = try roomViewModel.isRoomChecking()
        try roomView.viewRoomDetails(rooms : rooms)
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
            throw DatabaseError.noRecordFound(msg: "No, you can write feedback that is available for checkout")
        }
        try bookingView.displayBookingDetails(roomBookings: bookings)
        let bookId =  bookingView.getInputBookingId()
        guard bookId > 0 else { print("Invalid booking id"); return}
        let booking = bookings.first(where: {$0.bookingIdProperty == bookId})
        if booking?.bookingIdProperty == bookId
        {
            let  feedbackViewModel = FeedbackViewModel()
            let feedbackView = FeedbackView(feedbackViewModel: feedbackViewModel)
            feedbackViewModel.setFeedbackView(feedbackView)
            _ = try feedbackView.getInputFeedbackDetails(booking: booking!)
        }
        else
        {
            throw DatabaseError.noRecordFound(msg : "Invalid Booking Id")
        }
    }
    func cancelBooking(guest : Guest) throws
    {
        let (bookingView,bookingViewModel) = booking()

           let validBooking : [RoomBooking] = try bookingViewModel.getValidBooking(guest: guest)
           for booking in validBooking
           {
               print (booking)
               print ("-----------------------------------------------------")
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
        let phoneNo = ValidInput.getPhoneNo(inputName: "Enter the phoneNo : ")
        if try guestViewModel.isAvailablePhoneNo(phoneNo: phoneNo)
        {
            let username = ValidInput.isEmptyValidation(inputName: "Enter the username : ")
            let password = ValidInput.getPassword(inputName: "Enter the new password :")
            let changePassword   =  try guestViewModel.changePassword(phoneNo: phoneNo , userName: username,password : password)
            switch changePassword
            {
              case .success:
                print ("Password Changed Successfully")
              case .failure (let error):
                throw error
            }
        }
        else
        {
            throw DatabaseError.noRecordFound(msg: "Your Phoneno is Invalid")
        }
    }
}
