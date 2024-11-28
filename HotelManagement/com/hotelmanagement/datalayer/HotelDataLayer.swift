import SQLite3
import Foundation
class HotelDataLayer
{
    private static var hotelDataLayer : HotelDataLayer? = nil
    private var rooms                 : [Int : Room] = [:]
    private var guests                : [Int64 : Guest] = [:]
    private var authendications       : [GuestAuthentication] = []
    private var roomReservations      : [Int : [RoomBooking]] = [:] // roomnumber
    private var guestReservations     : [Int : [RoomBooking]] = [:] // guest
    private var paymentDetails        : [Int : Payment] = [:]
    private var hotelRooms            : [HotelRoom] = []
    private var cancelBooking         : [Int : RoomCancellation] = [:]
    private var booking               : [Int : RoomBooking] = [:]
    private var logMaintain           : [Int : LogMaintain] = [:]  // BookingId
    private var feedback              : [Int : Feedback] = [:]    // bookingId
    var db: OpaquePointer?
    private init()
    {
        let dbPath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("Demo.db").path
        print ("dpPath",dbPath)
        if sqlite3_open(dbPath, &db) == SQLITE_OK
        {
            print("Database connection established successfully.")
        }
        else
        {
            print("Failed to connect to SQLite database.")
        }
    }
    public static func getInstance() -> HotelDataLayer
    {
        if hotelDataLayer == nil
        {
            hotelDataLayer = HotelDataLayer()
        }
        return hotelDataLayer!
    }
    var roomsProperty : [Int : Room]
    {
        get { return rooms }
        set { rooms = newValue }
    }
    var guestProperty : [Int64 : Guest]
    {
        get { return guests }
        set { guests = newValue }
    }
    var authendicationsProperty : [GuestAuthentication]
    {
        get { return authendications }
        set { authendications = newValue }
    }
    var  hotelRoomsProperty  : [HotelRoom]
    {
        get { return hotelRooms }
        set { hotelRooms = newValue }
    }
    func getFeedback(bookingId : Int) -> Feedback?
    {
        return feedback[bookingId]
    }
    func addFeedback(bookingId : Int ,feedback : Feedback)
    {
        self.feedback[bookingId] = feedback
    }
    func getAllFeedback() -> [Feedback]
    {
        let allFeedback : [Feedback] = Array(feedback.values)
        return allFeedback
    }
    func addLog (bookingId : Int ,log : LogMaintain )
    {
        logMaintain[bookingId] = log
    }
    func getLog(bookingId : Int) ->  LogMaintain?
    {
        return logMaintain[bookingId]
    }
    var paymentDetailsProperty : [Int : Payment]
    {
        get { return paymentDetails }
        set { paymentDetails = newValue }
    }
    var bookingProperty : [Int : RoomBooking]
    {
        get { return booking }
        set { booking = newValue }
    }
    var cacelBookingProperty : [Int : RoomCancellation]
    {
        get { return cancelBooking }
        set { cancelBooking = newValue }
    }
    func getGuestBookings(guestNumber: Int) -> [RoomBooking]
    {
        return guestReservations[guestNumber] ?? []
    }
    func getRoomBookings(roomNumber : Int) -> [RoomBooking]
    {
       return roomReservations[roomNumber] ?? []
    }
    func addBooking(roomNumber : Int , booking: RoomBooking)
    {
        if var bookings = roomReservations[roomNumber]
        {
          bookings.append(booking)
          roomReservations[roomNumber] = bookings
        }
        else
        {
           roomReservations[roomNumber] = [booking]
        }
    }
    func addGuestBooking(guestId : Int , booking: RoomBooking)
    {
        if var bookings = guestReservations[guestId]
        {
          bookings.append(booking)
          guestReservations[guestId] = bookings
        }
        else
        {
          guestReservations[guestId] = [booking]
        }
    }
    
    func createTable(createTableQuery : String)
    {
         var createTableStatement: OpaquePointer?
         if sqlite3_prepare_v2(db, createTableQuery, -1, &createTableStatement, nil) == SQLITE_OK
          {
               
                if sqlite3_step(createTableStatement) == SQLITE_DONE
                {
                    print("Table 'users' created or already exists.")
                    sqlite3_finalize(createTableStatement)
                    return
                }
                else
                {
                    print("Error creating table.")
                }
          }
          else
          {
            print("Error preparing create table statement.")
          }
          sqlite3_finalize(createTableStatement)
          return 
    }
    func insertRecord(query: String) -> Bool
    {
            var insertStatement: OpaquePointer?
            if sqlite3_prepare_v2(db, query, -1, &insertStatement, nil) == SQLITE_OK
            {
                if sqlite3_step(insertStatement) == SQLITE_DONE
                {
                    print("Record inserted successfully.")
                    sqlite3_finalize(insertStatement)
                    return true
                }
                else
                {
                    let errorMsg = String(cString: sqlite3_errmsg(db))
                    print("Error inserting record: \(errorMsg)")
                }
            }
            else
            {
                print("Error preparing insert statement.")
            }
         sqlite3_finalize(insertStatement)
         return false
    }
    

    func executeQueryData(query: String) -> [[String: Any]]?
    {
        var result = [[String: Any]]()
        var queryStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, query, -1, &queryStatement, nil) == SQLITE_OK
        {
            let columnCount = sqlite3_column_count(queryStatement)
            while sqlite3_step(queryStatement) == SQLITE_ROW
            {
                var row = [String: Any]()
                for columnIndex in 0..<columnCount {
                    let columnName = sqlite3_column_name(queryStatement, columnIndex)
                    if let columnName = columnName
                    {
                        let columnString = String(cString: columnName)
                        if sqlite3_column_type(queryStatement, columnIndex) == SQLITE_TEXT
                        {
                            if let columnText = sqlite3_column_text(queryStatement, columnIndex)
                            {
                                row[columnString] = String(cString: columnText)
                            }
                        }
                        else if sqlite3_column_type(queryStatement, columnIndex) == SQLITE_INTEGER
                        {
                            let columnInt = sqlite3_column_int(queryStatement, columnIndex)
                            row[columnString] = Int(columnInt)
                        }
                        else if sqlite3_column_type(queryStatement, columnIndex) == SQLITE_FLOAT
                        {
                            let columnFloat = sqlite3_column_double(queryStatement, columnIndex)
                            row[columnString] = columnFloat
                        }
                        else if sqlite3_column_type(queryStatement, columnIndex) == SQLITE_NULL
                        {
                            row[columnString] = nil
                        }
                    }
                }
                result.append(row)
            }
        }
        else
        {
            print("Error preparing the query: \(String(cString: sqlite3_errmsg(db)))")
        }
        sqlite3_finalize(queryStatement)
        return result
    }
}

