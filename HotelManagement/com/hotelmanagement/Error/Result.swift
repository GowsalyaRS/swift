import Foundation
enum Result : Error
{
    case success(msg : String)
    case failure(msg : String)
}
extension Result : LocalizedError
{
    var localizedDescription: String
    {
        switch self
        {
          case .success(let msg):
            return msg
          case .failure(let msg):
            return msg
        }
    }
}
