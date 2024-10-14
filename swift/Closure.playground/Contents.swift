import UIKit

/*
   closure is a self contained block of code that can be passed around and use your code
 */

func closureExample(val : Int)
{
    let closure: (Int) -> Int =
    { number in
        return number * 2
    }
    print(closure(val))
}
closureExample(val : 20)


func performOperation(on number: Int, operation: (Int) -> Int) -> Int   // Trailing closure
{
    return operation(number)
}
let result = performOperation(on: 5)
{
    number in
    return number * number
}
print(result)
