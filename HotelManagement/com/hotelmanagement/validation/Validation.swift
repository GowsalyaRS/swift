import Foundation
import CryptoKit
struct  Validation
{
    private static let format: String = "dd-MM-yyyy"
    private static let dateFormatter = DateFormatter()
    static func nameValidation(name : String) ->  Bool
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
    
    static func emailValidation(email : String) -> Bool
    {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
    }
    
    static func passwordValidation(password : String) -> Bool
    {
        if (password.count>6)
        {
            return true
        }
        return false
    }
    
    static func phoneValidation(phoneNo : String) -> Bool
    {
        let phoneRegex = "^(\\+91[\\s\\-]?)?([6-9]{1}[0-9]{9})$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: phoneNo)
    }
    
    static func addressValidation(address : String) -> Bool
    {
        if (address.count>10)
        {
            return true
        }
        return false
    }
    
    static  func capacityValidation(capacity: Int) -> Bool
    {
        if( capacity > 0)
        {
            return true
        }
        return false
    }
    
    static func roomTypeValidation(roomType : Int) -> Bool
    {
        if (RoomType(rawValue: roomType) != nil )
        {
             return true
        }
        return false
    }
    
    static func bedTypeValidation(bedType : Int) -> Bool
    {
        if (BedType(rawValue: bedType) != nil )
        {
             return true
        }
        return false
    }
    
    static func priceValidation(price : Float) -> Bool
    {
        if (price > 500)
        {
            return true
        }
        return false
    }
    
    static func hashPassword(password: String) -> String
    {
        let data = Data(password.utf8)
        let hash = SHA256.hash(data: data)
        return hash.map { String(format: "%02x", $0) }.joined()
    }
    
    static func isValidConvertDate(dateString: String) -> (Bool,Date?)
    {
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        if let date : Date = dateFormatter.date(from: dateString)
        {
            let currentDate = Calendar.current.startOfDay(for: Date())
            let futureDate = Calendar.current.date(byAdding: .day, value: 30, to: currentDate)!
            if date >= currentDate && date <= futureDate
            {
                return (true, date)
            }
            else
            {
                return (false, nil)
            }
        }
        return (false, nil)
    }
    
    static func generateDateArray(startDate: Date, numberOfDays: Int) -> [Date]
    {
        let calendar = Calendar.current
        var dates: [Date] = []
        for day in 0...numberOfDays
        {
            if let newDate = calendar.date(byAdding: .day, value: day, to: startDate)
            {
                dates.append(newDate)
            }
        }
        return dates
    }
    
    static func usernameValidation(name : String) ->  Bool
    {
        for authendication in  HotelDataLayer.getInstance().getAllAuthendications().values
        {
            if(authendication.getUsername() == name)
            {
                return false
            }
        }
        return true;
    }
    
    static func roomBookingValidation( roomBooking :Int ) ->  Bool
    {
        if (BookingStatus(rawValue: roomBooking ) != nil )
        {
             return true
        }
        return false
    }
   
    static func convertDate(date: Date) -> Date?
     {
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let currentDate = Date()
        if let date : Date = dateFormatter.date(from:  dateFormatter.string(from: currentDate))
        {
              return date
        }
         return nil
     }
    
    static func convertDateToString(date: Date) -> String?
    {
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm a"
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Kolkata")
        let currentDate = Date()
        let istDateString = dateFormatter.string(from: currentDate)
        return istDateString
    }
}
