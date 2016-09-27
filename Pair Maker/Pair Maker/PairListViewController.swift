import UIKit

protocol PairListViewControllerDelegate {
    func constraintsUpdated(_ constraints: [Constraint<Engineer>])
}

class PairListViewController: UIViewController {
    
    var engineers = [Engineer]()
    var pairs = [(Engineer, Engineer)]()

    @IBOutlet weak var pairsTextView: UITextView!
    @IBOutlet weak var makePairsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makePairs()

        makePairsButton.backgroundColor = UIColor.pmGreen
        makePairsButton.tintColor = UIColor.pmLightGray
    }
    
    @IBAction func doneWasPressed() {
        dismiss(animated: true, completion: nil)
    }
  
    @IBAction func refreshWasPressed(_ sender: UIButton) {
        makePairs()
    }
    
    private func makePairs() {        
        let result = generatePairs(fromList: engineers) { (e1, e2) -> (Bool) in
            return e1.company != e2.company && e1.remote != e2.remote
        }
        
        updateTextView(withPairs: result.paired, andUnpaired: result.unpaired)
    }
    
    private func updateTextView(withPairs pairs: [(Engineer, Engineer)], andUnpaired unpaired: [Engineer]) {
        pairsTextView.text = ""
        
        for pair in pairs {
            let pairingResults = "\(pair.0.name) is pairing with \(pair.1.name)\n"
            pairsTextView.text = pairsTextView.text.appending(pairingResults)
        }
        
        for unpairedEng in unpaired {
            let pairingResults = "\(unpairedEng.name) is unpaired\n"
            pairsTextView.text = pairsTextView.text.appending(pairingResults)
        }
    }
}
