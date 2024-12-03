import CryptoKit
import Foundation
extension String
{
    func nameValidation(name : String) ->  Bool
    {
       if (name.count>=3)
       {
           for char in name
           {
               if (char>="a" && char<="z" || char>="A" && char<="Z" || char == ".")
               {
                   return true
               }
               else
               {
                   return false
               }
           }
           return true
       }
       return false
    }
    func passwordValidation(password : String) -> Bool
    {
       if (password.count>6)
       {
           return true
       }
       return false
    }
    
    func addressValidation(address : String) -> Bool
    {
        if (address.count>10)
        {
            return true
        }
        return false
    }
}
