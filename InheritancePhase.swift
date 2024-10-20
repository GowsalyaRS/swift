class Vehicle {
    var type: String
    var wheels: Int
    // Designated initializer
    init(type: String, wheels: Int) {
        self.type = type
        self.wheels = wheels
    }
}
class Car: Vehicle {
    var model: String
    // Designated initializer
    init(model: String, type: String, wheels: Int) 
    {
        self.model = model
        // Phase 1: Initialize stored properties of the Car class
        super.init(type: type, wheels: wheels) 
        // Phase 2: Customize further
        print("Car initialized: \(model), Type: \(type), Wheels: \(wheels)")
    }
}
class SportsCar: Car {
    var topSpeed: Int
    // Designated initializer
    init(model: String, type: String, wheels: Int, topSpeed: Int) {
        self.topSpeed = topSpeed
        // Phase 1: Initialize stored properties of the SportsCar class
        super.init(model: model, type: type, wheels: wheels) 
        // Phase 2: Customize further
        print("SportsCar initialized: \(model), Top Speed: \(topSpeed) km/h")
    }
}
let myCar = SportsCar(model: "Ferrari", type: "Coupe", wheels: 4, topSpeed: 350)
