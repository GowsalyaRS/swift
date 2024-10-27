class Stack<T> {
    private var elements: [T] = []

    func push(_ element: T) {
        elements.append(element)
    }

    func pop() -> T? {
        return elements.popLast()
    }

    func peek() -> T? {
        return elements.last
    }

    func isEmpty() -> Bool {
        return elements.isEmpty
    }

    func size() -> Int {
        return elements.count
    }
}

let intStack = Stack<Int>()
intStack.push(1)
intStack.push(2)
intStack.push(3)
print("Int Stack Size: \(intStack.size())") 
print("Top Element: \(intStack.peek() ?? 0)") 
if let poppedElement = intStack.pop() {
    print("Popped Element: \(poppedElement)") 
}
print("Int Stack Size after pop: \(intStack.size())") 
let stringStack = Stack<String>()
stringStack.push("Hello")
stringStack.push("World")
print("String Stack Size: \(stringStack.size())") 
print("Top Element: \(stringStack.peek() ?? "Empty")") 
if let poppedElement = stringStack.pop() {
    print("Popped Element: \(poppedElement)") 
}
print("String Stack Size after pop: \(stringStack.size())") 
