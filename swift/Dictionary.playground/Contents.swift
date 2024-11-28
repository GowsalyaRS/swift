import UIKit

/*
     Key - value pair is Dictionary.
     Dictionary is Unordered key.
     key same to provide modify the values
 */
 
var dictionary: [String: Int] = [:]
dictionary["Swift"] = 100
dictionary["Swift"] = 500

print(dictionary)

dictionary.removeValue(forKey: "Swift")
print(dictionary)   // remove key

dictionary.updateValue(1000, forKey: "Swift")
print(dictionary)   // update values

var dic : [String: Int] = ["zoho": 1, "HCL": 2, "TATA": 3, "4i apps": 4, "apple": 5]
dictionary.merge(dic) { $1 }
print(dictionary)    // merge the dictionary

dictionary.forEach
{
    print($0 , " - " , $1)   // Iterating the dictionary values
}

dictionary.keys.forEach
{
    print($0)       // key values only iterating
}

dictionary.values.forEach
{
    print($0)      // values are iterating
}
print(dictionary.startIndex , " - " ,dictionary.endIndex)

let value = dictionary["zoho"]   // key provide values get
print (value)
