import Foundation

let loginViewModel = LoginViewModel()
let loginView  = LoginView(loginViewModel: loginViewModel)
loginViewModel.setLoginView(loginView: loginView)
loginView.LoginInit()
