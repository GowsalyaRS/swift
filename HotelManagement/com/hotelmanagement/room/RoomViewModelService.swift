protocol   RoomViewModelService : AnyObject
{
    func isRoomChecking() throws -> ([Room])
    func setRoomView( roomView: RoomViewService)
    func createRoom(roomType:RoomType,bedType:BedType,price:Float,amenities:[String],noOfRoom : Int) throws
}
 
