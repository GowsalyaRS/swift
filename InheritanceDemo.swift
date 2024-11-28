import Foundation
class Vehicle
{
    var make: String
    var model: String
    
    init(make: String, model: String)  
    {
        self.make = make
        self.model = model
    }
    var getMake : String 
    {
        get 
        {
           return make
        }
        set (newvalues)
        {
           self.model = newvalues
        }
    }
    func displayInfo() {
        print("Vehicle: \(make) \(model)")
    }
}
class Car : Vehicle
{
    var numberOfDoors: Int
    init( make: String, model: String ,numberOfDoors: Int) {

        self.numberOfDoors = numberOfDoors
        super.init(make: make, model: model)
         self.make = "ede"
    }
    override func displayInfo() 
    {
        super.displayInfo()
        print("Number of doors: \(numberOfDoors)")
    }
}

var car : Vehicle = Car(make: "Toyota", model: "Corolla", numberOfDoors: 4)
car.displayInfo()

