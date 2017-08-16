//: Playground - noun: a place where people can play

import UIKit

sin(45 * Double.pi / 180)
// 0.7071067811865475
cos(135 * Double.pi / 180)
// -0.7071067811865475

sqrt(2.0)
// 1.414213562373095

max(5, 10)
// 10
min(-5, -10)
// -10

var variableNumber: Int = 42
variableNumber = 0
variableNumber = 1_000_000

var integer: Int = 100
var decimal: Double = 12.5
integer = Int(decimal)

let hourlyRate: Double = 19.5
let hoursWorked: Int = 10
let totalCost: Double = hourlyRate * Double(hoursWorked)

let oneThird = 1.0 / 3.0
let oneThirdLongString = "One third is \(oneThird) as a decimal."
print(oneThirdLongString)

let coordinates = (2, 3)
print("Value is \(coordinates.0)\(coordinates.1)")


var hoursWorked45 = 45
var price = 0
if hoursWorked > 40 {
    let hoursOver40 = hoursWorked - 40
    price += hoursOver40 * 50
    hoursWorked45 -= hoursOver40
}
price += hoursWorked45 * 25
print(price)


let count = 10
var sum = 0
for i in 1...count {
    sum += i }

sum


func printMultipleOf(multiplier: Int, and value: Int) {
    print("\(multiplier) * \(value) = \(multiplier * value)")
}
printMultipleOf(multiplier: 4, and: 2)

func pprintMultipleOf(_ multiplier: Int, _ value: Int) {
    print("\(multiplier) * \(value) = \(multiplier * value)")
}
pprintMultipleOf(4, 2)


func multiply(_ number: Int, by multiplier: Int) -> Int {
    return number * multiplier
}
let result = multiply(4, by: 2)




func calculateNumberOfSides(shape: String) -> Int? {
    switch shape {
    case "Triangle":
        return 3
    case "Square":
        return 4
    case "Rectangle":
        return 4
    case "Pentagon":
        return 5
    case "Hexagon":
        return 6
    default:
        return nil
    }
}

func maybePrintSides(shape: String) {
    let sides = calculateNumberOfSides(shape: shape)
    if let sides = sides {
        print("A \(shape) has \(sides) sides.")
    } else {
        print("I don't know the number of sides for \(shape).")
    }
}
maybePrintSides(shape: "Pentagon")
//func maybePrintSides(shape: String) {
//    guard let sides = calculateNumberOfSides(shape: shape) else {
//        print("I don't know the number of sides for \(shape).")
//        return
//    }
//    print("A \(shape) has \(sides) sides.")
//}

var namesAndScores = ["Anna": 2, "Brian": 2, "Craig": 8, "Donna": 6]
print(namesAndScores)

var bobData = ["name": "Bob",
               "profession": "Card Player",
               "country": "USA"]
bobData.updateValue("CA", forKey: "state")

bobData["city"] = "San Francisco"

for (player, score) in namesAndScores {
    print("\(player) - \(score)")
}

for player in namesAndScores.keys {
    print("\(player), ", terminator: "") // no newline
}

//Closure basics
var multiplyClosure: (Int, Int) -> Int
multiplyClosure = { (a: Int, b: Int) -> Int in
    return a * b }

multiplyClosure = { (a: Int, b: Int) -> Int in
    a*b }
multiplyClosure = { (a, b) in
    a*b }
multiplyClosure = {
    $0 * $1 }

let mresult = multiplyClosure(4, 2)



func operateOnNumbers(_ a: Int, _ b: Int,
                      operation: (Int, Int) -> Int) -> Int {
    let result = operation(a, b)
    print(result)
    return result
}

let addClosure = { (a: Int, b: Int) in
    a+b }
operateOnNumbers(4, 2, operation: addClosure)

func addFunction(_ a: Int, _ b: Int) -> Int {
    return a + b }
operateOnNumbers(4, 2, operation: addFunction)

operateOnNumbers(4, 2, operation: { (a: Int, b: Int) -> Int in
    return a + b})


operateOnNumbers(4, 2, operation: { $0 + $1 })

operateOnNumbers(4, 2) {
    $0 + $1 }

let voidClosure: () -> Void = {
    print("Swift Apprentice is awesome!")
}
voidClosure()

let names = ["ZZZZZZ", "BB", "A", "CCCC", "EEEEE"]
names.sorted()

names.sorted {
    $0.characters.count > $1.characters.count
}

var prices = [1.5, 10, 4.99, 2.30, 8.19]
let largePrices = prices.filter {
    return $0 > 5
}

let salePrices = prices.map {
    return $0 * 0.9
}

let summ = prices.reduce(0) {
    return $0 + $1
}

let stock = [1.5:5, 10:2, 4.99:20, 2.30:5, 8.19:30]
let stockSum = stock.reduce(0) {
    return $0 + $1.key * Double($1.value)
}

let restaurantLocation = (2, 4)
let restaurantRange = 2.5
let otherRestaurantLocation = (7, 8)
let otherRestaurantRange = 1.5
// Pythagorean Theorem # $
func distance(from source: (x: Int, y: Int), to target: (x: Int, y: Int))
    -> Double {
        let distanceX = Double(source.x - target.x)
        let distanceY = Double(source.y - target.y)
        return sqrt(distanceX * distanceX + distanceY * distanceY)
}
func isInDeliveryRange(location: (x: Int, y: Int)) -> Bool {
    let deliveryDistance =
        distance(from: location,
                 to: restaurantLocation)
    let secondDeliveryDistance =
        distance(from: location,
                 to: otherRestaurantLocation)
    return deliveryDistance < restaurantRange ||
secondDeliveryDistance < otherRestaurantRange
}



class Person {
    var firstName: String
    var lastName: String
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
     
    }
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
}
let john = Person(firstName: "Johnny", lastName: "Appleseed")



protocol Account {
    var value: Double { get set }
    init(initialAmount: Double)
    init?(transferAccount: Account)
}

class BitcoinAccount: Account {
    var value: Double
    required init(initialAmount: Double) {
        value = initialAmount
    }
    required init?(transferAccount: Account) {
        guard transferAccount.value > 0.0 else {
            return nil
        }
        value = transferAccount.value
    }
}
var accountType: Account.Type = BitcoinAccount.self
let account = accountType.init(initialAmount: 30.00)
let transferAccount = accountType.init(transferAccount: account)!



func fibonacci(position: Int) -> Int {
    switch position {
    // 1
    case let n where n <= 1:
        return 0 // 2
    case 2:
        return 1
    // 3
    case let n:
        return fibonacci(position: n - 1) + fibonacci(position: n - 2)
    }
}
let fib15 = fibonacci(position: 15) // 377

