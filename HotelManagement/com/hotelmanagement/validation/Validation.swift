import Foundation
import CryptoKit
struct  Validation
{
    private static let format: String = "dd-MM-yyyy"
    private static let dateFormatter = DateFormatter()
    
    static func emailValidation(email : String) -> Bool
    {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
    }
    
    static func phoneValidation(phoneNo : String) -> Bool
    {
        let phoneRegex = "^(\\+91[\\s\\-]?)?([6-9]{1}[0-9]{9})$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: phoneNo)
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
    
    static func usernameValidation(name : String) ->  Bool
    {
        let matchingAuthendication = HotelDataLayer.getInstance().authendicationsProperty
                .filter { $0.getUsername() == name }
            
        return matchingAuthendication.isEmpty
    }
}
