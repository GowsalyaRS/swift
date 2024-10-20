struct Person  : Equatable
{
    var  name  : String
    var  id : Int 
    // failable init
    init?(name : String ,id : Int)
    {
        if id <= 0
        {
            return nil
        }
        self.name = name 
        self.id = id
    }
}
if var person2 : Person = Person(name: "Bob", id: -1) 
{
    print("\(person2.name) is \(person2.id) years old.")
    person2.name = "kkmkm"
    person2.id = 12
    print (person2)
} 
else
{
    print("Initialization failed for person2.") 
}
var person : Person! = Person (name : "bjbn",id : 12)
print (person.name , person.id)