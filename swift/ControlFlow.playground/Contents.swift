import UIKit

// collection of iterating data  -> for - in
 
var array : [Int] = [1,2,3,4,5]
for i in array
{
    print(i)
}
print ("-----------------------------")

// repeated while atleast execution of one times
var i : Int = 0
repeat
{
    print(i)
    i += 1
}
while i > 5
print ("-----------------------------")
        
 // while based on condition loop

var j : Int = 0
while j < 10
{
    print(j, terminator: " ")
    j += 1
}
print ("")
print ("-----------------------------")

// guard keyward use early exit of conditions

func validAge (age : Int )
{
    guard age > 18 else
    {
        print ("Your age is Invalid")
        return
    }
    print(" Your  \(age)  age is valid ")
}
validAge(age: 19)
 
print ("-----------------------------")

// one side range values printing on index based 

for i  in array [4...]
{
     print (i)
}

print ("-----------------------------")

for i  in array [...2]
{
     print (i)
}
