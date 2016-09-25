import UIKit

protocol AddEngineerViewControllerDelegate {
    func didRegisterNewEngineer(_ engineer: Engineer)
}

class AddEngineerViewController: UIViewController {
    
    var delegate: AddEngineerViewControllerDelegate?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var companyTextField: UITextField!
    @IBOutlet weak var isRemoteSwitch: UISwitch!
    
    @IBAction func cancelButtonWasPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonWasPressed(_ sender: UIBarButtonItem) {
        
        guard nameTextField.text?.isEmpty != true,
            companyTextField.text?.isEmpty != true,
            let name = nameTextField.text,
            let company = companyTextField.text else {
                return
        }
        
        let engineer = Engineer(name: name, company: company, remote: isRemoteSwitch.isOn)
        delegate?.didRegisterNewEngineer(engineer)
        dismiss(animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
