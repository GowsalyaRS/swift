enum DatabaseError: Error
{
    case queryExecutionFailed(String)
    case tableCreationFailed(String)
    case dataInsertionFailed(String)
}
