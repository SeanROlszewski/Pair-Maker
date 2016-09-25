import Foundation
import Darwin

func == (lhs: Engineer, rhs: Engineer) -> Bool {
    return lhs.name == rhs.name && lhs.company == rhs.company
}

struct Engineer: Equatable {
    let name: String
    let company: String
    let remote: Bool
    
    init(name: String, company: String) {
        self.name = name
        self.company = company
        self.remote = false
    }
    init(name: String, company: String, remote: Bool) {
        self.name = name
        self.company = company
        self.remote = remote
    }
}

func canMakePairs(fromEngineers engineers: [Engineer], withPredicate predicate: (Engineer, Engineer) -> (Bool)) -> Bool {
    guard engineers.count >= 2 else {
        return false
    }
    
    for engineerOne in engineers {
        for engineerTwo in engineers {
            if engineerOne != engineerTwo && predicate(engineerOne, engineerTwo) {
                return true
            }
        }
    }
    
    return false
}


func generatePairs(fromEngineers engineers: [Engineer], withPredicate predicate: (Engineer, Engineer) -> (Bool)) -> (pairs: [(Engineer, Engineer)], unpaired: [Engineer]) {

    var engineers = engineers
    var pairs = [(Engineer, Engineer)]()
    
    while canMakePairs(fromEngineers: engineers, withPredicate: predicate) {
        
        let engineerOne = engineers[0]
        
        var index: Int
        repeat {
             index = Int(arc4random_uniform(UInt32(engineers.count)))
        } while index == 0
        
        let engineerTwo = engineers[index]
        
        if predicate(engineerOne, engineerTwo) {
            pairs.append((engineerOne, engineerTwo))
            engineers.remove(at: index)
            engineers.remove(at: 0)
        }
    }
    
    return (pairs, engineers)
}

func printOut(pairs: [(Engineer, Engineer)]) {
    print("----------------")
    print("List of pairs: ")
    print()
    for pair in pairs {
        print("\(pair.0.name) from \(pair.0.company) is pairing with \(pair.1.name) from \(pair.1.company). ")
        
    }
}

func printOut(leftovers: [Engineer]) {
    print()
    print("Leftovers: ")
    print()
    for engineer in leftovers {
        print("\(engineer.name) from \(engineer.company)")
    }
}


// TESTS BELOW


func testItPairsEngineersOfDifferentCompanies() {

    let engineerOne = Engineer(name: "Alfred", company: "Alphabet")
    let engineerTwo = Engineer(name: "Billy", company: "Alphabet")
    let engineerThree = Engineer(name: "Carl", company: "Alphabet")
    let engineerFour = Engineer(name: "David", company: "Apple")
    let engineerFive = Engineer(name: "Eddy", company: "Apple")
    let engineerSix = Engineer(name: "Frank", company: "Apple")

    
    
    let result = generatePairs(fromEngineers: [engineerOne, engineerTwo, engineerThree, engineerFour, engineerFive, engineerSix]) { (engineerOne, engineerTwo) in
    
        return engineerOne.company != engineerTwo.company
    
    }
    printOut(pairs: result.pairs)
    printOut(leftovers: result.unpaired)
}

func testItMakesPairsWithEvenNumberEngineersAndOddNumberCompanies() {
    
    let engineerOne = Engineer(name: "Alfred", company: "Alphabet")
    let engineerTwo = Engineer(name: "Billy", company: "Alphabet")
    let engineerThree = Engineer(name: "Carl", company: "Apple")
    let engineerFour = Engineer(name: "David", company: "Google")

    let result = generatePairs(fromEngineers: [engineerOne, engineerTwo, engineerThree, engineerFour]) { (engineerOne, engineerTwo) in
        return engineerOne.company != engineerTwo.company
    }
 
    printOut(pairs: result.pairs)
    printOut(leftovers: result.unpaired)

}

func testPairsEngineersFromSameCompany() {
    
    let engineerOne = Engineer(name: "Alfred", company: "Alphabet")
    let engineerTwo = Engineer(name: "Billy", company: "Alphabet")
    let engineerThree = Engineer(name: "Carl", company: "Apple")
    let engineerFour = Engineer(name: "David", company: "Google")
    
    let result = generatePairs(fromEngineers: [engineerOne, engineerTwo, engineerThree, engineerFour]) { (engineerOne, engineerTwo) in
        return engineerOne.company == engineerTwo.company
    }

    printOut(pairs: result.pairs)
    printOut(leftovers: result.unpaired)

}

func testItMakesPairsFromEngineersWhoAreRemoteAndNotRemote() {
    
    let engineerOne = Engineer(name: "Alfred", company: "Alphabet", remote: true)
    let engineerTwo = Engineer(name: "Billy", company: "Alphabet", remote: false)
    let engineerThree = Engineer(name: "Carl", company: "Apple", remote: true)
    let engineerFour = Engineer(name: "David", company: "Apple", remote: false)
    let engineerFive = Engineer(name: "Eric", company: "Facebook", remote: false)
    let engineerSix = Engineer(name: "Frank", company: "Twitter", remote: false)
    
    let result = generatePairs(fromEngineers: [engineerOne, engineerTwo, engineerThree, engineerFour, engineerFive, engineerSix]) { (engineerOne, engineerTwo) in
        return engineerOne.company != engineerTwo.company && engineerOne.remote != engineerTwo.remote
    }
    
    printOut(pairs: result.pairs)
    printOut(leftovers: result.unpaired)
    let resultTwo = generatePairs(fromEngineers: result.unpaired) { (_, _) -> (Bool) in
        return true
    }
    printOut(pairs: resultTwo.pairs)
}


testItPairsEngineersOfDifferentCompanies()
testItMakesPairsWithEvenNumberEngineersAndOddNumberCompanies()
testPairsEngineersFromSameCompany()
testItMakesPairsFromEngineersWhoAreRemoteAndNotRemote()

