//: Playground - noun: a place where people can play

import UIKit
 
var str = "Hello, playground"
// Strings
var hello = "Hello"
hello = hello + " World"
print(hello)



var alternateGreeting = hello
alternateGreeting += " and beyond!"
print(alternateGreeting)
print(hello)

// Numeric types and conversion
var radius = 4
let pi = 3.14159
var area = Double(radius) * Double(radius) * pi

// Booleans
let alwaysTrue = true

// Tuples 元组
var address = (number: 742, street: "Evergreen Terrace")

print(address.number)
print(address.street)

print(address.0)
print(address.1)

let (house, street) = address
print(house)
print(street)

// String interpolation
print("I live at \(house), \(street)")
let strr = "I live at \(house + 10), \(street.uppercased())"
print(strr)

// For loops and ranges
let greeting = "Swift by Tutorials Rocks!"

var range = 1...5
for i in range {
    print("\(i) - \(greeting)")
}

// While loops
var i = 0
while i < 5 {
    print("\(i) - \(greeting)")
    i += 1
}

// If statements
for i in 1...5 {
    if i == 5 {
        print(greeting.uppercased())
    } else {
        print(greeting)
    }
}

// Switch statements
var direction = "up"

switch direction {
case "down":
    print("Going Down!")
case "up":
    print("Going Up!")
default:
    print("Going Nowhere")
}

var score = 570

var prefix: String
switch score {
case 1..<10:
    print("novice")
case 10..<100:
    print("proficient")
case 100..<1000:
    print("rock-star")
default:
    print("awesome")
}





//section 1

var strwstr: String!
print(strwstr)

if let unwrappedStr = strwstr {
    print("Unwrapped! \(unwrappedStr.uppercased())")
} else {
    print("Was nil")
}

if strwstr != nil {
    strwstr = strwstr.lowercased()
    print(strwstr)
}

var maybeString: String? = "Hello Swift by Tutorials!"
let uppercase = maybeString?.uppercased()

var array: [Int] = [1, 2, 3, 4, 5]
print(array[2])
array.append(6)
array.append(7)
array.append(8)
array.append(9)
array.append(10)
print(array)

// Challenge solution:
array.remove(at: 8)
array.remove(at: 6)
array.remove(at: 4)
array.remove(at: 2)
array.remove(at: 0)
print(array)

// Challenge solution:
var anyArray: [AnyObject] = []
anyArray.append(1 as AnyObject)
anyArray.append("1" as AnyObject)
print(anyArray)

var dictionary: [Int:String] = [1: "Dog", 2: "Cat"]
print(dictionary[1])
dictionary[3] = "Mouse"
dictionary[3] = nil
print(dictionary)

// Challenge solution:
dictionary.updateValue("Elephant", forKey: 2)
print(dictionary)

print(dictionary[1])

if let value = dictionary[1] {
    print("Value is \(value)")
}

var dictionaryA = [1: 1, 2: 4, 3: 9, 4: 16]
var dictionaryB = dictionaryA
print(dictionaryA)
print(dictionaryB)

dictionaryB[4] = nil
print(dictionaryA)
print(dictionaryB)

var arrayA = [1, 2, 3, 4, 5]
var arrayB = arrayA
print(arrayA)
print(arrayB)

arrayB[0] = 10
print(arrayA)
print(arrayB)

let constantArray = [1, 2, 3, 4, 5]
//constantArray.append(6)
//constantArray.removeAtIndex(0)

// Challenge solution:
let constantDictionary: [Int:String] = [1: "One", 2: "Two", 3: "Three"]
//constantDictionary.updateValue("Four", forKey: 4) ///< Errors when uncommented

// FunctionBasics

// returns the square of a number
func square(number: Double) -> Double {
    return number * number
}

// assigns the square function to a constant
let operation:(Double) -> Double = square;

// computes a pythagorean triple
let a = 3.0, b = 4.0
let c = sqrt(operation(a) + operation(b))
print(c)

// a function for logging doubles with a fixed precision
func logDouble(number:Double) {
    print(String(format: "%.2f", number))
}

var logger:(Double) -> () = logDouble
logger(c)

// Generics

func checkAreEqual<T: Equatable>(value: T, expected: T, message: String) {
    if expected != value {
        print(message)
    }
}


var input = 3
checkAreEqual(value: input, expected: 2, message: "An input value of '2' was expected")

input = 47
checkAreEqual(value: input, expected: 47, message: "An input value of '47' was expected")

var inString = "cat"
checkAreEqual(value: inString, expected: "dog",
              message: "An input value of 'dog' was expected")

//pass by refrece
func square( number: inout Double) {
    number = number * number
}




// struct parems
struct Person {
    var age = 34, name = "Colin"

    mutating func growOlder() {
        self.age += 1
    }
}

func celebrateBirthday( cumpleañero: inout Person) {
    print("Happy Birthday \(cumpleañero.name)")
    cumpleañero.growOlder()
}

var person = Person()
celebrateBirthday(cumpleañero: &person)
print(person.age)


 



