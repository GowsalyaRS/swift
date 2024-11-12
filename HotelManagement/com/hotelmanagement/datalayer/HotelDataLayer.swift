class HotelDataLayer
{
    private static var hotelDataLayer : HotelDataLayer? = nil
    private var hotel                 : Hotel?
    private var rooms                 : [Int : Room] = [:]
    private var guests                : [Int64 : Guest] = [:]
    private var authendications       : [Int : GuestAuthentication] = [:]
    private var roomReservations      : [Int : [RoomBooking]] = [:] // roomnumber
    private var guestReservations     : [Int : [RoomBooking]] = [:] // guest
    private var paymentDetails        : [Int : Payment] = [:]
    private var cancelBooking         : [Int : RoomCancellation] = [:]
    private var booking               : [Int : RoomBooking] = [:]
    private init()
    {
    }
    public static func getInstance() -> HotelDataLayer
    {
        if hotelDataLayer == nil
        {
            hotelDataLayer = HotelDataLayer()
        }
        return hotelDataLayer!
    }
    var hotelProperty : Hotel
    {
        get
        {
            return hotel! 
        }
        set
        {
            hotel = newValue
        }
    }
    func addRooms(room : Room)
    {
        rooms[room.getRoomNumber()] = room 
    }
    func getRooms() -> [Int : Room]
    {
        return rooms
    }
    func addGuest (guest : Guest)
    {
        guests[guest.phoneNoProperty] = guest
    }
    func getGuests() -> [Int64 : Guest]
    {
        return guests
    }
    func getPaymentDetails() -> [Int : Payment]
    {
        return paymentDetails
    }
    func setPaymentDetails(payment : Payment)
    {
        paymentDetails[payment.bookingIdProperty] = payment
    }
    func getBooking (bookingId : Int) -> RoomBooking?
    {
         return booking[bookingId]
    }
    func setBooking(booking : RoomBooking)
    {
        self.booking[booking.bookingIdProperty] = booking
    }
    func setAuthendication(guestAuthentication : GuestAuthentication)
    {
        authendications[guestAuthentication.getGuestId()] = guestAuthentication
    }
    func getCancelBooking() -> [Int : RoomCancellation]
    {
        return cancelBooking
    }
    func setCancelBooking(cancelBooking : RoomCancellation)
    {
        self.cancelBooking[cancelBooking.bookingId] = cancelBooking
    }
    func getAuthendication (guestId : Int) -> GuestAuthentication?
    {
        return authendications[guestId] ?? nil
    }
    func getAllAuthendications() ->  [Int :GuestAuthentication]
    {
        return authendications
    }
    func getBookings(guestNumber: Int) -> [RoomBooking]?
    {
        return guestReservations[guestNumber]
    }
    func addBooking(roomNumber : Int , booking: RoomBooking)
    {
        if var bookings = roomReservations[roomNumber]
        {
          bookings.append(booking)
          roomReservations[roomNumber] = bookings
        }
        else
        {
           roomReservations[roomNumber] = [booking]
        }
    }
    func addGuestBooking(guestId : Int , booking: RoomBooking)
    {
        if var bookings = guestReservations[guestId]
        {
          bookings.append(booking)
          guestReservations[guestId] = bookings
        }
        else
        {
          guestReservations[guestId] = [booking]
        }
    }
    func getRoomBookings(roomNumber: Int, bookingStatus: BookingStatus) -> [RoomBooking]
    {
        if let bookings = roomReservations[roomNumber]
        {
            return bookings.filter { $0.bookingStatusProperty == bookingStatus }
        }
        return []
    }
    func getGuestBookings(guestNumber: Int,bookingStatus: BookingStatus) -> [RoomBooking]
    {
        if let bookings = guestReservations[guestNumber]
        {
            return bookings.filter { $0.bookingStatusProperty == bookingStatus }
        }
        return []
    }
}
