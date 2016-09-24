import UIKit
import Darwin

func == (lhs: Engineer, rhs: Engineer) -> Bool {
    return lhs.name == rhs.name && lhs.company == rhs.company
}

struct Engineer: Equatable {
    let name: String
    let company: String
    
    init(name: String, company: String) {
        self.name = name
        self.company = company
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

func generatePairs(fromEngineers engineers: [Engineer], withPredicate predicate: (Engineer, Engineer) -> (Bool)) -> [(Engineer, Engineer)]? {

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
    
    return pairs
}

func testItPairsEngineersOfDifferentCompanies() {

    let engineerOne: Engineer = Engineer(name: "Alfred", company: "Alphabet")
    let engineerTwo: Engineer = Engineer(name: "Billy", company: "Alphabet")
    let engineerThree: Engineer = Engineer(name: "Carl", company: "Alphabet")
    let engineerFour: Engineer = Engineer(name: "David", company: "Apple")
    let engineerFive: Engineer = Engineer(name: "Eddy", company: "Apple")
    let engineerSix: Engineer = Engineer(name: "Frank", company: "Apple")

    
    
    let pairedEngineersOfDifferentCompanies = generatePairs(fromEngineers: [engineerOne, engineerTwo, engineerThree, engineerFour, engineerFive, engineerSix]) { (engineerOne, engineerTwo) in
        
            return engineerOne.company != engineerTwo.company
        
        }
    
    
    
    let pairNames = pairedEngineersOfDifferentCompanies?.reduce("") { (result, pair) -> String in
        result.appending("\(pair.0.name) from \(pair.0.company) is pairing with \(pair.1.name) from \(pair.1.company). ")
    }
    print("List of pairs: \(pairNames)")
}
func testItMakesPairsWithEvenNumberEngineersAndOddNumberCompanies() {
    
    let engineerOne: Engineer = Engineer(name: "Alfred", company: "Alphabet")
    let engineerTwo: Engineer = Engineer(name: "Billy", company: "Alphabet")
    let engineerThree: Engineer = Engineer(name: "Carl", company: "Apple")
    let engineerFour: Engineer = Engineer(name: "David", company: "Google")

    let pairedEngineersOfDifferentCompanies = generatePairs(fromEngineers: [engineerOne, engineerTwo, engineerThree, engineerFour]) { (engineerOne, engineerTwo) in
        
        return engineerOne.company != engineerTwo.company
        
    }
 
    let pairNames = pairedEngineersOfDifferentCompanies?.reduce("") { (result, pair) -> String in
        result.appending("\(pair.0.name) from \(pair.0.company) is pairing with \(pair.1.name) from \(pair.1.company). ")
    }
    print("List of pairs: \(pairNames)")
}

func testPairsEngineersFromSameCompany() {
    
    let engineerOne: Engineer = Engineer(name: "Alfred", company: "Alphabet")
    let engineerTwo: Engineer = Engineer(name: "Billy", company: "Alphabet")
    let engineerThree: Engineer = Engineer(name: "Carl", company: "Apple")
    let engineerFour: Engineer = Engineer(name: "David", company: "Google")
//    let engineerFive: Engineer = Engineer(name: "Eric", company: "Twitter")
    
    let pairedEngineersOfDifferentCompanies = generatePairs(fromEngineers: [engineerOne, engineerTwo, engineerThree, engineerFour]) { (engineerOne, engineerTwo) in
        
        return engineerOne.company == engineerTwo.company
        
    }
    
    let pairNames = pairedEngineersOfDifferentCompanies?.reduce("") { (result, pair) -> String in
        result.appending("\(pair.0.name) from \(pair.0.company) is pairing with \(pair.1.name) from \(pair.1.company). ")
    }
    print("List of pairs: \(pairNames)")
}

//func testPairsEngineersFromSameCompany() {
//    
//    let engineerOne: Engineer = Engineer(name: "Alfred", company: "Alphabet")
//    let engineerTwo: Engineer = Engineer(name: "Billy", company: "Alphabet")
//    let engineerThree: Engineer = Engineer(name: "Carl", company: "Apple")
//    let engineerFour: Engineer = Engineer(name: "David", company: "Google")
//    
//    let pairedEngineersOfDifferentCompanies = generatePairs(fromEngineers: [engineerOne, engineerTwo, engineerThree, engineerFour]) { (engineerOne, engineerTwo) in
//        
//        return engineerOne.company == engineerTwo.company
//        
//    }
//    
//    let pairNames = pairedEngineersOfDifferentCompanies?.reduce("") { (result, pair) -> String in
//        result.appending("\(pair.0.name) from \(pair.0.company) is pairing with \(pair.1.name) from \(pair.1.company). ")
//    }
//    print("List of pairs: \(pairNames)")
//}

testItPairsEngineersOfDifferentCompanies()
testItMakesPairsWithEvenNumberEngineersAndOddNumberCompanies()
testPairsEngineersFromSameCompany()
