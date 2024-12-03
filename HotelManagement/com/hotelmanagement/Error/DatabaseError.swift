import Foundation
enum DatabaseError: Error
{
    case executionFailed(msg : String)
    case tableCreationFailed(msg : String)
    case preparationFailed(msg : String)
    case finalizationFailed(msg : String)
}
extension DatabaseError : LocalizedError
{
    var localizedDescription: String
    {
        switch self
        {
          case  .executionFailed(let message),
                .tableCreationFailed(let message),
                .preparationFailed(let message),
                .finalizationFailed(let message) : 
            return message
        }
    }
}
 
