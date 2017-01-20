/**
 * Authors: Josiah Campbell & Derrick Bentley
 */

// Problem #1
let myString = "hello"
var cost = 3.14
let cnt: Int = 2
var shouldWe: Bool = true
//an integer constant assigned the value of 11 hexadecimal.
//an integer constant assigned the binary equivalent of decimal 10.

// Problem #2
let two: Float = 2.0
let myRealization = "Orwell was wrong when he said 2+2=5. It actually equals \(two + two)!"

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
//for i = 10; i <= 0; i-- {
//    print(i)
//}

// Problem #10
let x = 2
let y = 3
var product = 0

for _ in 1...y {
    product += x
}

print(product)

// Problem #11

