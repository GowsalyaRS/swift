struct AdminProcess
{
    func adminInit(guest : Guest)
    {
        print("\t\t----------------------------------------------------------------------------------")
        print("\t\t\tWelcome, \(guest.nameProperty) You have access to the Admin interface now ")
        ("\t\t----------------------------------------------------------------------------------")
        while (true)
        {
            print("-------------------------------------------")
            for adminOption in AdminOption.allCases
            {
                print("\t\t\(adminOption.rawValue) . \(adminOption)")
            }
            print("-------------------------------------------")
            print ("Enter the option : ",terminator: "")
            if let input = readLine(), let choice = Int(input)
            {
                do
                {
                    switch choice
                    {
                        case AdminOption.Room.rawValue:
                            roomInit(guest : guest)
                        case AdminOption.Guest_Details.rawValue:
                           try guestProcess()
                        case AdminOption.Booking_Details.rawValue:
                           try bookingProcess()
                        case AdminOption.FeedBack_Details.rawValue :
                           try FeedbackProcess()
                        case AdminOption.Room_Booking_Checkout.rawValue :
                           try checkout()
                        case AdminOption.Room_Booking_Checkin.rawValue  :
                           try checkin()
                        case AdminOption.LogOut.rawValue:
                            return
                        default : print("Invalid choice")
                    }
                }
                catch
                {
                    print("\(error.localizedDescription)")
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
                do
                {
                    switch choice
                    {
                        case RoomAdminOption.Add_Rooms.rawValue :
                            try addRooms()
                        case RoomAdminOption.View_Rooms_Details.rawValue :
                           try roomDetails()
                        case RoomAdminOption.Back.rawValue :
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
    func guestProcess() throws
    {
        let guestViewModel  = GuestViewModel() 
        let guestView   : GuestViewService = GuestView(guestViewModel: guestViewModel) as GuestViewService
        guestViewModel.setGuestView(guestView: guestView)
        try guestView.displayGuestDetails(guests:guestViewModel.getGuestDeatils())
    }
    func bookingProcess() throws
    {
        let bookingViewModel  = BookingViewModel() 
        let bookingView   : BookingViewService = BookingView(bookingViewModel: bookingViewModel) as BookingViewService
        bookingViewModel.setBookingView(bookingView: bookingView)
        try bookingView.getInputBookingStatus()
    }
    func FeedbackProcess() throws
    {
        let feedbackViewModel   = FeedbackViewModel()
        let feedbackView  : FeedbackViewService    = FeedbackView(feedbackViewModel: feedbackViewModel)
        feedbackViewModel.setFeedbackView(feedbackView)
       feedbackView.displayFeedback(feedback: try feedbackViewModel.getFeedback())
    }
    func checkin() throws
    {
        let bookingViewModel = BookingViewModel()
        let bookingView = BookingView(bookingViewModel: bookingViewModel)
        bookingViewModel.setBookingView(bookingView: bookingView)
        let bookings =  try bookingViewModel.getRoomBooking(bookingStatus : BookingStatus.confirmed)
        if bookings.isEmpty
        {
            print ("No Available room checkin date today at hotel")
            return
        }
        try bookingView.displayRoomBookingDetails(bookings: bookings)
        try bookingView.getInputCheckInBooking()
    }
    func checkout() throws
    {
        let bookingViewModel = BookingViewModel()
        let bookingView = BookingView(bookingViewModel: bookingViewModel)
        bookingViewModel.setBookingView(bookingView: bookingView)
        let bookings =  try bookingViewModel.getRoomBooking(bookingStatus : BookingStatus.checkin)
        if bookings.isEmpty
        {
            print ("No Available room checkout date today at hotel")
            return
        }
        try bookingView.displayRoomBookingDetails(bookings: bookings)
        try  bookingView.getInputCheckOutBooking()
    }
    func roomDetails() throws
    {
        let roomViewModel :  RoomViewModelService = RoomViewModel() as RoomViewModelService
        let roomView : RoomViewService = RoomView(roomViewModel: roomViewModel) as RoomViewService
        roomViewModel.setRoomView(roomView: roomView)
        let rooms = try roomViewModel.isRoomChecking()
       try roomView.viewRoomDetails(room : rooms)
    }
    func addRooms() throws
    {
        let roomViewModel :  RoomViewModelService = RoomViewModel() as RoomViewModelService
        let roomView : RoomViewService = RoomView(roomViewModel: roomViewModel) as RoomViewService
        roomViewModel.setRoomView(roomView: roomView)
        try  roomView.getRoomSetupDetails()
    }
}

