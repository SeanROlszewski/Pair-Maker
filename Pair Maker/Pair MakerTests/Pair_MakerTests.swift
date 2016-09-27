import XCTest
@testable import Pair_Maker

class Pair_MakerTests: XCTestCase {

    func testItPairsWithOneInqualityPredicate() {
        
        let engineerOne = Engineer(name: "Alfred", company: "Alphabet")
        let engineerTwo = Engineer(name: "Billy", company: "Alphabet")
        let engineerThree = Engineer(name: "Carl", company: "Apple")
        let engineerFour = Engineer(name: "David", company: "Google")
        
        let result = generatePairs(fromEngineers: [engineerOne, engineerTwo, engineerThree, engineerFour]) { (e1, e2) in
            return e1.company != e2.company
        }
        
        XCTAssert(result.paired.count >= 1)
        XCTAssert(result.unpaired.count >= 0)
        
        for pair in result.paired {
            XCTAssertNotEqual(pair.0.company, pair.1.company)
        }
    }
    
    func testItPairsWithEqualityPredicate() {
        
        let engineerOne = Engineer(name: "Alfred", company: "Alphabet")
        let engineerTwo = Engineer(name: "Billy", company: "Alphabet")
        let engineerThree = Engineer(name: "Carl", company: "Apple")
        let engineerFour = Engineer(name: "David", company: "Google")
        
        let result = generatePairs(fromEngineers: [engineerOne, engineerTwo, engineerThree, engineerFour]) { (e1, e2) in
            return e1.company == e2.company
        }
        
        XCTAssert(result.paired.count == 1, "Got \(result.paired.count) but expected 1")
        XCTAssert(result.unpaired.count == 2, "Got \(result.unpaired.count) but expected 2")
        for pair in result.paired {
            XCTAssertEqual(pair.0.company, pair.1.company)
        }
    }
    
    func testItPairsWithTwoPredicates() {
        
        
        let engineerOne = Engineer(name: "Alfred", company: "Alphabet", remote: true)
        let engineerTwo = Engineer(name: "Billy", company: "Alphabet", remote: false)
        let engineerThree = Engineer(name: "Carl", company: "Apple", remote: true)
        let engineerFour = Engineer(name: "David", company: "Apple", remote: false)
        let engineerFive = Engineer(name: "Eric", company: "Facebook", remote: false)
        let engineerSix = Engineer(name: "Frank", company: "Twitter", remote: false)
        
        let result = generatePairs(fromEngineers: [engineerOne, engineerTwo, engineerThree, engineerFour, engineerFive, engineerSix]) { (e1, e2) in
            return e1.company != e2.company && e1.remote != e2.remote
        }
        
        XCTAssert(result.paired.count == 2)
        XCTAssert(result.unpaired.count >= 2)
        for pair in result.paired {
            XCTAssertNotEqual(pair.0.company, pair.1.company)
            XCTAssertNotEqual(pair.0.company, pair.1.company)
        }
    }
    
    func testCollectionsShuffle() {
        let engineerOne = Engineer(name: "Alfred", company: "Alphabet", remote: true)
        let engineerTwo = Engineer(name: "Billy", company: "Alphabet", remote: false)
        let engineerThree = Engineer(name: "Carl", company: "Apple", remote: true)
        let engineerFour = Engineer(name: "David", company: "Apple", remote: false)
        
        let sorted = [engineerOne, engineerTwo, engineerThree, engineerFour]
        
        for _ in 0...5 {
            XCTAssertNotEqual(sorted, sorted.shuffled())
        }
    }
}
