import Foundation
open class Animal 
{
   // stored property
   var name : String 
   var age : Int
   // Type property 
   static var sleepingHours : Int = 8
   init()
   {
      name = ""
      age = 0
   }
   init(name : String , age : Int) 
   {
      self.name = name
      self.age = age
   }
   // computed property
   var getName : String
   {
      return name
   }
   var getAge : Int
   {
      return age
   }
   var animalDetailsPrint : String 
   {
      return ("Name is \(name)  age is \(age)")
   }
}
var dog  : Animal  = Animal(name : "rosie", age : 2)
print (dog.animalDetailsPrint)
print (Animal.sleepingHours)


