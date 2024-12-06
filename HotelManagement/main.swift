import Foundation

do
{
    DataAccess.injectDatabase(using:SQLiteDatabase.self)
    try DataAccess.openDatabase()
    let helper : Helper = Helper()
    try helper.tableCreate()
}
catch
{
        print ("\(error.localizedDescription)")
}
let loginViewModel = LoginViewModel()
let loginView  = LoginView(loginViewModel: loginViewModel)
loginViewModel.setLoginView(loginView: loginView)
loginView.LoginInit()
