class RoomViewModel
{
    private  var roomView : RoomView?
    func setRoomView( roomView: RoomView)
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
