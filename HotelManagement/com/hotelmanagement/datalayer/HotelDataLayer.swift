import SQLite3
import Foundation
class HotelDataLayer
{
    private static var hotelDataLayer : HotelDataLayer? = nil
    var db: OpaquePointer?
    var dbPath: String = ""
    private init()
    {
         dbPath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("Demo.db").path
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
    func closeDatabase()
    {
        if db != nil
        {
            let result = sqlite3_close(db)
            
            if result == SQLITE_OK
            {
                print("Database closed successfully.")
            }
            else
            {
                print("Error closing database: \(result)")
            }
        }
    }
}

