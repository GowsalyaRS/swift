

import Foundation

 /*  Optional Values
  */

   var age : Int? = 20   // ? declare optional values
   var ages  = age!     // ! forcing unwrapping values
   print ( "Age is \(ages)")
   
/*
     Nil coliescing operator
     this operator used default values provide in optional values
 
 */
    print ("Enter your name")
    var name : String? = readLine()
    name = name ?? "Swift"
    print("Hello \(name!)")

/*
     custom operator
*/

infix operator  ** : AssignmentPrecedence

func  ** (num1 : Int , num2 : Int) -> Int
{
    return (num1 * num2)
}
print ( "Two Number multiply simple use  **   ",2 ** 3)
