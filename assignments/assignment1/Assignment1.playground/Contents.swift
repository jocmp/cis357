/**
 * Authors: Josiah Campbell & Derrick Bentley
 */
import Foundation
// Problem #1
let myString = "hello"
var cost = 3.14
let cnt: Int = 2
var shouldWe: Bool = true
//an integer constant assigned the value of 11 hexadecimal.
let myIntOr = Int("b", radix:16)!
//an integer constant assigned the binary equivalent of decimal 10.
let myInt2 = Int("1010", radix:2)!

// Problem #2
let two: Float = 2.0
let smartGuy: String = "Orwell"
let restOfString = " when he said 2+2=5. It actuall equals "
let myRealization = "\(smartGuy)\(restOfString)\(two + two)!"
let myRealizationRealized = "\(myRealization)"
print(myRealizationRealized)

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

for _ in 1...y {
    product += x
}

print(product)

// Problem #11
var scoresIterator = comprehensibilityScores.values.makeIterator()
var sum:Float = 0
var count:Float = 0
while let i = scoresIterator.next(){
	sum += i
	count += 1
}
let average:Float = sum/count

// Problem 12
if average > 7 {
	let low:String = "High"
	print("\(low)")
} else if average >= 5 {
	let low2: String = "Moderate"
	print("\(low2)")
} else {
	let low3:String = "Low"
	print("\(low3)")
}

//problem 13
let strOut:String
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
	case 1000...999999:
	strOut = "thousands of"
	case let x where x >= 1000000:
	strOut = "millions of"
	default:
	strOut = "we've a negative"
}

// Problem 14
func verbalizeNumber(count:Int) -> String {
	
	let strOut:String
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
		case 1000...999999:
		strOut = "thousands of"
		case let x where x >= 1000000:
		strOut = "millions of"
		default:
		strOut = "we've a negative"
	}
	return strOut
}

	// Problem 15
var biggerLeaps:Int = 1
for _ in stride(from:1, to:9, by:1){

	let meaningfulString:String = "There are "
	let meaningfulBees:String = " bees!"
	let meaningfulFinal:String = "\(meaningfulString)\(verbalizeNumber(count:biggerLeaps))\(meaningfulBees)"
	print("\(meaningfulFinal)")
	
	biggerLeaps *= 10
}

// Problem 16
func verbalizeAndShoutNumber(count:Int) -> String {
	return verbalizeNumber(count:count).uppercased()
}

// Problem 17
func expressNumbersElegantly(count:Int, pFunc:(Int) -> String) -> String {
	// Problem 15
	var biggerLeaps:Int = 1
	var result:String = ""
	for _ in stride(from:1, to:count, by:1){

		let meaningfulString:String = "There are "
		let meaningfulBees:String = " bees!"
		let meaningfulFinal:String = "\(meaningfulString)\(pFunc(biggerLeaps))\(meaningfulBees)"
		result += "\(meaningfulFinal)"
		biggerLeaps *= 10
	}
	return result
	//return pFunc(count).uppercased()
}

var WhatAmI: (Int) -> String = verbalizeNumber
print(expressNumbersElegantly(count:9, pFunc:WhatAmI))
WhatAmI = verbalizeAndShoutNumber
print(expressNumbersElegantly(count:9, pFunc:WhatAmI))



// Problem 18
func expressNumbersVeryElegantly(ToThePowerOf count:Int, PrintNumberOfBees pFunc:(Int) -> String) -> String {
	return expressNumbersElegantly(count:count, pFunc:pFunc)
}

var WhatAmIFancy: (Int) -> String = verbalizeNumber
print(expressNumbersVeryElegantly(ToThePowerOf:9, PrintNumberOfBees:WhatAmIFancy))


// Problem 20
var famousLastWords = ["the cow jumped over the moon.", "three score and four years ago", "lets nuc 'em Joe!", "ah, there is just something about Swift"]

print(famousLastWords.map({ (str: String) -> String in
    let end = str.index(str.startIndex, offsetBy: 1)
    let range = str.startIndex..<end

    let secondRange = str.index(str.startIndex, offsetBy: 1)..<str.endIndex
    return str.substring(with: range).uppercased() + str.substring(with: secondRange)
}))

// Problem 20
enum Bee : String {
	case Queen = "Queen"
	case Worker = "Worker"
	case Drone = "Drone"
	case Larva = "Larva"
}

var BeeHive: [(Bee, (Bee) -> String)] = []

func showYourself(bee:Bee) -> String{
	return "I am a \(bee.rawValue)"
}

func assignHiveMember(post:Int) -> (Bee, (Bee)->String) {
	switch post{
		case let myPost where myPost%5 == 0 && myPost%3 == 0:
			return (Bee.Queen, showYourself)
		case let myPost where myPost%5 == 0:
			return (Bee.Worker, showYourself)
		case let myPost where myPost%3 == 0:
			return (Bee.Drone, showYourself)
		default:
			return (Bee.Larva, showYourself)
	}
}

for b in 1...20 {
	BeeHive.append(assignHiveMember(post:b))
}

BeeHive.forEach({ (bee:Bee, procFunc:(Bee) -> String) in
				 print(procFunc(bee))
	
})