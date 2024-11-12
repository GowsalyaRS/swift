struct Guest :  CustomStringConvertible
{
    private static var count   = 1001
    private var guestId        : Int
    private var name           : String
    private var phoneNo        : Int64
    private var address        : String
    init (name : String, phoneNo :Int64, address : String)
    {
        guestId      = Guest.count
        Guest.count  += 1
        self.name     = name
        self.phoneNo  = phoneNo
        self.address  = address
    }
    var guestIdProperty : Int
    {
        return guestId
    }
    var phoneNoProperty : Int64
    {
        return phoneNo
    }
    var description: String
    {
        return """
                  Name      : \(name), 
                  Phone No  : \(phoneNo), 
                  Address   : \(address)
               """
    }
}