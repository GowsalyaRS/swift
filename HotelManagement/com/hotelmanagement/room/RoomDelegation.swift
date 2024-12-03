import Foundation
protocol RoomDelegation: AnyObject
{
    func isValidRoomNumber(roomId : Int) throws -> Bool
    func isRoomAvailabilityChecking(roomId: Int, startDate: Date, endDate: Date) throws -> (Bool,Int)
}
