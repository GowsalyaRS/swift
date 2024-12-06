protocol DatabaseUtility
{
    static func openDatabase() throws
    static func createTable(createTableQuery: String) throws
    static func insertRecord(query: String) throws
    static func executeQueryData(query: String) throws -> [[String: Any]]
    static func closeDatabase() throws
}
