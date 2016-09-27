import XCTest
@testable import Pair_Maker

class Pair_MakerTests: XCTestCase {

    func testItPairsWithOneInqualityPredicate2() {
        
        let engineerOne = Engineer(name: "Alfred", company: "Alphabet")
        let engineerTwo = Engineer(name: "Billy", company: "Alphabet")
        let engineerThree = Engineer(name: "Carl", company: "Apple")
        let engineerFour = Engineer(name: "David", company: "Google")
        
        let result = generatePairs(fromEngineers: [engineerOne, engineerTwo, engineerThree, engineerFour]) { (engineerOne, engineerTwo) in
            return engineerOne.company != engineerTwo.company
        }
        
        XCTAssert(result.paired.count == 2)
        XCTAssert(result.unpaired.count == 0)
    }
    
    func testItPairsWithEqualityPredicate() {
        
        let engineerOne = Engineer(name: "Alfred", company: "Alphabet")
        let engineerTwo = Engineer(name: "Billy", company: "Alphabet")
        let engineerThree = Engineer(name: "Carl", company: "Apple")
        let engineerFour = Engineer(name: "David", company: "Google")
        
        let result = generatePairs(fromEngineers: [engineerOne, engineerTwo, engineerThree, engineerFour]) { (engineerOne, engineerTwo) in
            return engineerOne.company == engineerTwo.company
        }
        
        XCTAssert(result.paired.count == 1)
        XCTAssert(result.unpaired.count == 2)
    }
    
    func testItPairsWithTwoPredicates() {
        
        
        let engineerOne = Engineer(name: "Alfred", company: "Alphabet", remote: true)
        let engineerTwo = Engineer(name: "Billy", company: "Alphabet", remote: false)
        let engineerThree = Engineer(name: "Carl", company: "Apple", remote: true)
        let engineerFour = Engineer(name: "David", company: "Apple", remote: false)
        let engineerFive = Engineer(name: "Eric", company: "Facebook", remote: false)
        let engineerSix = Engineer(name: "Frank", company: "Twitter", remote: false)
        
        let result = generatePairs(fromEngineers: [engineerOne, engineerTwo, engineerThree, engineerFour, engineerFive, engineerSix]) { (engineerOne, engineerTwo) in
            return engineerOne.company != engineerTwo.company && engineerOne.remote != engineerTwo.remote
        }
        
        XCTAssert(result.paired.count == 2)
        XCTAssert(result.unpaired.count >= 2)
    }
}
