import Foundation
import Darwin

class Constraint<T: Equatable> {
    let name: String
    let predicate: (T, T) -> Bool
    
    init(name: String, predicate: @escaping (T, T) -> Bool) {
        self.name = name
        self.predicate = predicate
    }
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

func canMakePairs<T: Equatable>(fromList items: [T], withPredicate predicate: (T, T) -> (Bool)) -> Bool {
    guard items.count >= 2 else {
        return false
    }
    
    for itemOne in items {
        for itemTwo in items {
            if itemOne != itemTwo && predicate(itemOne, itemTwo) {
                return true
            }
        }
    }
    
    return false
}

func generatePairs<T: Equatable>(fromList items: [T], withPredicate predicate: (T, T) -> (Bool)) -> (paired: [(T, T)], unpaired: [T]) {
    
    var items = items.shuffled()
    var pairs = [(T, T)]()
    
    while canMakePairs(fromList: items, withPredicate: predicate) {
        
        let indices = generateRandomIndices(withUpperBound: items.count)
        
        let engineerOne = items[indices.0]
        let engineerTwo = items[indices.1]
        
        if predicate(engineerOne, engineerTwo) {
            pairs.append((engineerOne, engineerTwo))
            items.remove(at: items.index(of: engineerOne)!)
            items.remove(at: items.index(of: engineerTwo)!)
        }
    }
    
    return (pairs, items)
}
