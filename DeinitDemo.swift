class Phone 
{
    var name : String
    var amount : Float
    init? (name : String ,amount : Float)
    {
       self.name = name 
       self.amount = amount 
    }
    deinit 
    {
        print("Any clean up activities")
    }
}
var redmi : Phone? = Phone (name: "readmi", amount: 20000.0)!
redmi =  nil


