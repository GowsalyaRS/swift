import UIKit

 /*
    Function is code resuablity
 */
 
func printHello()    // No argument and no return type
{
    print("Hello")
}
printHello()

func printHello(name: String)   // argument but no return type
{
    print("Hello \(name)")
}
printHello(name: "zoho")

func printHello(name: String, age: Int) -> String  // argument and return type
{
      return ("Hello \(name), your age is \(age)")
}
printHello(name : "zoho ", age: 25)

func printHello(name: String, age: Int ,salary: Float) -> (String,Int,Float)  // argument and multiple return values
{
      return (name,age,salary)
}
var companyData : (name : String, age : Int, salary : Float) = printHello(name : "zoho ", age: 25, salary: 25000)  // Tuples multiple values stored in single compound
print(companyData.0)   // tuples can access index based start with 0
print(companyData.1)
print(companyData.salary)  // and also name to calling

 
func add (a: Int, b: Int = 10) -> Int   // default parameter
{
    return a+b;
}
 print (add(a:10))

func total (a : Int...) -> Int    // variadic type of argument to provide n th number of values pass
{
    var count = 0;
    for i in a
    {
        count += i
    }
    return count
}
var count : Int = total (a : 1,2,3,4,5)
print (count)

func outerFunction (val : Int)   // Nested Function methods inside another method can also access 
{
    func innerFunction () -> Int
    {
        return val
    }
    var result : Int = innerFunction()
    print (result)
    
}
outerFunction(val : 29)
