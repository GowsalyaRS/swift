import Foundation
protocol BookingViewModelService : AnyObject
{
    func getRoomBookingDetails()
    func getRoomBookingDetails(bookingStatus : BookingStatus)
    func getValidBooking (guest: Guest) -> [RoomBooking]
    func setCancellationDetails(booking: RoomBooking, cancellationReason: String)
    func setCheckInDetails(booking : RoomBooking)
    func setCheckoutDetails(booking : RoomBooking)
    func isAvailableCheckOut(bookingId : Int) -> (Bool,RoomBooking?)
    func isAvailableBookingHistory (guest : Guest , bookingStatus : BookingStatus) -> [RoomBooking]
    func addedConfirmBooking (guest : Guest, roomNumber: Int, dates: [Date], noOfGuest: Int) -> RoomBooking
    func isValidBooking(guestBookings : [RoomBooking] , bookingId : Int) -> RoomBooking?
    func checkBooking(bookingId: Int) -> (Bool,RoomBooking?)
    func checkBooking(roomBooking : RoomBooking) -> Bool
}
