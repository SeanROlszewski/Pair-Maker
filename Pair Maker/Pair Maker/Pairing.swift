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

private func generateRandomIndices(withUpperBound upperBound: Int) -> (Int, Int) {
    
    var indexOne = 0
    var indexTwo = 0
    repeat {
        indexOne = Int(arc4random_uniform(UInt32(upperBound)))
        indexTwo = Int(arc4random_uniform(UInt32(upperBound)))
    } while indexOne == indexTwo
    
    return (indexOne, indexTwo)
}

private func canMakePairs<T: Equatable>(from items: [T], with predicate: (T, T) -> (Bool)) -> Bool {
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

func generatePairs<T: Equatable>(from items: [T], with predicate: (T, T) -> (Bool)) -> (paired: [(T, T)], unpaired: [T]) {
    
    var items = items.shuffled()
    var pairs = [(T, T)]()
    
    while canMakePairs(from: items, with: predicate) {
        
        let indices = generateRandomIndices(withUpperBound: items.count)
        
        let itemOne = items[indices.0]
        let itemTwo = items[indices.1]
        
        if predicate(itemOne, itemTwo) {
            pairs.append((itemOne, itemTwo))
            items.remove(at: items.index(of: itemOne)!)
            items.remove(at: items.index(of: itemTwo)!)
        }
    }
    
    return (pairs, items)
}
