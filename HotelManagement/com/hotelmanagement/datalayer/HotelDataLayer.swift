class HotelDataLayer
{
    private static var hotelDataLayer : HotelDataLayer? = nil
    private var rooms                 : [Int : Room] = [:]
    private var guests                : [Int64 : Guest] = [:]
    private var authendications       : [GuestAuthentication] = []
    private var roomReservations      : [Int : [RoomBooking]] = [:] // roomnumber
    private var guestReservations     : [Int : [RoomBooking]] = [:] // guest
    private var paymentDetails        : [Int : Payment] = [:]
    private var hotelRooms            : [HotelRoom] = []
    private var cancelBooking         : [Int : RoomCancellation] = [:]
    private var booking               : [Int : RoomBooking] = [:]
    private var logMaintain           : [Int : LogMaintain] = [:]  // BookingId
    private var feedback              : [Int : Feedback] = [:]    // bookingId
    private init()
    {
        var guest = Guest (name: "Yugan", phoneNo: 9876543210, address: "KK Nagar Madurai")
        guest.roleProperty = .Admin
        guests[guest.phoneNoProperty] = guest
        let authendication = GuestAuthentication(guestId: guest.guestIdProperty,  username: "zoho", password: "123")
        authendications.append(authendication)
    }
    public static func getInstance() -> HotelDataLayer
    {
        if hotelDataLayer == nil
        {
            hotelDataLayer = HotelDataLayer()
        }
        return hotelDataLayer!
    }
    var roomsProperty : [Int : Room]
    {
        get { return rooms }
        set { rooms = newValue }
    }
    var guestProperty : [Int64 : Guest]
    {
        get { return guests }
        set { guests = newValue }
    }
    var authendicationsProperty : [GuestAuthentication]
    {
        get { return authendications }
        set { authendications = newValue }
    }
    var  hotelRoomsProperty  : [HotelRoom]
    {
        get { return hotelRooms }
        set { hotelRooms = newValue }
    }
    func getFeedback(bookingId : Int) -> Feedback?
    {
        return feedback[bookingId]
    }
    func addFeedback(bookingId : Int ,feedback : Feedback)
    {
        self.feedback[bookingId] = feedback
    }
    func getAllFeedback() -> [Feedback]
    {
        let allFeedback : [Feedback] = Array(feedback.values)
        return allFeedback
    }
    func addLog (bookingId : Int ,log : LogMaintain )
    {
        logMaintain[bookingId] = log
    }
    func getLog(bookingId : Int) ->  LogMaintain?
    {
        return logMaintain[bookingId]
    }
    var paymentDetailsProperty : [Int : Payment]
    {
        get { return paymentDetails }
        set { paymentDetails = newValue }
    }
    var bookingProperty : [Int : RoomBooking]
    {
        get { return booking }
        set { booking = newValue }
    }
    var cacelBookingProperty : [Int : RoomCancellation]
    {
        get { return cancelBooking }
        set { cancelBooking = newValue }
    }
    func getGuestBookings(guestNumber: Int) -> [RoomBooking]
    {
        return guestReservations[guestNumber] ?? []
    }
    func getRoomBookings(roomNumber : Int) -> [RoomBooking]
    {
       return roomReservations[roomNumber] ?? []
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
}
