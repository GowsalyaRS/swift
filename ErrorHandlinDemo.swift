 // error protocal complesary extends in error msg 
enum FileError : Error
{
    case fileNotFound,Unreadable
}
class ErrorHandlingDemo 
{
    var file : String
    init (file : String)
    {
       self.file = file
    }
    // throws (Any) or throws (never) or throws(Any special type use)
    func readFile(filename : String) throws(FileError) -> String
    {
       guard filename == file  else 
       {
           throw FileError.fileNotFound
       }
       return ("Your file is added successfully")
    }
   func writeFile(filename : String) throws(FileError) -> String
    {
       guard filename == file  else 
       {
           throw FileError.Unreadable
       }
       return ("Your file write a  content successfully")
    }
}
var demo : ErrorHandlingDemo  = ErrorHandlingDemo(file :"abc.file")

// do catch block 
do 
{
  let content = try demo.readFile(filename: "xyz.file") 
  print (content)
}
catch FileError.fileNotFound
{
   print("File Not Found")
}
catch FileError.Unreadable
{
    print("Unreadable")
}
catch 
{
    print ("Unpredictable Error")
}

 let content = try? demo.readFile(filename: "xyz.file") 
 //print(content) 
 // print(content!)  // force unwrapping 


    var  review = try? demo.writeFile(filename: "xyz.file") 
    print (review)  // optional chaning 

    var  reviews = try! demo.writeFile(filename: "abc.file") 
    print (reviews)  // forced unwrapping 