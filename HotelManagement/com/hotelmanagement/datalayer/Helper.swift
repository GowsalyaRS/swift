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
                throw DatabaseError.tableCreationFailed(msg : "Failed to create table: \(error.localizedDescription)")
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
            print("Guest table creation failed ")
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
            print("Error creating Authendication table ")
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
            print("Error creating rooms table")
        }
    }
    func createHotelRoomTable()
    {
        let createTableQuery =   """
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
            print("Error creating hotel_rooms table ")
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
            print("Error creating guests table ")
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
            print("Error creating guests table")
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
            print("Error creating payment table")
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
            print("Error creating cancel_booking table ")
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
            print("Error creating bed_type table ")
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
            print("Error creating guest_role table")
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
            print( "Booking Status Table creation failed: ")
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
            print("Error creating payment_status table")
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
            print("Error creating room_type table")
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
            print("Error creating feedback table")
        }
    }
    func insertBedType() throws
    {
        let bedQuery  =  try hotelDataLayer.executeQueryData(query: "select * from bed_type limit 1")
        if bedQuery.isEmpty
        {
            try  hotelDataLayer.insertRecord(query: "insert into bed_type (bed_type) values ('Single'),('Double'),('Triple')")
        }
    }
    func insertRoomType() throws
    {
        let roomQuery =  try hotelDataLayer.executeQueryData(query: "select * from room_type limit 1")
        if roomQuery.isEmpty
        {
            try hotelDataLayer.insertRecord(query: "insert into room_type (room_type) values ('Standard'),('Classic'),('Deluxe')")
        }
    }
    func insertBookingType() throws
    {
        let bookingQuery = try hotelDataLayer.executeQueryData(query: "select * from booking_status limit 1")
        if bookingQuery.isEmpty
        {
            try hotelDataLayer.insertRecord(query: "insert into booking_status (booking_status) values  ('Pending'),('Confirmed'),('Cancelled'),('CheckOut'),('CheckIn')")
        }
    }
    func insertUserType() throws
    {
        let guestQuery = try  hotelDataLayer.executeQueryData(query: "select * from guest_role limit 1 ")
        if guestQuery.isEmpty
        {
            try hotelDataLayer.insertRecord(query: "insert into guest_role(role) values  ('Admin'),('Guest')")
        }
    }
    func insertPaymentType() throws
    {
        let paymentQuery = try hotelDataLayer.executeQueryData(query: "select * from payment_status limit 1")
        if  paymentQuery.isEmpty
        {
            try hotelDataLayer.insertRecord(query: "insert into payment_status (payment_status) values ('Pending'),('Refunded'),('Success'),('No_Paid')")
        }
    }
    func adminData() throws
    {
        let adminQuery = try hotelDataLayer.executeQueryData(query: "select * from guests")
        if adminQuery.isEmpty
        {
            var guest = Guest (name: "Yugan", phoneNo: 9876543210, address: "KK Nagar Madurai.")
            guest.roleProperty = .Admin
            let authendication = GuestAuthentication(guestId: guest.guestIdProperty,  username: "zoho", password: "123")
            try  hotelDataLayer .insertRecord(query: "insert into guests values (\(guest.guestIdProperty), '\(guest.nameProperty)', '\(guest.phoneNoProperty)', '\(guest.addressProperty.replacingOccurrences(of: "'", with: "''"))', '\(guest.roleProperty.rawValue) ')")
           try hotelDataLayer .insertRecord(query: "insert into guest_authentication(guestId,username,password) values (\(authendication.guestIdProperty), '\(authendication.usernameProperty)', '\(authendication.passwordProperty)')" )
        }
        else
        {
            if let lastGuest = adminQuery.last, let guestId = lastGuest["guestId"] as? Int
            {
                Guest.counterProperty = guestId
            }
        }
    }
    func roomData() throws
    {
        let roomsQuery =  try hotelDataLayer.executeQueryData(query: "select * from rooms")
        if  !roomsQuery.isEmpty
        {
            if let lastRoom = roomsQuery.last, let roomId = lastRoom["roomId"] as? Int
            {
                Room.counter =  roomId
            }
        }
    }
    func hotelRoomData()  throws
    {
        let hotelRoomQuery = try hotelDataLayer.executeQueryData(query: "select * from hotel_rooms")
        if  !hotelRoomQuery.isEmpty
        {
            if let lastHotel = hotelRoomQuery.last, let hotelId = lastHotel["roomNumber"] as? Int
            {
                HotelRoom.counterProperty =  hotelId
            }
        }
    }
    func bookingData() throws
    {
        let bookingsQuery = try hotelDataLayer.executeQueryData(query: "select * from booking")
        if  !bookingsQuery.isEmpty
        {
            if let lastBooking = bookingsQuery.last, let bookingId = lastBooking["bookingId"] as? Int
            {
                RoomBooking.countProperty = bookingId
            }
        }
    }
}
