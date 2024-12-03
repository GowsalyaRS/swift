protocol LoginViewService : AnyObject
{
    func getLoginData() throws
    func onAdminSuccess(guest : Guest)
    func onGuestSuccess(guest : Guest)
}
