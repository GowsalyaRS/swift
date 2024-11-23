protocol LoginViewService : AnyObject
{
    func getLoginData()
    func onAdminSuccess(guest : Guest)
    func onGuestSuccess(guest : Guest)
}
