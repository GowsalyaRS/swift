protocol GuestViewService : AnyObject
{
    func displayGuestDetails(guests : [Int64 : Guest])
    func inputGetGuestSignupDetails()
}
