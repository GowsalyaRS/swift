struct Guest :  CustomStringConvertible
{
    private static var count   = 1001
    private let guestId        : Int
    private let name           : String
    private var phoneNo        : Int64
    private var address        : String
    private var role           : GuestRole = .Guest
    init (name : String, phoneNo :Int64, address : String)
    {
        guestId       = Guest.count
        Guest.count  += 1
        self.name     = name
        self.phoneNo  = phoneNo
        self.address  = address
    }
    var roleProperty : GuestRole
    {
        get
        {
            return role
        }
        set
        {
            role = newValue
        }
    }
    var guestIdProperty : Int
    {
        return guestId
    }
    var phoneNoProperty : Int64
    {
        return phoneNo
    }
    var nameProperty : String
    {
        return name
    }
    var description: String
    {
        return """
                  ------------------------------
                  Name      : \(name), 
                  Phone No  : \(phoneNo), 
                  Address   : \(address)
                  ------------------------------
               """
    }
}
