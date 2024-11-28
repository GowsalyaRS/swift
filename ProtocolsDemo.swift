// class design to provide protocol
protocol Phone 
{
    var price : Float {get set }
    init (name : String , displaySize : Float , colour : String)
    func displayPhoneDetails()-> String 
}
// class to resposible of property and methods 
class Samsung : Phone 
{
    var price: Float
    var name : String
    var displaySize : Float
    var colour : String
    required init(name: String, displaySize: Float, colour: String) 
    {
        self.colour = colour
        self.name = name 
        self.displaySize = displaySize
        price = 0
    }
    var getSetPrice : Float 
    {
        get 
        {
            return price
        }
        set 
        {
            self.price = newValue
        }
    }
    func displayPhoneDetails() -> String 
    {
       return  "Phone Details \(name) , \(price) , \(colour) , \(displaySize)"  
    }
}

var phone : Phone = Samsung (name: "Samsung m31", displaySize: 6.1, colour: "black")
let samsung = phone as! Samsung
samsung.getSetPrice = 18000
print (samsung.displayPhoneDetails())
