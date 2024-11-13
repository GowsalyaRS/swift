protocol LoginViewService : AnyObject
{
    func getLoginData()
    func onAdminSuccess()
    func onGuestSuccess( guest: Guest)
}
