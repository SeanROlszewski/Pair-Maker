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


func generatePairs(fromEngineers engineers: [Engineer], withPredicate predicate: (Engineer, Engineer) -> (Bool)) -> (paired: [(Engineer, Engineer)], unpaired: [Engineer]) {
    
    var engineers = engineers.shuffled()
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

//    for pair in pairs {
//        print("\(pair.0.name) from \(pair.0.company) is pairing with \(pair.1.name) from \(pair.1.company). ")
//        
//    }

//    for engineer in unpaired {
//        print("\(engineer.name) from \(engineer.company)")
//    }