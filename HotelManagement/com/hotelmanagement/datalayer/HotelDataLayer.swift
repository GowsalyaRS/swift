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
    func createTable(createTableQuery: String) throws
    {
        var createTableStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, createTableQuery, -1, &createTableStatement, nil) != SQLITE_OK {
            let errorMsg = String(cString: sqlite3_errmsg(db))
            throw DatabaseError.preparationFailed(msg : "Error preparing create table statement: \(errorMsg)")
        }
        if sqlite3_step(createTableStatement) != SQLITE_DONE
        {
            let errorMsg = String(cString: sqlite3_errmsg(db))
            throw DatabaseError.executionFailed(msg : "Error executing create table statement: \(errorMsg)")
        }
        if sqlite3_finalize(createTableStatement) != SQLITE_OK
        {
            let errorMsg = String(cString: sqlite3_errmsg(db))
            throw DatabaseError.finalizationFailed(msg :"Error finalizing create table statement: \(errorMsg)")
        }
    }
    func insertRecord(query: String) throws
    {
        var insertStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, query, -1, &insertStatement, nil) != SQLITE_OK
        {
            let errorMsg = String(cString: sqlite3_errmsg(db))
            print(errorMsg)
            throw DatabaseError.preparationFailed(msg :"Error preparing insert statement: \(errorMsg)")
        }
        if sqlite3_step(insertStatement) != SQLITE_DONE
        {
            let errorMsg = String(cString: sqlite3_errmsg(db))
            print(errorMsg)
            sqlite3_finalize(insertStatement)
            throw DatabaseError.executionFailed(msg : "Error inserting record: \(errorMsg)")
        }
        if sqlite3_finalize(insertStatement) != SQLITE_OK
        {
            let errorMsg = String(cString: sqlite3_errmsg(db))
            print(errorMsg)
            throw DatabaseError.finalizationFailed(msg : "Error finalizing query: \(errorMsg)")
        }
    }
    func executeQueryData(query: String) throws -> [[String: Any]] {
        var result = [[String: Any]]()
        var queryStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, query, -1, &queryStatement, nil) != SQLITE_OK {
            let errorMsg = String(cString: sqlite3_errmsg(db))
            throw DatabaseError.preparationFailed(msg : "Error preparing query: \(errorMsg)")
        }
        let columnCount = sqlite3_column_count(queryStatement)
        while sqlite3_step(queryStatement) == SQLITE_ROW
        {
            var row = [String: Any]()
            for columnIndex in 0..<columnCount
            {
                let columnName = sqlite3_column_name(queryStatement, columnIndex)
                
                if let columnName = columnName
                {
                    let columnString = String(cString: columnName)
                    switch sqlite3_column_type(queryStatement, columnIndex)
                    {
                    case SQLITE_TEXT:
                        if let columnText = sqlite3_column_text(queryStatement, columnIndex)
                        {
                             row[columnString] = String(cString: columnText)
                        }
                    case SQLITE_INTEGER:
                        let columnInt = sqlite3_column_int(queryStatement, columnIndex)
                        row[columnString] = Int(columnInt)
                    case SQLITE_FLOAT:
                        let columnFloat = sqlite3_column_double(queryStatement, columnIndex)
                        row[columnString] = columnFloat
                    case SQLITE_NULL:
                        row[columnString] = nil
                    default:
                        break
                    }
                }
            }
            
            result.append(row)
        }
        if sqlite3_finalize(queryStatement) != SQLITE_OK
        {
            let errorMsg = String(cString: sqlite3_errmsg(db))
            throw DatabaseError.finalizationFailed(msg : "Error finalizing query: \(errorMsg)")
        }
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

