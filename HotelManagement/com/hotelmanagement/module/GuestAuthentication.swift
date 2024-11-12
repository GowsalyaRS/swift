struct GuestAuthentication
{
    private var guestId  : Int
    private var username : String
    private var password : String
    
    init(guestId: Int, username: String, password: String)
    {
        self.guestId  = guestId
        self.username = username
        self.password = password
    }
    
    func getGuestId() -> Int
    {
        return guestId
    }
    
    func getUsername() -> String
    {
        return username
    }
    
    func getPassword() -> String
    {
        return password
    }
}

