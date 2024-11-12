class RoomViewModel : RoomViewModelService
{
    private  var roomView : RoomViewService?
    func setRoomView( roomView: RoomViewService)
    {
        self.roomView = roomView
    }
    func isHotelRoomCheck() -> (Bool,[Int:Room])
    {
        let rooms = HotelDataLayer.getInstance().getRooms()
        if   rooms.isEmpty
        {
            return (false,rooms)
        }
        return (true,rooms)
    }
}
