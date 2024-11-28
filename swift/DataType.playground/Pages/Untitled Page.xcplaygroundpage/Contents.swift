import UIKit
/*
     Int   - (whole numbers)
     Int8  - 1 byte
     Int16 - 2 byte
     Int32 - 4 byte
     Int64 - 8 byte
     UInt  - (only positive values)
     Int   - depend on OS 32 bit or 64 bit
 */

var  num1 : Int = 10
var  num2  : Int8 = 123
print(num1)
print(num1 + (Int)(num2))  // type casting

/*   Double & Float
     Float  - 4 byte (up to 7 decimal)
     Double - 8 byte (up to 15 decimal)
 */

var num3 : Double = 10.299000
var  num4  : Float = 123.5670
print(num3,num4)

/*
     Bool  - only true or false values
 */

var  isValid : Bool = true
isValid = false
print (isValid)

/*
     charcter  -> use " " quotes with use inside single data
 */

let ch : Character = "A"
print (ch)

/*
    String - collection of character  with use "" quotes and """ quotes
 */

let str : String = "Hello World"
print (str)

let str1 : String = """
                       1.Admin 
                       2.User
                       3.Exit
                    """

// explore some String func
print (str1)
print (str.count)
print(str.first)
print(str.last)
print(str.isEmpty)
print(str.hasPrefix("Hello"))
print(str.hasSuffix("World"))
print(str.uppercased())
print(str.lowercased())
print(str.replacingOccurrences(of: "World", with: "Swift"))
print(str.split(separator: " "))
