class RoomView : RoomViewService
{
    private var roomViewModel : RoomViewModelService
    init(roomViewModel : RoomViewModelService)
    {
        self.roomViewModel = roomViewModel
    }
    func roomInit()
    {
        while (true)
        {
            print("--------------------------------------")
            for roomAdminOption in RoomAdminOption.allCases
            {
                print("\(roomAdminOption.rawValue) . \(roomAdminOption)")
            }
            print("--------------------------------------")
            print("Enter your choice:",terminator: "")
            if let input = readLine(), let choice = Int(input)
            {
                switch choice
                {
                    case RoomAdminOption.Add_Rooms.rawValue :
                        getRoomSetupDetails()
                    case RoomAdminOption.View_Rooms_Details.rawValue :
                        let (isAvailable, rooms) = roomViewModel.isHotelRoomCheck()
                        if(isAvailable)
                        {
                            viewRoomDetails(room : rooms)
                        }
                    case RoomAdminOption.Room_Booking_Checkout.rawValue :
                        return
                    case RoomAdminOption.Room_Booking_Checkin.rawValue  :
                       let bookingViewModel = BookingViewModel() as! BookingViewModelService
                       let bookingView = BookingView(bookingViewModel: bookingViewModel) as! BookingViewService
                       bookingViewModel.setBookingView(bookingView: bookingView)
                       bookingView.getInputCheckBooking()
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
    func  getRoomSetupDetails()
    {
        let capacity = ValidInput.getCapacity(inputName: "Enter the capacity of the room : ")
        let roomType = ValidInput.getRoomType(inputName: "Enter the room type            : ")
        let bedType  = ValidInput.getBedType(inputName : "Enter the bed type             : ")
        let price     = ValidInput.getPrice(inputName  : "Enter the price of the room    : ");
  let amenities = ValidInput.getRoomAmenities(inputName: "Enter the amenities            : ")
        let room = Room(capacity: capacity, roomType: roomType, bedType: bedType,price: price,amenities: amenities)
        HotelDataLayer.getInstance().addRooms(room: room)
    }
    func  viewRoomDetails(room  rooms :  [Int:Room])
    {
        print ("Room Details:")
        for room in rooms
        {
            print (room.value)
        }
    }
    func roomGuestInit(guest : Guest)
    {
        while(true)
        {
            print ("-------------------------------------------")
            for roomGuestOption in RoomGuestOption.allCases
            {
                print (roomGuestOption.rawValue,".",roomGuestOption)
            }
            print ("-------------------------------------------")
            print("Enter your choice:",terminator: "")
            if let input = readLine(), let choice = Int(input)
            {
                switch choice
                {
                    case RoomGuestOption.ListOfRoom.rawValue :
                        let (isAvailable, rooms) = roomViewModel.isHotelRoomCheck()
                        if(isAvailable)
                        {
                            viewRoomDetails(room : rooms)
                        }
                    case RoomGuestOption.Booking.rawValue :
                       bookingProcess(guest : guest)
                    case RoomGuestOption.Back.rawValue  :
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
    func bookingProcess(guest : Guest )
    {
        let bookingViewModel  = BookingViewModel()
        let bookingView    = BookingView(bookingViewModel: bookingViewModel)
        bookingViewModel.setBookingView(bookingView: bookingView)
        bookingView.bookingInit(guest : guest)
    }
} 
