protocol   RoomViewModelService
{
    func isHotelRoomCheck() -> (Bool,[Int:Room])
    func setRoomView( roomView: RoomViewService)
}
