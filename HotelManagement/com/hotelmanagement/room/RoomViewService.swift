protocol RoomViewService : AnyObject
{
    func  getRoomSetupDetails() throws
    func  viewRoomDetails(rooms :  [Room]) throws
}
