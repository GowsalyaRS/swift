protocol GuestViewService : AnyObject
{
    func inputGetGuestSignupDetails()
    func displayGuestDetails(guests : [Int64 : Guest])
}
