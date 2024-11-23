protocol   RoomViewModelService : AnyObject
{
    func isRoomChecking() -> (Bool,[Int:Room])
    func setRoomView( roomView: RoomViewService)
    func createRoom(roomType:RoomType,bedType:BedType,price:Float,amenities:[String],noOfRoom : Int)
}
