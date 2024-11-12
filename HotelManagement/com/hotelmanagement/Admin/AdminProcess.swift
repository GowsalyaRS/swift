struct AdminProcess
{
    func adminInit()
    {
        while (true)
        {
            print("-----------------------------")
            print ("welcome to admin page")
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
        let roomViewModel :  RoomViewModelService = RoomViewModel() as RoomViewModelService
        let roomView : RoomViewService = RoomView(roomViewModel: roomViewModel) as RoomViewService
        roomViewModel.setRoomView(roomView: roomView)
        roomView.roomInit()
    }
    
    func guestProcess()
    {
        let guestViewModel : GuestViewModelService = GuestViewModel() as GuestViewModelService
        let guestView   : GuestViewService = GuestView(guestViewModel: guestViewModel) as GuestViewService
        guestViewModel.setGuestView(guestView: guestView)
        guestView.displayGuestDetails(guests: HotelDataLayer.getInstance().getGuests())
    }
    
    func bookingProcess()
    {
        let bookingViewModel : BookingViewModelService = BookingViewModel() as BookingViewModelService
        let bookingView   : BookingViewService = BookingView(bookingViewModel: bookingViewModel) as BookingViewService
        bookingViewModel.setBookingView(bookingView: bookingView)
        bookingView.getInputBookingStatus()
    }
}
  
