import UIKit
/*
     arrays are store data in continous memory loaction
     duplicate values are allowed
 */
var array : [Int] = [1,2,3,4,5]
print(array)

for i in array.indices
{
    print(array[i])  // Iterator the array values
}

array.remove(at:2)  // 2 nd index delete
print (array)

array.insert(10, at: 2 )    // 2nd index added new values
print(array)

array.append(100)    //  add data in array

print(array.count)   // arrays counting

print(array.startIndex , "starting index " ,array.endIndex - 1 , "ending index")

print (array.capacity)   // length of array

print (array.isEmpty)   // arrays is  inside values or not

print (array.hashValue)  // Hash values print

