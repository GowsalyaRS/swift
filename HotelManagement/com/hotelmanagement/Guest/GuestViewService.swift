protocol GuestViewService : AnyObject
{
    func inputGetGuestSignupDetails() throws
    func displayGuestDetails(guests : [Guest])
    func inputGetChangePassword() throws
}
