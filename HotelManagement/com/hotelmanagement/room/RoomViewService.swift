protocol RoomViewService : AnyObject
{
    func  getRoomSetupDetails() throws
    func  viewRoomDetails(room  rooms :  [Room]) throws
}
