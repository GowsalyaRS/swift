import Foundation
enum DatabaseError: Error
{
    case executionFailed(msg : String)
    case tableCreationFailed(msg : String)
    case preparationFailed(msg : String)
    case finalizationFailed(msg : String)
    case insertFailed(msg : String)
    case updateFailed(msg : String)
    case deleteFailed(msg : String)
    case noRecordFound(msg : String)
}
extension DatabaseError: LocalizedError
{
    var localizedDescription: String
    {
        switch self
        {
         case .executionFailed(let msg),
              .tableCreationFailed(let msg),
              .preparationFailed(let msg),
              .finalizationFailed(let msg),
              .deleteFailed(let msg),
              .updateFailed(let msg),
              .noRecordFound(let msg),
              .insertFailed(let msg):
            return msg
        }
    }
}
 
