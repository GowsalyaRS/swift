import Foundation
protocol BookingViewModelService : AnyObject
{
    func setBookingView(bookingView: BookingViewService)
    func isAvailableBookingHistory (guest : Guest , bookingStatus : BookingStatus) -> [RoomBooking]?
    func getValidBooking (guest: Guest) -> [RoomBooking]
    func isRoomAvailabilityChecking(roomNumber: Int, startDate: Date, endDate: Date) -> Bool
    func getRoomBookingDetails(bookingStatus : BookingStatus)
    func setCancellationDetails(booking: RoomBooking, cancellationReason: String)
    func setCheckInDetails(booking : RoomBooking)
    func setCheckoutDetails(booking : RoomBooking)
    func isAvailableCheckOut(bookingId : Int) -> (Bool,RoomBooking?)
    func isValidRoomNumber(roomNumber : Int) -> Bool
    func addedConfirmingBooking (guest : Guest, roomNumber: Int, dates: [Date], noOfGuest: Int) -> RoomBooking
    func isValidBooking(roomBookings : [RoomBooking] , roomNumber : Int) -> RoomBooking?
    func checkBooking(bookingId: Int) -> (Bool,RoomBooking?)
    func checkBooking(roomBooking : RoomBooking) -> Bool
}
