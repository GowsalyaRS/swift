struct Hotel : CustomStringConvertible
{
     private var hotelName           : String
     private var phoneNo             : Int64
     private var address             : String
     private var email               : String
     private var amenities           : [String]
     private var bookingDiscount     : Float  = 0.20
     private var cancellationCharge  : Float  = 0.30
    
     init(hotelName: String, phoneNo: Int64, address: String, email: String, amenities: [String])
     {
        self.hotelName  = hotelName
        self.phoneNo    = phoneNo
        self.address    = address
        self.email      = email
        self.amenities  = amenities
    }
    var hotelNameProperty : String
    {
        return hotelName
    }
    var ammenitiesProperty  : [String]
    {
        return amenities
    }
    var bookingDiscountProperty : Float
    {
        return bookingDiscount
    }
    var description: String
    {
        return     """
                    Hotel Details :-
                    Hotel Name  : \(hotelName)
                    Phone No    : \(phoneNo)
                    Address     : \(address)
                    Email       : \(email)
                    Amenities   : \(amenities)
                   """
    }
}
