extension Int
{
    func capacityValidation(capacity: Int) -> Bool
    {
        if( capacity > 0)
        {
            return true
        }
        return false
    }
    
    func roomTypeValidation(roomType : Int) -> Bool
    {
        if (RoomType(rawValue: roomType) != nil )
        {
             return true
        }
        return false
    }
    
    func bedTypeValidation(bedType : Int) -> Bool
    {
        if (BedType(rawValue: bedType) != nil )
        {
             return true
        }
        return false
    }
    
    func roomBookingValidation( roomBooking :Int ) ->  Bool
    {
        if (BookingStatus(rawValue: roomBooking ) != nil )
        {
             return true
        }
        return false
    }
}
