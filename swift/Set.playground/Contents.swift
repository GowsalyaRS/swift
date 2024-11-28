import UIKit
 /*
       set is unordered
       Duplicate not accepted
  */
var set = Set<Int>()
set.insert(1)              // insert values
set.insert(2)
set.insert(3)
set.insert(4)
set.insert(5)

print ((set.contains(1)))   // contains values

print (set.remove(3))      // Any values deleted
print (set)
    
print (set.subtracting([1, ]))   // sub String values

print (set.intersection([3,4,5,1]))    // checking multiple values but available values provide

print (set.first )   // first value is find it

print (set.startIndex ,set.endIndex)

print(set.capacity)   // capacity of the set
