import UIKit
import Darwin

struct Engineer {
    let name: String
    let company: String
    
    init(name: String, company: String) {
        self.name = name
        self.company = company
    }
    
    init() {
        self.name = ""
        self.company = ""
    }
}

func generatePairs(fromEngineers engineers: [Engineer]) -> [(Engineer, Engineer)]? {
    if engineers.count % 2 > 0 {
        return nil
    }
    var engineers = engineers
    var pairs = [(Engineer, Engineer)]()
    
    while engineers.count > 0 {
        
        let engineerOne = engineers[0]
        
        var index: Int
        repeat {
             index = Int(arc4random_uniform(UInt32(engineers.count)))
        } while index == 0
        
        let engineerTwo = engineers[index]
        
        if engineerOne.company != engineerTwo.company {
            pairs.append((engineerOne, engineerTwo))
            engineers.remove(at: index)
            engineers.remove(at: 0)
        }
    }
    
    return pairs
}

let oddNumberOfEngineersCantPair = generatePairs(fromEngineers: [Engineer(), Engineer(), Engineer()]) == nil
print("Returns nil when there are an odd number of engineers: \(oddNumberOfEngineersCantPair)")

let engineerOne: Engineer = Engineer(name: "Alfred", company: "Alphabet")
let engineerTwo: Engineer = Engineer(name: "Billy", company: "Alphabet")
let engineerThree: Engineer = Engineer(name: "Carl", company: "Alphabet")
let engineerFour: Engineer = Engineer(name: "David", company: "Apple")
let engineerFive: Engineer = Engineer(name: "Eddy", company: "Apple")
let engineerSix: Engineer = Engineer(name: "Frank", company: "Apple")

let pairedEngineersOfDifferentCompanies = generatePairs(fromEngineers: [engineerOne, engineerTwo, engineerThree, engineerFour, engineerFive, engineerSix])
let pairNames = pairedEngineersOfDifferentCompanies?.reduce("") { (result, pair) -> String in
    result.appending("\(pair.0.name) from \(pair.0.company) is pairing with \(pair.1.name) from \(pair.1.company). ")
}
print("List of pairs: \(pairNames)")




