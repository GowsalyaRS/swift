protocol LoginViewModelService
{
    func checkValidation(name : String?,password : String?)
    func setLoginView( loginView : LoginViewService)
}
