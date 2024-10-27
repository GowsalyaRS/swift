class Fees 
{
    var amount : Float? 
}
var fees : Fees?  = Fees()
print (fees?.amount)   // optional chaning 
// print (fees?.amount!)  // error at runtime  unwrapping optional values

// Multiple chaning 

class Appartment 
{
    var rooms : Room? 
}
class Room 
{
    var roomNumber : Int?
}
var kkAppartment :  Appartment? = Appartment()
print (kkAppartment?.rooms?.roomNumber)

// alternative unwrapping 
if let available =  kkAppartment?.rooms?.roomNumber
{
      print("Avilable room \(kkAppartment?.rooms?.roomNumber)");
}
else
{
    print ("room is unavailable")
}