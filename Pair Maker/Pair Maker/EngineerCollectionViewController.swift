import UIKit

class EngineerCollectionViewController: UICollectionViewController, AddEngineerViewControllerDelegate {
    var engineers = [Engineer]()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func didRegisterNewEngineer(_ engineer: Engineer) {
        engineers.append(engineer)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "EngineerCollectionViewCell", bundle: nil)
        collectionView?.register(nib, forCellWithReuseIdentifier: "engineerCell")
        print("view did load")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView?.reloadData()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return engineers.count
    }
    
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
////        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "engineerCell", for: indexPath) as!
//        cell.nameLabel.text = engineers[indexPath.row].name
//        cell.nameLabel.text = engineers[indexPath.row].name
//        cell.isRemoteLabel.text = "\(engineers[indexPath.row].remote)"
//        return cell
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nc = segue.destination as! UINavigationController
        let vc = nc.viewControllers.first! as! AddEngineerViewController
        vc.delegate = self
    }
}

