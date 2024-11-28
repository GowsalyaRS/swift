class Car 
{
    var name : String
    var price : Float
    weak var engine : Engine?
    init (name : String , price : Float)
    {
        self.name = name
        self.price = price
    }
    deinit 
    {
        print("Car reference is deallowcated")
    }
}
class Engine 
{
    var horsepower: Int
    var type: String
    init(horsepower: Int, type: String) 
    {
        self.horsepower = horsepower
        self.type = type
    }
    deinit 
    {
        print("Engine reference is deallowcated")
    }
}

var car : Car? = Car(name: "Swift", price: 1200000) 
var engine : Engine? = Engine(horsepower: 270, type: "myEngine")
car?.engine =  engine
engine = nil
car = nil
