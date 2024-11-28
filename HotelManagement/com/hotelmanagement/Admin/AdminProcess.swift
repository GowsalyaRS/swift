struct AdminProcess
{
    func adminInit(guest : Guest)
    {
        print("\t\t---------------------------------------------")
        print ("\t\t\tWelcome, \(guest.nameProperty) You have access to the Admin interface now ")
        print("\t\t----------------------------------------------")
        while (true)
        {
            print("-----------------------------")
            for adminOption in AdminOption.allCases
            {
                print("\t\t\(adminOption.rawValue) . \(adminOption)")
            }
            print("-----------------------------")
            print ("Enter the option : ",terminator: "")
            if let input = readLine(), let choice = Int(input)
            {
                switch choice
                {
                    case AdminOption.Room.rawValue:
                      roomInit(guest : guest)
                    case AdminOption.Guest_Details.rawValue:
                       guestProcess()
                    case AdminOption.Booking_Details.rawValue:
                      bookingProcess()
                    case AdminOption.FeedBack_Details.rawValue :
                      FeedbackProcess()
                     case AdminOption.Room_Booking_Checkout.rawValue :
                      checkout()
                    case AdminOption.Room_Booking_Checkin.rawValue  :
                      checkin()
                    case AdminOption.LogOut.rawValue:
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
    func roomInit(guest : Guest)
    {
        while (true)
        {
            print("--------------------------------------")
            for roomAdminOption in RoomAdminOption.allCases
            {
                print("\t\t\(roomAdminOption.rawValue).\(roomAdminOption)")
            }
            print("--------------------------------------")
            print("Enter your choice:",terminator: "")
            if let input = readLine(), let choice = Int(input)
            {
                switch choice
                {
                    case RoomAdminOption.Add_Rooms.rawValue :
                      addRooms()
                    case RoomAdminOption.View_Rooms_Details.rawValue :
                       roomDetails()
                    case RoomAdminOption.Back.rawValue :
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
    func guestProcess()
    {
        let guestViewModel  = GuestViewModel() 
        let guestView   : GuestViewService = GuestView(guestViewModel: guestViewModel) as GuestViewService
        guestViewModel.setGuestView(guestView: guestView)
        guestView.displayGuestDetails(guests:guestViewModel.getGuestDeatils())
    }
    func bookingProcess()
    {
        let bookingViewModel  = BookingViewModel() 
        let bookingView   : BookingViewService = BookingView(bookingViewModel: bookingViewModel) as BookingViewService
        bookingViewModel.setBookingView(bookingView: bookingView)
        bookingView.getInputBookingStatus()
    }
    func FeedbackProcess()
    {
        let feedbackViewModel   = FeedbackViewModel()
        let feedbackView  : FeedbackViewService    = FeedbackView(feedbackViewModel: feedbackViewModel)
        feedbackViewModel.setFeedbackView(feedbackView)
        let feedback : [Feedback] = feedbackViewModel.getFeedback()
        feedbackView.displayFeedback(feedback: feedback)
    }
    func checkin()
    {
        let bookingViewModel = BookingViewModel()
        let bookingView = BookingView(bookingViewModel: bookingViewModel)
        bookingViewModel.setBookingView(bookingView: bookingView)
        bookingView.getInputCheckInBooking()
    }
    func checkout()
    {
        let bookingViewModel = BookingViewModel()
        let bookingView = BookingView(bookingViewModel: bookingViewModel)
        bookingViewModel.setBookingView(bookingView: bookingView)
        bookingView.getInputCheckOutBooking()
    }
    func roomDetails()
    {
        let roomViewModel :  RoomViewModelService = RoomViewModel() as RoomViewModelService
        let roomView : RoomViewService = RoomView(roomViewModel: roomViewModel) as RoomViewService
        roomViewModel.setRoomView(roomView: roomView)
        let (isAvailable, rooms) = roomViewModel.isRoomChecking()
        if(isAvailable)
        {
            roomView.viewRoomDetails(room : rooms)
        }
    }
    func addRooms()
    {
        let roomViewModel :  RoomViewModelService = RoomViewModel() as RoomViewModelService
        let roomView : RoomViewService = RoomView(roomViewModel: roomViewModel) as RoomViewService
        roomViewModel.setRoomView(roomView: roomView)
        roomView.getRoomSetupDetails()
    }
}

