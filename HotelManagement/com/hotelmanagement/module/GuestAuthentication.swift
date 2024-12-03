struct GuestAuthentication
{
    private var guestId  : Int
    private var username : String
    private var password : String
    init(guestId: Int, username: String, password: String)
    {
        self.guestId  = guestId
        self.username = username.replacingOccurrences(of: "'", with: "")
        self.password = password.replacingOccurrences(of: "'", with: "")
    }
    var guestIdProperty : Int
    {
        get { return guestId }
        set { guestId = newValue}
    }
    var usernameProperty : String
    {
        get { return username }
        set { username = newValue }
    }
    var passwordProperty : String
    {
        get { return password }
    }
    mutating func setPassword(password: String , username: String) -> Bool
    {
        if username == self.username
        {
            self.password = password.replacingOccurrences(of: "'", with: "")
            return true
        }
        return false
    }
}

