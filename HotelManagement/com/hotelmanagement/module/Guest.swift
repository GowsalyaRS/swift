struct Guest :  CustomStringConvertible
{
    private static var count   = 1000
    private var guestId        : Int 
    private let name           : String
    private var phoneNo        : Int64
    private var address        : String
    private var role           : GuestRole = .Guest
    init (name : String, phoneNo :Int64, address : String)
    {
        Guest.count  += 1
        guestId       = Guest.count
        self.name     = name
        self.phoneNo  = phoneNo
        self.address  = address.replacingOccurrences(of: "'", with: "")
    }
    init (guestId: Int, name: String, phoneNo: Int64, address: String, role:GuestRole)
    {
        self.guestId       = guestId
        self.role          = role
        self.name          = name
        self.phoneNo       = phoneNo
        self.address       = address.replacingOccurrences(of: "'", with: "")
    }
    var roleProperty : GuestRole
    {
        get { return role }
        set { role = newValue }
    }
    var guestIdProperty : Int
    {
        get { return guestId }
        set { guestId = newValue }
    }
    var phoneNoProperty : Int64
    {
        return phoneNo
    }
    var nameProperty : String
    {
        return name
    }
    var addressProperty : String
    {
        return address
    }
    static var counterProperty : Int
    {
        get { return count }
        set { count = newValue }
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
