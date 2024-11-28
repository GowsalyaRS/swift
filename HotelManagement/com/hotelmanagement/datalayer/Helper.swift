struct  Helper
{
    private let hotelDataLayer : HotelDataLayer
    init()
    {
        hotelDataLayer = HotelDataLayer.getInstance()
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
                              FOREIGN KEY (role_id) REFERENCES guest_role(role_id));
                              """
         hotelDataLayer.createTable(createTableQuery: createTableQuery)
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
            hotelDataLayer.createTable(createTableQuery: createTableQuery)
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
        hotelDataLayer.createTable(createTableQuery: createTableQuery)
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
        hotelDataLayer.createTable(createTableQuery: createTableQuery)
    }
    func createBookingTable()
    {
        let createTableQuery = """
                                CREATE TABLE IF NOT EXISTS booking (
                                bookingId INTEGER PRIMARY KEY, 
                                bookingDate TEXT, 
                                roomNumber INTEGER, 
                                guestId INTEGER, 
                                noOfGuest INTEGER, 
                                roomBookingDate TEXT, 
                                payment_status INTEGER, 
                                FOREIGN KEY (roomNumber) REFERENCES hotel_rooms(roomNumber), 
                                FOREIGN KEY (payment_status) REFERENCES booking_status( booking_status_id),
                                FOREIGN KEY (guestId) REFERENCES guests(guestId));
                                """
        hotelDataLayer.createTable(createTableQuery: createTableQuery)
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
          hotelDataLayer.createTable(createTableQuery: createTableQuery)
    }
    func createPaymentTable()
    {
            let createTableQuery = """
                                    CREATE TABLE IF NOT EXISTS payment (
                                    paymentId INTEGER PRIMARY KEY AUTOINCREMENT,
                                    bookingId INTEGER NOT NULL,
                                    amount REAL NOT NULL,
                                    payment_status_id INTEGER,
                                    FOREIGN KEY (payment_status_id) REFERENCES payment_status(payment_status_id)
                                    FOREIGN KEY (bookingId) REFERENCES booking(bookingId));
                                    """
           hotelDataLayer.createTable(createTableQuery: createTableQuery)
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
           hotelDataLayer.createTable(createTableQuery: createTableQuery)
    }
    func createBedTypeTable()
    {
        let createTableQuery = """
                                CREATE TABLE IF NOT EXISTS bed_type(
                                bed_id INTEGER PRIMARY KEY AUTOINCREMENT,
                                bed_type varchar(20));
                               """
        hotelDataLayer.createTable(createTableQuery: createTableQuery)
    }
    func createGuestRoleTable()
    {
        let createTableQuery = """
                               CREATE TABLE IF NOT EXISTS guest_role(
                               role_id INTEGER PRIMARY KEY AUTOINCREMENT,
                               role varchar(20));
                               """
        hotelDataLayer.createTable(createTableQuery: createTableQuery)
    }
    func createBookingStatusTable()
    {
        let createTableQuery = """
                                CREATE TABLE IF NOT EXISTS booking_status (
                                booking_status_id INTEGER PRIMARY KEY AUTOINCREMENT,
                                booking_status varchar(20));
                               """
        hotelDataLayer.createTable(createTableQuery: createTableQuery)
    }
    func createPaymentStatusTable()
    {
        let createTableQuery = """
                                 CREATE TABLE IF NOT EXISTS payment_status (
                                 payment_status_id INTEGER PRIMARY KEY AUTOINCREMENT,
                                 payment_status varchar(20));
                               """
        hotelDataLayer.createTable(createTableQuery: createTableQuery)
    }
    func createRoomTypeTable()
    {
        let createTableQuery = """
                                 CREATE TABLE IF NOT EXISTS room_type (
                                 room_type_id INTEGER PRIMARY KEY AUTOINCREMENT,
                                 room_type varchar(20));
                               """
        hotelDataLayer.createTable(createTableQuery: createTableQuery)
    }
    func createFeedbackTable()
    {
        let createTableQuery = """
                               CREATE TABLE  IF NOT EXISTS feedback (
                                bookingId INTEGER PRIMARY KEY,
                                date TEXT NOT NULL,
                                rating INTEGER,
                                comment TEXT,
                                FOREIGN KEY (bookingId) REFERENCES booking(bookingId)
                              );
                              """
        hotelDataLayer.createTable(createTableQuery: createTableQuery)
    }
}
