import UIKit

class PairListViewController: UIViewController {
    
    var engineers = [Engineer]()
    var pairs = [(Engineer, Engineer)]()
    
    @IBOutlet weak var pairingResultsTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makePairs()
    }
    
    @IBAction func doneWasPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func refreshWasPressed(_ sender: UIBarButtonItem) {
        makePairs()
    }
    
    private func makePairs() {
        let result = generatePairs(fromEngineers: engineers) { (e1, e2) -> (Bool) in
            return e1.company != e2.company && e1.remote != e2.remote
        }
        
        updateTextField(withPairs: result.paired, andUnpaired: result.unpaired)
    }
    
    private func updateTextField(withPairs pairs: [(Engineer, Engineer)], andUnpaired unpaired: [Engineer]) {
        var pairingResults = ""
        
        for pair in pairs {
            pairingResults = pairingResults.appending("\(pair.0.name) is pairing with \(pair.1.name)\n")
        }
        
        for unpairedEng in unpaired {
            pairingResults = pairingResults.appending("\(unpairedEng.name) is unpaired\n")
        }
        
        pairingResultsTextView.text = pairingResults
    }
}
