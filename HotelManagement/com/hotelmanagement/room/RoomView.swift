class RoomView : RoomViewService
{
    private  var roomViewModel : RoomViewModelService
    init(roomViewModel : RoomViewModelService)
    {
        self.roomViewModel = roomViewModel
    }
    func  getRoomSetupDetails() throws
    {
        let noOfRoom = ValidInput.getCapacity(inputName: "Enter the number of the room   : ")
        if noOfRoom == 0  { return }
        let roomType = ValidInput.getRoomType(inputName: "Enter the room type            : ")
        if roomType == nil  { return }
        let bedType  = ValidInput.getBedType(inputName : "Enter the bed type             : ")
        if bedType == nil  { return }
        let price    = ValidInput.getPrice(inputName  : "Enter the price of the room   : ");
        if price == 0  { return }
        let amenities = ValidInput.getAmenities(inputName:"Enter the amenities              : ")
        try roomViewModel.createRoom(roomType: roomType!, bedType: bedType!, price: price, amenities: amenities, noOfRoom:noOfRoom )
    }
    func viewRoomDetails(room  rooms :  [Room]) throws
    {
        if rooms.isEmpty
        {
            throw Result.failure(msg: "No Room Found")
        }
        print ("Room Details:")
        for room in rooms
        {
            print (room)
        }
    }
}
