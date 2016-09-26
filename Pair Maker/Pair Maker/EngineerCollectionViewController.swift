import UIKit

class EngineerCollectionViewController: UICollectionViewController, AddEngineerViewControllerDelegate, UICollectionViewDelegateFlowLayout {
    var engineers = [Engineer]()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        engineers = [
            Engineer(name: "Sean", company: "Pivotal", remote: false),
            Engineer(name: "Brian", company: "Pivotal", remote: false),
            Engineer(name: "Liam", company: "Pivotal", remote: false),
            Engineer(name: "Dan", company: "Pivotal", remote: false),
            Engineer(name: "Faith", company: "Travelers", remote: true),
            Engineer(name: "Dave", company: "Travelers", remote: true),
            Engineer(name: "Don", company: "Travelers", remote: true),
            Engineer(name: "Mark", company: "Travelers", remote: true),
        ]
    }
    
    func didRegisterNewEngineer(_ engineer: Engineer) {
        engineers.append(engineer)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "EngineerCollectionViewCell", bundle: nil)
        collectionView?.register(nib, forCellWithReuseIdentifier: "engineerCell")
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "engineerCell", for: indexPath) as! EngineerCollectionViewCell
        cell.nameLabel.text = engineers[indexPath.row].name
        cell.companyLabel.text = engineers[indexPath.row].company
        cell.backgroundColor = UIColor.pmGreen
                
        let remoteStatus = engineers[indexPath.row].remote == true ? "Is remote today" : "Is not remote today"
        cell.isRemoteLabel.text = "\(remoteStatus)"
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "presentAddEngineerVC" {
            let nc = segue.destination as! UINavigationController
            let vc = nc.viewControllers.first! as! AddEngineerViewController
            vc.delegate = self
        } else if segue.identifier == "presentPairListVC" {
            let nc = segue.destination as! UINavigationController
            let vc = nc.viewControllers.first! as! PairListViewController
            vc.engineers = engineers
        }
    }
}

