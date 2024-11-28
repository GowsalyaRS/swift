import UIKit

/*
    Enumeration use type safety
 */
enum Days : Int
{
   case SUNDAY = 1,MONDAY,TUESDAY,WEDNESDAY,THURSDAY,FRIDAY,SATURDAY  // using raw values
}

var day : Days = .FRIDAY
var num  = day.rawValue  // print raw values
print (getDays(days: day))
print (num)
if let days = Days(rawValue: 1)
{
    print(days)
}
else
{
    print("Invalid day")
}

func getDays (days : Days) -> String
{
    switch days
    {
        case .SUNDAY:
            return ("Sunday")
        case .MONDAY:
            return ("Mondy")
        case .TUESDAY:
            return ("Tuesday")
        case .WEDNESDAY:
            return ("Wednesday")
        case .THURSDAY:
            return ("Thursday")
        case .FRIDAY:
            return ("Friday")
        case .SATURDAY:
            return ("Saturday")
    }
}

enum Result     // Associated values  different type and can attach additional information 
{
    case success (success : String )
    case  failure (Error : String)
}

let result = Result.success(success: "Your successful Joining the office in zoho")

switch result
{
 case .success(success: let message):
    print (message)
 case .failure(Error: let error):
    print (error)
}


