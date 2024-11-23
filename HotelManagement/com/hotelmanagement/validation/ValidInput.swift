import Foundation
struct ValidInput
{
    static func getName(inputName : String) -> String
    {
        var count = 0
        while (true)
        {
            print (inputName,terminator: "")
            let name = readLine()!
            count += 1
            if name.nameValidation(name : name)
            {
                return name
            }
            else
            {
                print ("Please enter a valid name")
            }
            if(count % 2 == 0)
            {
                print("Press 0  to Exit")
                let num : String? = readLine()
                if num == "0"
                {
                    break ;
                }
            }
        }
        return ""
    }
    static func  isEmptyValidation (inputName : String) -> String
    {
        var count = 0
        while (true)
        {
            print (inputName,terminator: "")
            count += 1
            let name = readLine()!
            if name.isEmpty == false
            {
                return name
            }
            else
            {
                print ("Please enter a valid name")
            }
            if(count % 2 == 0)
            {
                print("Press 0  to Exit")
                let num : String? = readLine()
                if num == "0"
                {
                    break ;
                }
            }
        }
        return ""
    }
    static func getPhoneNo(inputName : String) -> Int64
    {
        var count = 0
        while (true)
        {
            print (inputName,terminator: "")
            count += 1
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
            if(count % 2 == 0)
            {
                print("Press 0  to Exit")
                let num : String? = readLine()
                if num == "0"
                {
                    break ;
                }
            }
        }
        return 0
    }
    static func getAddress (inputName : String) -> String
    {
        var count = 0
        while (true)
        {
            print (inputName,terminator: "")
            count += 1
            let address = readLine()!
            if address.addressValidation(address: address)
            {
                return address
            }
            else
            {
                print("Please enter a valid address")
            }
            if(count % 2 == 0)
            {
                print("Press 0  to Exit")
                let num : String? = readLine()
                if num == "0"
                {
                    break ;
                }
            }
        }
        return ""
    }
    static func getEmail (inputName : String) -> String
    {
        var count = 0
        while (true)
        {
            print (inputName,terminator: "")
            count += 1
            let email = readLine()!
            if Validation.emailValidation(email: email)
            {
                return email
            }
            else
            {
                print ("Please enter a valid email")
            }
            if(count % 2 == 0)
            {
                print("Press 0  to Exit")
                let num : String? = readLine()
                if num == "0"
                {
                    break ;
                }
            }
        }
        return ""
    }
    static func getAmenities (inputName : String) -> [String]
    {
        var count = 0
        var amenities : [String] = []
        while (true)
        {
            print (inputName,terminator: "")
            count += 1
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
            if(count % 2 == 0)
            {
                print("Press 0  to Exit")
                let num : String? = readLine()
                if num == "0"
                {
                    break ;
                }
            }
        }
        return []
    }
    static func getCapacity (inputName : String) -> Int
    {
        var count = 0
        while (true)
        {
            print (inputName,terminator: "")
            count += 1
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
            if(count % 2 == 0)
            {
                print("Press 0  to Exit")
                let num : String? = readLine()
                if num == "0"
                {
                    break ;
                }
            }
        }
        return 0
    }
    static func alert (msg : String)
    {
        print (msg)
    }
    static func getRoomType(inputName : String) -> RoomType?
    {
        var count = 0
        while (true)
        {
            for rooms in RoomType.allCases
            {
                print ("\(rooms.rawValue) . \(rooms)")
            }
            print (inputName,terminator: "")
            count += 1
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
            if(count % 2 == 0)
            {
                print("Press 0  to Exit")
                let num : String? = readLine()
                if num == "0"
                {
                    break ;
                }
            }
        }
        return nil
    }
    static func  getBedType(inputName : String) -> BedType?
    {
        var count = 0
        while (true)
        {
            for beds in BedType.allCases
            {
                print ("\(beds.rawValue) . \(beds)")
            }
            print (inputName,terminator: "")
            count += 1
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
            if(count % 2 == 0)
            {
                print("Press 0  to Exit")
                let num : String? = readLine()
                if num == "0"
                {
                    break ;
                }
            }
        }
        return nil
    }
    static func getPrice (inputName : String) -> Float
    {
        var count = 0
        while (true)
        {
            print (inputName,terminator: "")
            count += 1
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
            if(count % 2 == 0)
            {
                print("Press 0  to Exit")
                let num : String? = readLine()
                if num == "0"
                {
                    break ;
                }
            }
        }
        return 0
    }
    static func getDate (inputName : String) -> Date?
    {
        var count = 0
        while (true)
        {
            print (inputName,terminator: "")
            count += 1
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
            if(count % 2 == 0)
            {
                print("Press 0  to Exit")
                let num : String? = readLine()
                if num == "0"
                {
                    break ;
                }
            }
        }
        return nil
    }
    static func getPassword (inputName : String) -> String
    {
        var count = 0
        while(true)
        {
            print (inputName,terminator: "")
            count += 1
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
            if(count % 2 == 0)
            {
                print("Press 0  to Exit")
                let num : String? = readLine()
                if num == "0"
                {
                    break ;
                }
            }
        }
        return ""
    }
    static func getusername(inputName : String) -> String
    {
        var count = 0
        while (true)
        {
            print (inputName,terminator: "")
            count += 1
            let name = readLine()!
            if Validation.usernameValidation(name : name)
            {
                return name
            }
            else
            {
                print ("This username already exixsts. Please enter a different username")
            }
            if(count % 2 == 0)
            {
                print("Press 0  to Exit")
                let num : String? = readLine()
                if num == "0"
                {
                    break ;
                }
            }
        }
        return ""
    }
    
    static func getBookingStatus(inputName : String) -> BookingStatus?
    {
        var count = 0
        while (true)
        {
            for roomBooking in BookingStatus.allCases
            {
                print ("\(roomBooking.rawValue) . \(roomBooking)")
            }
            print (inputName,terminator: "")
            count += 1
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
            if(count % 2 == 0)
            {
                print("Press 0  to Exit")
                let num : String? = readLine()
                if num == "0"
                {
                    break ;
                }
            }
        }
        return nil
    }
}
 
