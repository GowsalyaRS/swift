import Foundation
protocol BookingViewModelService : AnyObject
{
    func getRoomBookingDetails() throws 
    func getRoomBookingDetails(bookingStatus : BookingStatus) throws 
    func getValidBooking (guest: Guest) throws -> [RoomBooking]
    func setCancellationDetails(booking: RoomBooking, cancellationReason: String) throws
    func setCheckInDetails(booking : RoomBooking) throws
    func setCheckoutDetails(booking : RoomBooking) throws
    func isAvailableCheckOut(bookingId : Int)  throws-> (Bool,RoomBooking?) 
    func isValidBooking(guestBookings : [RoomBooking] , bookingId : Int) -> RoomBooking?
    func checkBooking(bookingId: Int)  throws -> (Bool,RoomBooking?)
    func checkBooking(roomBooking : RoomBooking) -> Bool
    func getRoomBooking(bookingStatus : BookingStatus) throws -> [RoomBooking]
    func isAvailableBookingHistory (guest : Guest , bookingStatus : BookingStatus) throws  -> [RoomBooking]
    func addedConfirmBooking (guest : Guest, roomNumber: Int, dates: [Date], noOfGuest: Int,stayingDays : Int) throws ->  Result <RoomBooking,DatabaseError>
}
