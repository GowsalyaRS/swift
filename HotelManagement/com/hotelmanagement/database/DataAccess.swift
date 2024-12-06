import SQLite3
import Foundation
struct DataAccess : DatabaseUtility
{
    
    static var object : DatabaseUtility.Type? = nil
    static func  injectDatabase (using databaseUtility: DatabaseUtility.Type)
    {
        object = databaseUtility
    }
    static func openDatabase() throws
    {
       try object?.openDatabase()
    }
    static func createTable(createTableQuery: String) throws
    {
        try object?.createTable(createTableQuery: createTableQuery)
    }
    static func insertRecord(query: String) throws
    {
       try object?.insertRecord(query: query)
    }
    static func executeQueryData(query: String) throws -> [[String: Any]]
    {
        return try object?.executeQueryData(query: query) ?? []
    }
    static func closeDatabase() throws
    {
        try object?.closeDatabase()
    }
}
