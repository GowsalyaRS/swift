struct AdminProcess
{
    func adminInit()
    {
        while (true)
        {
            print("-----------------------------")
            for adminOption in AdminOption.allCases
            {
                print("\(adminOption.rawValue) . \(adminOption)")
            }
            print("-----------------------------")
            print ("Enter the option : ",terminator: "")
            if let input = readLine(), let choice = Int(input)
            {
                switch choice
                {
                    case AdminOption.Room.rawValue:
                        roomProcess()
                    case AdminOption.Guest_Details.rawValue:
                       guestProcess()
                    case AdminOption.Booking_Details.rawValue:
                      bookingProcess()
                    case AdminOption.Back.rawValue:
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
    func roomProcess()
    {
        let roomViewModel :  RoomViewModel = RoomViewModel()
        let roomView : RoomView = RoomView(roomViewModel: roomViewModel)
        roomViewModel.setRoomView(roomView: roomView)
        roomView.roomInit()
    }
    
    func guestProcess()
    {
        let guestViewModel : GuestViewModel = GuestViewModel()
        let guestView   : GuestView = GuestView(guestViewModel: guestViewModel)
        guestViewModel.setGuestView(guestView: guestView)
        guestView.displayGuestDetails(guests: HotelDataLayer.getInstance().getGuests())
    }
    
    func bookingProcess()
    {
        let bookingViewModel : BookingViewModel = BookingViewModel()
        let bookingView   : BookingView = BookingView(bookingViewModel: bookingViewModel)
        bookingViewModel.setBookingView(bookingView: bookingView)
        bookingView.getInputBookingStatus()
    }
}

