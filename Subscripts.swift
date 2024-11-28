class Array2D {
    var arr: [[Int]]
    
    init() {
        arr = Array(repeating: Array(repeating: 0, count: 3), count: 3)
    }
    
    subscript(row: Int, col: Int) -> Int 
    {
        get 
        {
            return arr[row][col]
        }
        set
        {
            guard row >= 0 && row < arr.count && col >= 0 && col < arr[row].count else {
                print("Index out of bounds")
                return
            }
            arr[row][col] = newValue
        }
    }
    
    func printArray() {
        for row in arr {
            print(row)
        }
    }
}

var array: Array2D = Array2D()
array.printArray()
array[2, 2] = 34  
array[1, 1] = 40
print(array[1, 0])  
array.printArray()
