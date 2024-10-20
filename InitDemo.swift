class Person 
{
    var  name  : String
    var  id : Int 
    // designated init
    init(name : String ,id : Int )
    {
        self.name = name
        self.id = id
    }
    // convenience init
    convenience  init (name : String )
    {
        self.init (name: name, id: 0)
    }
    // default init
    init ()
    {
        self.name = ""
        self.id = 0
    }
}
var priya : Person = Person(name : "priya", id : 23)
print (priya.name)
var raj : Person = Person(name : "raj")
print (raj.name)


