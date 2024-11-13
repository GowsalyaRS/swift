protocol   RoomViewModelService : AnyObject
{
    func isHotelRoomCheck() -> (Bool,[Int:Room])
    func setRoomView( roomView: RoomViewService)
}
