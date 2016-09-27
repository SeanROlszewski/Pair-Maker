import XCTest
@testable import Pair_Maker

class EngineerCollectionViewControllerTest: XCTestCase {
    var subject: EngineerCollectionViewController!
    let delegateFake = DelegateFake()

    override func setUp() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        subject = storyboard.instantiateViewController(withIdentifier: "EngineerCollectionViewController") as! EngineerCollectionViewController
        _ = subject.view
    }
    
    func testAddsEngineerWithDifferentRemoteStatus() {

        subject.engineers = [Engineer(name: "Name", company: "Company", remote: false),
                             Engineer(name: "Some Name", company: "Some Company", remote: true)]
        
        let expectedEngineer = Engineer(name: "Name", company: "Company", remote: true)
        subject.didAdd(expectedEngineer)
        
        guard let idx = subject.engineers.index(of: expectedEngineer) else {
            XCTFail("Engineer should be in array")
            return
        }
        
        let actualEngineer = subject.engineers[idx]
        XCTAssertTrue(actualEngineer.remote)
    }
    
    func testSafelyRemovesEngineers() {
        
        let engineerOne = Engineer(name: "Name", company: "Company", remote: false)
        let engineerTwo = Engineer(name: "Some Name", company: "Some Company", remote: true)
        subject.engineers = [engineerOne,
                             engineerTwo]
        
        let expectedEngineer = Engineer(name: "Name", company: "Company", remote: true)
        subject.didRemove(expectedEngineer)
        
        guard subject.engineers.index(of: expectedEngineer) == nil else {
            XCTFail("Engineer should not be in array")
            return
        }
        
        subject.didRemove(Engineer(name: "Name2", company: "Company2", remote: true))
        guard subject.engineers.count == 1 else {
            XCTFail("Should not delete entries when given an invalid entry")
            return
        }
    }
}
