import UIKit

protocol AddEngineerViewControllerDelegate {
    func didAdd(_ engineer: Engineer)
    func didRemove(_ engineer: Engineer)
}

class AddEngineerViewController: UIViewController {
    
    var delegate: AddEngineerViewControllerDelegate?
    
    var engineerToEdit: Engineer?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var companyTextField: UITextField!
    @IBOutlet weak var isRemoteSwitch: UISwitch!
    @IBOutlet weak var deleteEngineerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let engineer = engineerToEdit {
            nameTextField.text = engineer.name
            companyTextField.text = engineer.company
            isRemoteSwitch.isOn = engineer.remote
            deleteEngineerButton.alpha = 1.0
            navigationItem.title = "Edit Engineer"
        } else {
            navigationItem.title = "Add Engineer"
            deleteEngineerButton.alpha = 0.0
            deleteEngineerButton.isEnabled = false
        }
    }
    
    @IBAction func deleteButtonWasPressed(_ sender: UIButton) {
        delegate?.didRemove(engineerToEdit!)
        dismissSelf()
    }
    
    @IBAction func cancelButtonWasPressed(_ sender: UIBarButtonItem) {
        dismissSelf()
    }
    
    @IBAction func saveButtonWasPressed(_ sender: UIBarButtonItem) {
        
        guard nameTextField.text?.isEmpty != true,
            companyTextField.text?.isEmpty != true,
            let name = nameTextField.text,
            let company = companyTextField.text else {
                return
        }
        
        let engineer = Engineer(name: name, company: company, remote: isRemoteSwitch.isOn)
        delegate?.didAdd(engineer)
        dismissSelf()
    }
    
    func dismissSelf() {
        nameTextField.resignFirstResponder()
        companyTextField.resignFirstResponder()
        dismiss(animated: true, completion: nil)
    }
}
