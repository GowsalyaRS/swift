import Foundation
protocol RoomDelegation: AnyObject
{
    func isRoomAvailabilityChecking(roomNumber: Int, startDate: Date, endDate: Date) -> Bool
    func isValidRoomNumber(roomNumber : Int) -> Bool
}
