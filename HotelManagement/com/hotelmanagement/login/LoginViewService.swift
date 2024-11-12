protocol LoginViewService
{
    func getLoginData()
    func onAdminSuccess()
    func onGuestSuccess( guest: Guest)
}
