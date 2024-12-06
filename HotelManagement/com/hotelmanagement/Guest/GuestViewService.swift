protocol GuestViewService : AnyObject
{
    func inputGetGuestSignupDetails() throws
    func displayGuestDetails(guests : [Guest]) throws
    func inputGetChangePassword() throws
}
