struct  Helper
{
    func createTable(query: String) throws
    {
            do
            {
                try DataAccess.createTable(createTableQuery: query)
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
                              role_id Integer);
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
                               amenities TEXT);
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
        let createTableQuery  =  """
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
    func adminData() throws
    {
        let adminQuery = try DataAccess.executeQueryData(query: "select max(guestId) as Id from guests")
        if ((adminQuery.first?.isEmpty) == true)
        {
            try addAdminData()
        }
        else
        {
            if let firstResult = adminQuery.first, let guestId = firstResult["Id"] as? Int
            {
                Guest.counterProperty = guestId
            }
        }
    }
    func roomData() throws
    {
        let roomsQuery =  try DataAccess.executeQueryData(query: "select max(roomId) as Id from rooms")
        if  ((roomsQuery.first?.isEmpty) == false), let firstResult = roomsQuery.first,
                  let roomId = firstResult["Id"] as? Int
        {
           Room.counter = roomId
        }
    }
    func hotelRoomData()  throws
    {
        let hotelRoomQuery = try DataAccess.executeQueryData(query: "select max(roomNumber) as Id from hotel_rooms")
        if ((hotelRoomQuery.first?.isEmpty) == false), let firstResult = hotelRoomQuery.first, let hotelId = firstResult["Id"] as? Int
        {
            HotelRoom.counterProperty =  hotelId
        }
    }
    func bookingData() throws
    {
        let bookingsQuery = try DataAccess.executeQueryData(query: "select max(bookingId) as Id from booking")
        if  ((bookingsQuery.first?.isEmpty) == false), let firstResult = bookingsQuery.first, let bookingId = firstResult["Id"] as? Int
        {
            RoomBooking.countProperty = bookingId
        }
    }
    func addAdminData() throws
    {
        let guestDataLayer = GuestDataLayer.getInstance()
        var guest = Guest (name: "Yugan", phoneNo: 9876543210, address: "KK Nagar Madurai.")
        guest.roleProperty = .Admin
        let authendication = GuestAuthentication(guestId: guest.guestIdProperty,  username: "zoho", password: "123")
        try guestDataLayer.insertGuestData(guest: guest)
        try guestDataLayer.insertAuthendicationData(guestAuthentication:authendication )
    }
    func tableCreate() throws
    {
        createGuestTable()
        createAuthenticationTable()
        createRoomTable()
        createHotelRoomTable()
        createBookingTable()
        createLoginTable()
        createPaymentTable()
        createCancellationTable()
        createFeedbackTable()
        try adminData()
        try bookingData()
        try roomData()
        try hotelRoomData()
    }
}
