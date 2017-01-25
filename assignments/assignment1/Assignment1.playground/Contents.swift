/**
 * Authors: Josiah Campbell & Derrick Bentley
 */

import Foundation

// Problem #1
let myString = "hello"
var cost = 3.14
let cnt: Int = 2
var shouldWe: Bool = true
// An integer constant assigned the value of 11 hexadecimal.
let myIntOr = Int("b", radix: 16)!
// An integer constant assigned the binary equivalent of decimal 10.
let myInt2 = Int("1010", radix: 2)!

// Problem #2
print("Orwell when he said 2 + 2 = 5. It actuall equals \(2.0 + 2.0)!")

// Problem #3
var bees: [String] = ["queen", "worker", "drone"]

print(bees[0])

bees.append("honey")

bees += ["are", "us"]

// Problem #4
for bee in bees {
    print(bee)
}

for (index, bee) in bees.enumerated() {
    print("Item #\(index) is \(bee)")
}

// Problem #5
var comprehensibilityScores: Dictionary<String, Float> =
    ["Mark Twain": 8.9, "Nathaniel Hawthorne": 5.1, "John Steinbeck": 2.3,
     "C.S. Lewis": 9.9, "Jon Krakaur": 6.1]

// Problem #6
print(comprehensibilityScores["John Steinbeck"]!)

comprehensibilityScores["Eric Lawson"] = 9.2

let markKey = "Mark Twain"
let jonKey = "Jon Krakaur"

if comprehensibilityScores[jonKey]! < comprehensibilityScores[markKey]! {
    let markScore: Float = comprehensibilityScores[markKey]!
    print("\(markKey) \(markScore)")
} else {
    let jonScore: Float = comprehensibilityScores[jonKey]!
    print("\(jonKey) \(jonScore)")
}

// Problem #7
for (author, score) in comprehensibilityScores {
    print("\(author) \(score)")
}

// Problem #8
for index in 1...10 {
    print(index)
}

// Problem #9
for index in (1...10).reversed() {
    print(index)
}

// Problem #10
let x = 2
let y = 3
var product = 0

for _ in 1 ... y {
    product += x
}

print(product)

// Problem #11
var scoresIterator = comprehensibilityScores.values.makeIterator()

var sum: Float = 0
var count: Float = 0

while let i = scoresIterator.next() {
    sum += i
    count += 1
}

let average: Float = sum / count

// Problem #12
if average > 7 {
    print("High")
} else if average >= 5 {
    print("Moderate")
} else {
    print("Low")
}

//problem #13
let strOut: String

switch count {
    case 0:
        strOut = "none"
    case 1...3:
        strOut = "a few"
    case 4...9:
        strOut = "several"
    case 10...99:
        strOut = "tens of"
    case 100...999:
        strOut = "hundreds of"
    case 1000...999_999:
        strOut = "thousands of"
    case let x where x > 999_999:
        strOut = "millions of"
    default:
        strOut = "less than a few"
}

// Problem #14
func verbalizeNumber(count: Int) -> String {
    let strOut: String

    switch count {
    case 0:
        strOut = "none"
    case 1...3:
        strOut = "a few"
    case 4...9:
        strOut = "several"
    case 10...99:
        strOut = "tens of"
    case 100...999:
        strOut = "hundreds of"
    case 1000...999_999:
        strOut = "thousands of"
    case let x where x > 999_999:
        strOut = "millions of"
    default:
        strOut = "less than a few"
    }
    
    return strOut
}

// Problem #15
var beeFactor: Int = 1
for _ in stride(from: 1, to: 9, by: 1) {
    print("There are \(verbalizeNumber(count: beeFactor)) bees!")
    beeFactor *= 10
}

// Problem #16
func verbalizeAndShoutNumber(count: Int) -> String {
    return verbalizeNumber(count: count).uppercased()
}

// Problem #17
func expressNumbersElegantly(count: Int, pFunc: (Int) -> String) -> String {

    var result: String = ""
    var beeFactor: Int = 1
    for _ in stride(from: 1, to: 9, by: 1) {
        result += "There are \(verbalizeNumber(count: beeFactor)) bees!\n"
        beeFactor *= 10
    }
    
    return result
}

var WhatAmI: (Int) -> String = verbalizeNumber
print(expressNumbersElegantly(count: 9, pFunc: WhatAmI))
WhatAmI = verbalizeAndShoutNumber
print(expressNumbersElegantly(count: 9, pFunc: WhatAmI))



// Problem 18
func expressNumbersVeryElegantly(ToThePowerOf count: Int, PrintNumberOfBees pFunc: (Int) -> String) -> String {
    return expressNumbersElegantly(count: count, pFunc: pFunc)
}

var WhatAmIFancy: (Int) -> String = verbalizeNumber
print(expressNumbersVeryElegantly(ToThePowerOf: 9, PrintNumberOfBees: WhatAmIFancy))


// Problem #19
var famousLastWords = ["the cow jumped over the moon.", "three score and four years ago",
                       "lets nuc 'em Joe!", "ah, there is just something about Swift"]

print(famousLastWords.map({ (lastWord: String) -> String in
    let capitalizeRange = lastWord.startIndex..<lastWord.index(lastWord.startIndex, offsetBy: 1)
    let restOfWordRange = lastWord.index(lastWord.startIndex, offsetBy: 1)..<lastWord.endIndex
    
    return lastWord.substring(with: capitalizeRange).uppercased() + lastWord.substring(with: restOfWordRange)
}))

// Problem #20
enum Bee: String {
    case Queen = "Queen"
    case Worker = "Worker"
    case Drone = "Drone"
    case Larva = "Larva"
}

func showYourself(bee: Bee) -> String {
    return "I am a \(bee.rawValue)"
}

// Advanced fizz-buzz implementation, O(1) time
func assignHiveMember(post: Int) -> (Bee, (Bee) -> String) {
    let currentBee: Bee
    switch post {
        case let queenPost where queenPost % 5 == 0 && queenPost % 3 == 0:
            currentBee = .Queen
        case let workerPost where workerPost % 5 == 0:
            currentBee = .Worker
        case let dronePost where dronePost % 3 == 0:
            currentBee = .Drone
        default:
            currentBee = .Larva
    }
    return (currentBee, showYourself)
}

var beeHive: [(Bee, (Bee) -> String)] = []

for b in 1...20 {
    beeHive.append(assignHiveMember(post: b))
}

beeHive.forEach({ (bee: Bee, proclamation: (Bee) -> String) in
    print(proclamation(bee))
})
