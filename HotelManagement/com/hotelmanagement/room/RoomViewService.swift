protocol RoomViewService : AnyObject
{
    func  getRoomSetupDetails()
    func  viewRoomDetails(room  rooms :  [Int:Room])
}
