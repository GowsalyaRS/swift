struct Bird
{
    var name : String
    var heightOfFly  : Float
    // lazy property
    lazy var energyTimeFlying : Float = 
    {
        return heightOfFly * 2
    }()
    var setName : String 
    {
        get 
        {
            return name;
        }
        set(newValues)
        {
            self.name = newValues
        }
    }
    // struct level property  
    static func flying() 
    {
        print("Birds can flying"); 
    }
}
// default member initialization only use struct
var parrot : Bird = Bird (name : "parrot" , heightOfFly : 23.4)
print(parrot.energyTimeFlying)
parrot.setName = "peacock"
print (parrot.setName)
Bird.flying()




