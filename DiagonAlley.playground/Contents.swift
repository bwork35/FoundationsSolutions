import UIKit

//MARK: - Part One
let firstName = "John"
let lastName = "Developer"
var age = 25
let birthday = "July 1, 1996"
var preferredWandLength = 12
var preferredHouse = "Gryffindor"
var characterTrait = "Brave"
let sickOfPotter = false


//MARK: - Part Two
var goldVault = 150.0

goldVault -= 24.3
goldVault -= 45
goldVault += 300
goldVault *= 2
goldVault *= 0.90


//MARK: - Part Three
var beakColor = "black"
var featherColor = "white"

if beakColor == "black" && featherColor == "white" {
    print("This one's mine!")
} else {
    print("Pass.")
}


var isSponsored = true

if isSponsored {
    print("I'm buying that one")
} else {
    print("Not for me.")
}


if characterTrait == "Cunning" || characterTrait == "Ambitious" {
    print("Slytherin!")
} else if characterTrait == "Brave" {
    print("Gryffindor!")
} else if characterTrait == "Loyal" {
    print("Hufflepuff!")
} else if characterTrait == "Great Wit" {
    print("Ravenclaw!")
}


//MARK: - Part Four
func purchaseFizzWhizzBees(numberPurchased: Int) {
    goldVault -= 2.0 * Double(numberPurchased)
}

func canPurchaseFrogs(numberInFamily: Int) {
    let frogsCost = 3.0 * Double(numberInFamily)
    if frogsCost <= goldVault {
        print("We'll take the lot.")
        goldVault -= frogsCost
    } else {
        print("No thanks, I'm all set.")
    }
}


//MARK: - Part Five
var bookPrices = [12, 15, 22, 10, 8, 17]

for bookPrice in bookPrices {
    if bookPrice > 15 {
        print("This book is expensive!")
    } else {
        print("This book isn't too bad")
    }
}


var totalPixiePuff = 0

while goldVault >= 3 {
    totalPixiePuff += 1
    goldVault -= 3
}
print(totalPixiePuff)
print(goldVault)
