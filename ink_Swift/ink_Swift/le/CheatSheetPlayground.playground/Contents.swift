//: Playground - noun: a place where people can play

import UIKit

print("Cheat Sheet and Quick Reference")
//
////Class Implementation
//
//class MyClass :OptionalSuperClass,OptionalProtocol1,OptionalProtocol2{
//    var myProperty:String
//    var myOptionalProperty:String?
//    //More properties
//    override init(){
//        myProperty = "Foo"
//    }
//    //More methods
//}
//
////Methods
//
//func doIt() -> Int { return 0
//}
//
//func doIt(a:Int) -> Int {
//    return a
//}
//func doIt(a:Int, b:Int) -> Int {
//        return a+b
//}
////Creating/Using an Instance
//var a = MyClass()
//a.myProperty
//a.doIt()
//a.doIt(a:1)
//a.doIt(a:2, b:3)
//
////Enums
//enum CollisionType: Int { case player = 1
//    case enemy = 2
//}
//var type = CollisionType.player
//
////Declaring Variables
//var mutableDouble:Double = 1.0 mutableDouble = 2.0
//let constantDouble:Double = 1.0 // constantDouble = 2.0 // error
//var mutableInferredDouble = 1.0 var optionalDouble:Double? = nil
//optionalDouble = 1.0
//if let definiteDouble = optionalDouble {
//definiteDouble
//}
//
////Control Flow
//var condition = true if condition {
//} else {
//}
//var val =5 switch val { case 1:
//    "foo"
//case 2: "bar"
//default:
//    "baz"
//}
//// omits upper value, use ... to include
//for i in 0..<3 {
//}
//
//
//String Quick Examples
//var personOne = "Ray"
//var personTwo = "Brian"
//var combinedString = "\(personOne): Hello, \(personTwo)!"
//var tipString = "2499"
//var tipInt = Int(tipString)
//tipString = "24.99"
//var tipDouble = Double(tipString)
//
////Array Quick Examples
//
//var person1 = "Ray"
//var person2 = "Brian"
//var array:[String] = [person1, person2]
//array.append("Waldo")
//for person in array {
//    print("person: \(person)")
//}
//
//var waldo = array[2]
//
////Dictionary Quick Examples
//
//var dict:[String: String] = ["Frog": "Kermit", "Pig": "Ms. Piggy", "Weirdo": "Gonzo" ]
//dict["Weirdo"] = "Felipe" dict["Frog"] = nil // delete frog for (type, muppet) in dict {
//print("type: \(type), muppet: \(muppet)")
//}
