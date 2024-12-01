struct  Helper
{
    private let hotelDataLayer : HotelDataLayer
    init()
    {
        hotelDataLayer = HotelDataLayer.getInstance()
    }
    func createTable(query: String) throws
    {
            do
            {
                try hotelDataLayer.createTable(createTableQuery: query)
            }
            catch
            {
                throw DatabaseError.tableCreationFailed("Failed to create table: \(error.localizedDescription)")
            }
    }
    func createGuestTable()
    {
        let createTableQuery = """
                              CREATE TABLE IF NOT EXISTS guests ( 
                              guestId INTEGER PRIMARY KEY, 
                              name TEXT, 
                              phoneNo TEXT UNIQUE, 
                              address TEXT, 
                              role_id Integer,
                              FOREIGN KEY(role_id) REFERENCES guest_role(role_id));
                              """
        do
        {
            try createTable(query: createTableQuery)
        }
        catch
        {
            print("Error creating guests table: \(error)")
        }
    }
    func createAuthenticationTable()
    {
        let createTableQuery = """
                                    CREATE TABLE IF NOT EXISTS guest_authentication (
                                    guestAuthId INTEGER PRIMARY KEY AUTOINCREMENT,
                                    guestId INTEGER,
                                    username TEXT NOT NULL,
                                    password TEXT NOT NULL,
                                    FOREIGN KEY (guestId) REFERENCES guests(guestId));
                                   """
        do
        {
            try createTable(query: createTableQuery)
        }
        catch
        {
            print("Error creating Authendication table: \(error)")
        }
    }
    func createRoomTable()
    {
        let createTableQuery = """
                               CREATE TABLE IF NOT EXISTS rooms (
                               roomId INTEGER PRIMARY KEY, 
                               room_type_id INTEGER, 
                               bed_id INTEGER, 
                               price REAL, 
                               amenities TEXT,
                               FOREIGN KEY (bed_id) REFERENCES bed_type(bed_id),
                               FOREIGN KEY (room_type_id) REFERENCES room_type(room_type_id));
                               """
        do
        {
            try createTable(query: createTableQuery)
        }
        catch
        {
            print("Error creating rooms table: \(error)")
        }
    }
    func createHotelRoomTable()
    {
        let createTableQuery = """
                                    CREATE TABLE IF NOT EXISTS hotel_rooms (
                                    roomNumber INTEGER PRIMARY KEY,
                                    roomId INTEGER,
                                    available BOOLEAN DEFAULT 1,
                                    FOREIGN KEY (roomId) REFERENCES rooms(roomId));
                                   """
        do
        {
            try createTable(query: createTableQuery)
        }
        catch
        {
            print("Error creating hotel_rooms table: \(error)")
        }
    }
    func createBookingTable()
    {
        let createTableQuery = """
                                CREATE TABLE IF NOT EXISTS  booking (
                                bookingId INTEGER PRIMARY KEY, 
                                bookingDate TEXT, 
                                roomNumber INTEGER, 
                                guestId INTEGER, 
                                noOfGuest INTEGER, 
                                stayingDays Integer,
                                bookingStartDate TEXT,
                                bookingEndDate TEXT,
                                bookingStatusId Int,
                                FOREIGN KEY (roomNumber) REFERENCES hotel_rooms(roomNumber),
                                FOREIGN KEY (bookingStatusId) REFERENCES booking_status(bookingStatusId),
                                FOREIGN KEY (guestId) REFERENCES guests(guestId));
                                """
        do
        {
            try createTable(query: createTableQuery)
        }
        catch
        {
            print("Error creating guests table: \(error)")
        }
    }
    func createLoginTable()
    {
        let createTableQuery = """
                                     CREATE TABLE IF NOT EXISTS login (
                                     bookingId INTEGER PRIMARY KEY,
                                     checkIn TEXT,
                                     checkOut TEXT,
                                     FOREIGN KEY (bookingId) REFERENCES booking(bookingId));
                                    """
        do
        {
            try createTable(query: createTableQuery)
        }
        catch
        {
            print("Error creating guests table: \(error)")
        }
    }
    func createPaymentTable()
    {
        let createTableQuery = """
                                    CREATE TABLE IF NOT EXISTS payment (
                                    paymentId INTEGER PRIMARY KEY AUTOINCREMENT,
                                    bookingId INTEGER ,
                                    amount REAL NOT NULL,
                                    payment_status_id INTEGER,
                                    FOREIGN KEY (payment_status_id) REFERENCES payment_status(payment_status_id)
                                    FOREIGN KEY (bookingId) REFERENCES booking(bookingId));
                                    """
        do
        {
            try createTable(query: createTableQuery)
        }
        catch
        {
            print("Error creating payment table: \(error)")
        }
    }
    func createCancellationTable()
    {
        let createTableQuery = """
                                    CREATE TABLE IF NOT EXISTS cancel_booking(
                                    cancellationId INTEGER PRIMARY KEY AUTOINCREMENT,
                                    bookingId INTEGER,
                                    cancellationDate TEXT NOT NULL,
                                    cancellationReason TEXT,
                                    FOREIGN KEY (bookingId) REFERENCES booking(bookingId));
                                   """
        do
        {
            try createTable(query: createTableQuery)
        }
        catch
        {
            print("Error creating cancel_booking table: \(error)")
        }
    }
    func createBedTypeTable()
    {
        let createTableQuery = """
                                CREATE TABLE IF NOT EXISTS bed_type(
                                bed_id INTEGER PRIMARY KEY AUTOINCREMENT,
                                bed_type varchar(20));
                               """
        do
        {
            try createTable(query: createTableQuery)
        }
        catch
        {
            print("Error creating bed_type table: \(error)")
        }
    }
    func createGuestRoleTable()
    {
        let createTableQuery = """
                               CREATE TABLE IF NOT EXISTS guest_role(
                               role_id INTEGER PRIMARY KEY AUTOINCREMENT,
                               role varchar(20));
                               """
        do
        {
            try createTable(query: createTableQuery)
        }
        catch
        {
            print("Error creating guest_role table: \(error)")
        }
    }
    func createBookingStatusTable()
    {
        let createTableQuery = """
                                CREATE TABLE IF NOT EXISTS booking_status (
                                bookingStatusId INTEGER PRIMARY KEY AUTOINCREMENT,
                                booking_status varchar(20));
                               """
        do
        {
            try createTable(query: createTableQuery)
        }
        catch
        {
            print("Error creating booking_status table: \(error)")
        }
    }
    func createPaymentStatusTable()
    {
        let createTableQuery = """
                                CREATE TABLE IF NOT EXISTS payment_status (
                                payment_status_id INTEGER PRIMARY KEY AUTOINCREMENT,
                                payment_status varchar(20));
                               """
        do
        {
            try createTable(query: createTableQuery)
        }
        catch
        {
            print("Error creating payment_status table: \(error)")
        }
    }
    func createRoomTypeTable()
    {
        let createTableQuery = """
                                CREATE TABLE IF NOT EXISTS room_type (
                                room_type_id INTEGER PRIMARY KEY AUTOINCREMENT,
                                room_type varchar(20));
                               """
        do
        {
            try createTable(query: createTableQuery)
        }
        catch
        {
            print("Error creating room_type table: \(error)")
        }
    }
    func createFeedbackTable()
    {
        let createTableQuery = """
                                CREATE TABLE  IF NOT EXISTS feedback (
                                bookingId INTEGER PRIMARY KEY,
                                date TEXT NOT NULL,
                                rating INTEGER,
                                comment TEXT,
                                FOREIGN KEY (bookingId) REFERENCES booking(bookingId));
                               """
        do
        {
            try createTable(query: createTableQuery)
        }
        catch
        {
            print("Error creating feedback table: \(error)")
        }
    }
    func insertBedType()
    {
        var bedQuery :  [[String:Any]]? =  hotelDataLayer.executeQueryData(query: "select * from bed_type limit 1")
        if bedQuery?.isEmpty == true
        {
            let _ =  hotelDataLayer.insertRecord(query: "insert into bed_type (bed_type) values ('Single'),('Double'),('Triple')")
        }
    }
    func insertRoomType()
    {
        var roomQuery = hotelDataLayer.executeQueryData(query: "select * from room_type limit 1")
        if roomQuery?.isEmpty == true
        {
            let _ =  hotelDataLayer.insertRecord(query: "insert into room_type (room_type) values ('Standard'),('Classic'),('Deluxe')")
        }
    }
    func insertBookingType()
    {
        var bookingQuery = hotelDataLayer.executeQueryData(query: "select * from booking_status limit 1")
        if bookingQuery?.isEmpty == true
        {
            let _ = hotelDataLayer.insertRecord(query: "insert into booking_status (booking_status) values  ('Pending'),('Confirmed'),('Cancelled'),('CheckOut'),('CheckIn')")
        }
    }
    func insertUserType()
    {
        var guestQuery =  hotelDataLayer.executeQueryData(query: "select * from guest_role limit 1 ")
        if guestQuery?.isEmpty == true
        {
            let _ = hotelDataLayer.insertRecord(query: "insert into guest_role(role) values  ('Admin'),('Guest')")
        }
    }
    func insertPaymentType()
    {
        var paymentQuery = hotelDataLayer.executeQueryData(query: "select * from payment_status limit 1")
        if  paymentQuery?.isEmpty == true
        {
            let _ = hotelDataLayer.insertRecord(query: "insert into payment_status (payment_status) values ('Pending'),('Refunded'),('Success'),('No_Paid')")
        }
    }
    func adminData()
    {
        var adminQuery = hotelDataLayer.executeQueryData(query: "select * from guests")
        if adminQuery?.isEmpty == true
        {
            var guest = Guest (name: "Yugan", phoneNo: 9876543210, address: "KK Nagar Madurai.")
            guest.roleProperty = .Admin
            let authendication = GuestAuthentication(guestId: guest.guestIdProperty,  username: "zoho", password: "123")
            let _ =  hotelDataLayer .insertRecord(query: "insert into guests values (\(guest.guestIdProperty), '\(guest.nameProperty)', '\(guest.phoneNoProperty)', '\(guest.addressProperty.replacingOccurrences(of: "'", with: "''"))', '\(guest.roleProperty.rawValue) ')")
           let _ = hotelDataLayer .insertRecord(query: "insert into guest_authentication(guestId,username,password) values (\(authendication.guestIdProperty), '\(authendication.usernameProperty)', '\(authendication.passwordProperty)')" )
        }
        else
        {
            if let lastGuest = adminQuery!.last, let guestId = lastGuest["guestId"] as? Int
            {
                Guest.counterProperty = guestId
            }
        }
    }
    func roomData()
    {
        var roomsQuery = hotelDataLayer.executeQueryData(query: "select * from rooms")
        if  roomsQuery!.isEmpty == false
        {
            if let lastRoom = roomsQuery!.last, let roomId = lastRoom["roomId"] as? Int
            {
                Room.counter =  roomId
            }
        }
    }
    func hotelRoomData() 
    {
        var hotelRoomQuery = hotelDataLayer.executeQueryData(query: "select * from hotel_rooms")
        if  hotelRoomQuery!.isEmpty == false
        {
            if let lastHotel = hotelRoomQuery!.last, let hotelId = lastHotel["roomNumber"] as? Int
            {
                HotelRoom.counterProperty =  hotelId
            }
        }
    }
    func bookingData()
    {
        var bookingsQuery = hotelDataLayer.executeQueryData(query: "select * from booking")
        if  bookingsQuery!.isEmpty == false
        {
            if let lastBooking = bookingsQuery!.last, let bookingId = lastBooking["bookingId"] as? Int
            {
                RoomBooking.countProperty = bookingId
            }
        }
    }
}
