import Foundation
class RoomBooking :  CustomStringConvertible
{
        private static var count    = 10001
        private var bookingId        : Int
        private var bookingDate      : Date
        private  let roomNumber      : Int
        private  let guestId         : Int
        private var noOfGuest        : Int
        private let roomBookingDate  : [Date]
        private var bookingStatus    : BookingStatus = .pending
        {
            didSet
            {
                print(" Booking is  \(bookingStatus) " )
            }
        }
    
       init (roomNumber: Int, guestId: Int, noOfGuest: Int, roomBookingDate: [Date])
       {
            bookingId = RoomBooking.count
            RoomBooking.count += 1
            bookingDate = Date()
            self.roomNumber = roomNumber
            self.guestId    = guestId
            self.noOfGuest  = noOfGuest
            self.roomBookingDate = roomBookingDate
       }
       var roomBookingDateProperty: [Date]
       {
          return roomBookingDate
       }
       var roomNumberProperty: Int
       {
         return roomNumber
       }
       var bookingIdProperty: Int
       {
         return bookingId
       }
       var bookingStatusProperty: BookingStatus
       {
          get
          {
              return bookingStatus
          }
          set
          {
              bookingStatus = newValue
          }
       }
       var description: String
       {
        return """
                --------------------------------------
                Booking Id    :  \(bookingId)
                Room Number   :  \(roomNumber),
                No of Guest   :  \(noOfGuest), 
                Booking Date  :  \(roomBookingDate)
               """
       }
}


