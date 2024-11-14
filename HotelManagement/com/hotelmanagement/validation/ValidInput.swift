import Foundation
struct ValidInput
{
    static func getName(inputName : String) -> String
    {
        while (true)
        {
            print (inputName,terminator: "")
            let name = readLine()!
            if name.nameValidation(name : name)
            {
                return name
            }
            else
            {
                print ("Please enter a valid name")
            }
        }
    }
    static func getPhoneNo( inputName : String) -> Int64
    {
        while (true)
        {
            print (inputName,terminator: "")
            if let phoneNoString = readLine(), let phoneNo = Int64(phoneNoString), phoneNoString.count == 10
            {
                if Validation.phoneValidation(phoneNo: phoneNoString)
                {
                    return phoneNo
                }
                else
                {
                    print("Please enter a valid phone number.")
                }
            }
            else
            {
                print("Invalid input. Please enter a 10-digit phone number.")
            }
        }
    }
    static func getAddress (inputName : String) -> String
    {
        while (true)
        {
            print (inputName,terminator: "")
            let address = readLine()!
            if address.addressValidation(address: address)
            {
                return address
            }
            else
            {
                print("Please enter a valid address")
            }
        }
    }
    static func getEmail (inputName : String) -> String
    {
        while (true)
        {
            print (inputName,terminator: "")
            let email = readLine()!
            if Validation.emailValidation(email: email)
            {
                return email
            }
            else
            {
                print ("Please enter a valid email")
            }
        }
    }
    static func getAmenities (inputName : String) -> [String]
    {
        var amenities : [String] = []
        while (true)
        {
            print (inputName,terminator: "")
            let amenitie = readLine()!
            if !amenitie.isEmpty
            {
                amenities.append(amenitie)
            }
            print("Enter 1 to enter to finish",terminator: "")
            if readLine() == "1"
            {
                return amenities
            }
        }
    }
    static func getCapacity (inputName : String) -> Int
    {
        while (true)
        {
            print (inputName,terminator: "")
            if let capacitys = readLine(), let capacity = Int(capacitys)
            {
                if capacity.capacityValidation(capacity: capacity)
                {
                    return capacity
                }
                else
                {
                    ValidInput.alert(msg : "Please enter a valid Number")
                }
            }
            else
            {
                ValidInput.alert(msg: "Please enter a valid Number")
            }
        }
    }
    static func getRoomAmenities (inputName : String) -> [String]
    {
        var amenities : [String] = []
        while (true)
        {
            print (inputName,terminator: "")
            let amenitie = readLine()!
            if !amenitie.isEmpty
            {
               let amenitiee = HotelDataLayer.getInstance().hotelProperty.ammenitiesProperty
               for k in amenitiee
                {
                    if amenitie.lowercased() == k.lowercased()
                    {
                         amenities.append(amenitie)
                    }
                }
            }
            print("Enter 1 to enter to finish : " , terminator: "")
            if readLine() == "1"
            {
                return amenities
            }
        }
    }
    
    static func alert (msg : String)
    {
        print (msg)
    }
   
    static func getRoomType(inputName : String) -> RoomType
    {
        while (true)
        {
            for rooms in RoomType.allCases
            {
                print ("\(rooms.rawValue) . \(rooms)")
            }
            print (inputName,terminator: "")
            if let room_type = readLine(), let roomType = Int(room_type)
            {
                if roomType.roomTypeValidation(roomType : roomType)
                {
                    return RoomType(rawValue: roomType)!
                }
                else
                {
                    ValidInput.alert(msg : "Please enter a valid room type")
                }
            }
            else
            {
                ValidInput.alert(msg: "Please enter a valid option")
            }
        }
    }
    
    static func  getBedType(inputName : String) -> BedType
    {
        while (true)
        {
            for beds in BedType.allCases
            {
                print ("\(beds.rawValue) . \(beds)")
            }
            print (inputName,terminator: "")
            if let bed_type = readLine(), let bedType = Int(bed_type)
            {
                if bedType.bedTypeValidation(bedType : bedType)
                {
                    return BedType(rawValue: bedType)!
                }
                else
                {
                    ValidInput.alert(msg : "Please enter a valid room type")
                }
            }
            else
            {
                ValidInput.alert(msg: "Please enter a valid option")
            }
        }
    }
    
    static func getPrice (inputName : String) -> Float
    {
        while (true)
        {
            print (inputName,terminator: "")
            if let amount = readLine(), let price = Float(amount)
            {
                if price.priceValidation(price : price)
                {
                    return price
                }
                else
                {
                    ValidInput.alert(msg : "Please enter a valid price")
                }
            }
            else
            {
                ValidInput.alert(msg: "Please enter a valid price")
            }
        }
    }
    static func getDate (inputName : String) -> Date
    {
        while (true)
        {
            print (inputName,terminator: "")
            if let date = readLine()
            {
                let (isValid,date) =  Validation.isValidConvertDate(dateString :  date)
                if  isValid
                {
                    return date!
                }
                else
                {
                    ValidInput.alert(msg : "Please enter a valid date or Booking only after 1 month")
                }
            }
        }
    }
    
    static func getPassword (inputName : String) -> String
    {
        while(true)
        {
            print (inputName,terminator: "")
            if let password = readLine()
            {
                if  password.passwordValidation(password : password)
                {
                    return password
                }
                else
                {
                    ValidInput.alert(msg : "Please enter a valid password")
                }
            }
        }
    }
    static func getusername(inputName : String) -> String
    {
        while (true)
        {
            print (inputName,terminator: "")
            let name = readLine()!
            if Validation.usernameValidation(name : name)
            {
                return name
            }
            else
            {
                print ("This username already exixsts. Please enter a different username")
            }
        }
    }
    
    static func getBookingStatus(inputName : String) -> BookingStatus
    {
        while (true)
        {
            for roomBooking in BookingStatus.allCases
            {
                print ("\(roomBooking.rawValue) . \(roomBooking)")
            }
            print (inputName,terminator: "")
            if let room = readLine(), let roomBooking = Int(room)
            {
                if roomBooking.roomBookingValidation(roomBooking : roomBooking)
                {
                    return BookingStatus(rawValue : roomBooking)!
                }
                else
                {
                    ValidInput.alert(msg : "Please enter a valid room type")
                }
            }
            else
            {
                ValidInput.alert(msg: "Please enter a valid option")
            }
        }
    }
}
 
