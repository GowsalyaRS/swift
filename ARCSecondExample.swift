 class Parent {
    var name: String
    var children: [Child] = [] 
    init(name: String) 
    {
        self.name = name
    }
    func addChild(_ child: Child) {
        children.append(child)
        child.parent = self 
    }
}
class Child 
{
    var name: String
    unowned var parent: Parent? 
    init(name: String) 
    {
        self.name = name
    }
}
let parent = Parent(name: "Ab")
let child1 = Child(name: "Cd")
let child2 = Child(name: "Ef")
parent.addChild(child1)
parent.addChild(child2)
if let parentName = child1.parent?.name {
    print("\(child1.name)'s parent is \(parentName)") 
}
