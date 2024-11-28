import Foundation
protocol RoomDelegation: AnyObject
{
    func isValidRoomNumber(roomId : Int) -> Bool
    func isRoomAvailabilityChecking(roomId: Int, startDate: Date, endDate: Date) -> (Bool,Int)
}
