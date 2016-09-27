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

func generateRandomIndices(withUpperBound upperBound: Int) -> (Int, Int) {
    
    var indexOne = 0
    var indexTwo = 0
    repeat {
        indexOne = Int(arc4random_uniform(UInt32(upperBound)))
        indexTwo = Int(arc4random_uniform(UInt32(upperBound)))
    } while indexOne == indexTwo
    
    return (indexOne, indexTwo)
}

func generatePairs(fromEngineers engineers: [Engineer], withPredicate predicate: (Engineer, Engineer) -> (Bool)) -> (paired: [(Engineer, Engineer)], unpaired: [Engineer]) {
    
    var engineers = engineers.shuffled()
    var pairs = [(Engineer, Engineer)]()
    
    while canMakePairs(fromEngineers: engineers, withPredicate: predicate) {
        
        let indices = generateRandomIndices(withUpperBound: engineers.count)
        
        let engineerOne = engineers[indices.0]
        let engineerTwo = engineers[indices.1]
        
        if predicate(engineerOne, engineerTwo) {
            pairs.append((engineerOne, engineerTwo))
            engineers.remove(at: engineers.index(of: engineerOne)!)
            engineers.remove(at: engineers.index(of: engineerTwo)!)
        }
    }
    
    return (pairs, engineers)
}
