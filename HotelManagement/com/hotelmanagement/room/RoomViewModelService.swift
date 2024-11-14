protocol   RoomViewModelService : AnyObject
{
    func isRoomChecking() -> (Bool,[Int:Room])
    func setRoomView( roomView: RoomViewService)
}
