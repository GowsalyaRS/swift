import Foundation
    func tableCreate() throws
    {
        let helper : Helper = Helper()
        helper.createGuestRoleTable()
        helper.createGuestTable()
        helper.createAuthenticationTable()
        helper.createBedTypeTable()
        helper.createRoomTypeTable()
        helper.createRoomTable()
        helper.createHotelRoomTable()
        helper.createPaymentStatusTable()
        helper.createBookingStatusTable()
        helper.createBookingTable()
        helper.createLoginTable()
        helper.createPaymentTable()
        helper.createCancellationTable()
        helper.createFeedbackTable()
        try helper.insertBedType()
        try helper.insertRoomType()
        try helper.insertBookingType()
        try helper.insertPaymentType()
        try helper.insertUserType()
        try helper.adminData()
        try helper.bookingData()
        try helper.roomData()
        try helper.hotelRoomData()
    }
    do
    {
        try tableCreate()
    }
    catch
    {
        print ("\(error.localizedDescription)")
    }
let loginViewModel = LoginViewModel()
let loginView  = LoginView(loginViewModel: loginViewModel)
loginViewModel.setLoginView(loginView: loginView)
loginView.LoginInit()
