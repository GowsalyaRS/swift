import Foundation
@propertyWrapper
struct Capitalized
{
    private var name : String
    var wrappedValue : String 
    {
        get 
        {   
            return name
        }
        set 
        {
            name = newValue.capitalized
        }
    }
    init (wrappedValue : String)
    {
       self.name = wrappedValue.capitalized
    }
}

struct Emp 
{
    @Capitalized var name : String  
    let id : Int 
    init (name : String ,id : Int)
    {
        self.name = name 
        self.id = id
    }
}

var emp : Emp = Emp(name : "gji",id : 123)
print(emp.name , emp.id)
