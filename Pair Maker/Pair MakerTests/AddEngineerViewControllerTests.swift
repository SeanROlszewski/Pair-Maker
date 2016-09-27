import XCTest
@testable import Pair_Maker

class DelegateFake: AddEngineerViewControllerDelegate {
    var didAddWasCalled: Bool = false
    var addedEngineer: Engineer?
    
    var didRemoveWasCalled: Bool = false
    var removedEngineer: Engineer?
    
    func didAdd(_ engineer: Engineer) {
        didAddWasCalled = true
        addedEngineer = engineer
    }
    
    func didRemove(_ engineer: Engineer) {
        didRemoveWasCalled = true
        removedEngineer = engineer
    }
}

class AddEngineerViewControllerTests: XCTestCase {
    
    var subject: AddEngineerViewController!
    let delegateFake = DelegateFake()
    
    override func setUp() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        subject = storyboard.instantiateViewController(withIdentifier: "AddEngineerViewController") as! AddEngineerViewController
        _ = subject.view
        
        subject.delegate = delegateFake
    }
    
    func testChangesUIWhenLoadedWithEngineerToEdit() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        subject = storyboard.instantiateViewController(withIdentifier: "AddEngineerViewController") as! AddEngineerViewController
        subject.engineerToEdit = Engineer(name: "Some Name", company: "Some Company", remote: false)
        
        _ = subject.view
        
        XCTAssertEqual(subject.navigationItem.title, "Edit Engineer")
        XCTAssertTrue(subject.deleteEngineerButton.isEnabled)
        XCTAssertEqual(subject.deleteEngineerButton.alpha, 1.0)
        XCTAssertEqual(subject.nameTextField.text, "Some Name")
        XCTAssertEqual(subject.companyTextField.text, "Some Company")
        XCTAssertFalse(subject.isRemoteSwitch.isOn)
    }
    
    func testHidesDeleteButtonWhenAddingANewEngineer() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        subject = storyboard.instantiateViewController(withIdentifier: "AddEngineerViewController") as! AddEngineerViewController
        subject.engineerToEdit = nil
        
        _ = subject.view
        
        XCTAssertEqual(subject.navigationItem.title, "Add Engineer")
        XCTAssertFalse(subject.deleteEngineerButton.isEnabled)
        XCTAssertEqual(subject.deleteEngineerButton.alpha, 0.0)
        XCTAssertEqual(subject.nameTextField.text, "")
        XCTAssertEqual(subject.companyTextField.text, "")
        XCTAssertTrue(subject.isRemoteSwitch.isOn)
    }
    
    
    func testNotifiesDelegateOfNewEngineer() {
        subject.nameTextField.text = "Some Name"
        subject.companyTextField.text = "Some Company"
        subject.isRemoteSwitch.isOn = false
        subject.saveButtonWasPressed(UIBarButtonItem())
        
        XCTAssertTrue(delegateFake.didAddWasCalled)
        XCTAssertEqual(delegateFake.addedEngineer, Engineer(name: "Some Name", company: "Some Company", remote: false))
    }
    
    func testDoesntNotifyDelegateToSaveIncompleteEngineer() {
        subject.nameTextField.text = "Some Name"
        subject.companyTextField.text = ""
        subject.isRemoteSwitch.isOn = false
        subject.saveButtonWasPressed(UIBarButtonItem())
        
        XCTAssertFalse(delegateFake.didAddWasCalled)
        
        subject.nameTextField.text = ""
        subject.companyTextField.text = "Some Company"
        subject.isRemoteSwitch.isOn = false
        subject.saveButtonWasPressed(UIBarButtonItem())
        
        XCTAssertFalse(delegateFake.didAddWasCalled)
    }
    
    func testNotifiesDelegateToRemoveEngineer() {
        subject.engineerToEdit = Engineer(name: "Some Name", company: "Some Company", remote: false)

        subject.deleteButtonWasPressed(UIButton())
        
        XCTAssertTrue(delegateFake.didRemoveWasCalled)
        XCTAssertEqual(delegateFake.removedEngineer, Engineer(name: "Some Name", company: "Some Company", remote: false))
    }
}
