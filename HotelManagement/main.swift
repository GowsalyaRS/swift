import Foundation
print ("Hiii")
func tableCreate()
{
    let helper : Helper = Helper()
    helper.createGuestRoleTable()
    helper.createGuestTable()
    helper.createAuthenticationTable()
    helper.createBedTypeTable()
    helper.createRoomTypeTable()
    helper.createRoomTable()
    helper.createHotelRoomTable()
    helper.createBookingStatusTable()
    helper.createBookingTable()
    helper.createLoginTable()
    helper.createPaymentTable()
    helper.createCancellationTable()
    helper.createPaymentStatusTable()
    helper.createFeedbackTable()
}
tableCreate()
var hotel    = HotelDataLayer.getInstance()
var bedQuery :  [[String:Any]]? = hotel.executeQueryData(query: "select * from bed_type limit 1")
if bedQuery?.isEmpty == true
{
   let _ =  hotel.insertRecord(query: "insert into bed_type (bed_type) values ('Single'),('Double'),('Triple')")
}
var roomQuery = hotel.executeQueryData(query: "select * from room_type limit 1")
if roomQuery?.isEmpty == true
{
   let _ =  hotel.insertRecord(query: "insert into room_type (room_type) values ('Standard'),('Classic'),('Deluxe')")
}
var guestQuery = hotel.executeQueryData(query: "select * from guest_role limit 1 ")
if guestQuery?.isEmpty == true
{
   let _ = hotel.insertRecord(query: "insert into guest_role(role) values  ('Admin'),('Guest')")
}
var bookingQuery = hotel.executeQueryData(query: "select * from booking_status limit 1")
if bookingQuery?.isEmpty == true
{
    let _ = hotel.insertRecord(query: "insert into booking_status (booking_status) values  ('Pending'),('Confirmed'),('Cancelled'),('CheckOut'),('CheckIn')")
}
var paymentQuery = hotel.executeQueryData(query: "select * from payment_status limit 1")
if  paymentQuery?.isEmpty == true
{
   let _ = hotel.insertRecord(query: "insert into payment_status (payment_status) values ('Pending'),('Refunded'),('Success'),('No_Paid')")
}
var adminQuery = hotel.executeQueryData(query: "select * from guests")
if adminQuery?.isEmpty == true
{
    var guest = Guest (name: "Yugan", phoneNo: 9876543210, address: "KK Nagar Madurai.")
    guest.roleProperty = .Admin
    let authendication = GuestAuthentication(guestId: guest.guestIdProperty,  username: "zoho", password: "123")
    let _ = hotel.insertRecord(query: "insert into guests values (\(guest.guestIdProperty), '\(guest.nameProperty)', '\(guest.phoneNoProperty)', '\(guest.addressProperty.replacingOccurrences(of: "'", with: "''"))', '\(guest.roleProperty.rawValue) ')")
   let _ = hotel.insertRecord(query: "insert into guest_authentication(guestId,username,password) values (\(authendication.guestIdProperty), '\(authendication.usernameProperty)', '\(authendication.passwordProperty)')" )
}
if  adminQuery!.isEmpty == false
{
    if let lastGuest = adminQuery!.last, let guestId = lastGuest["guestId"] as? Int
    {
        Guest.counterProperty = guestId
    }
}
var roomsQuery = hotel.executeQueryData(query: "select * from rooms")
if  roomsQuery!.isEmpty == false
{
    if let lastRoom = roomsQuery!.last, let roomId = lastRoom["roomId"] as? Int
    {
        Room.counter =  roomId
    }
}
var hotelRoomQuery = hotel.executeQueryData(query: "select * from hotel_rooms")
if  hotelRoomQuery!.isEmpty == false
{
    if let lastHotel = hotelRoomQuery!.last, let hotelId = lastHotel["roomNumber"] as? Int
    {
        HotelRoom.counterProperty =  hotelId
    }
}
var bookingsQuery = hotel.executeQueryData(query: "select * from booking")
if  bookingsQuery!.isEmpty == false
{
    if let lastBooking = bookingsQuery!.last, let bookingId = lastBooking["bookingId"] as? Int
    {
        RoomBooking.countProperty = bookingId
    }
}
let loginViewModel = LoginViewModel()
let loginView  = LoginView(loginViewModel: loginViewModel)
loginViewModel.setLoginView(loginView: loginView)
loginView.LoginInit()
