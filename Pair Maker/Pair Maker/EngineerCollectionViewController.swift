import UIKit

class EngineerCollectionViewController: UICollectionViewController {
    var engineers = [Engineer]()
    var engineerToEdit: Engineer?
    
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
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "EngineerCollectionViewCell", bundle: nil)
        collectionView?.register(nib, forCellWithReuseIdentifier: "engineerCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView?.reloadData()
    }
    
    // MARK: CollectionView Methods
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return engineers.count
    }
    
    // MARK: Navigation Methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "presentAddEngineerVC" {
            let nc = segue.destination as! UINavigationController
            let vc = nc.viewControllers.first! as! AddEngineerViewController
            vc.delegate = self
            vc.engineerToEdit = engineerToEdit ?? nil
            engineerToEdit = nil
            
        } else if segue.identifier == "presentPairListVC" {
            let nc = segue.destination as! UINavigationController
            let vc = nc.viewControllers.first! as! PairListViewController
            vc.engineers = engineers
        }
    }
}

// MARK: AddEngineerVC Methods

extension EngineerCollectionViewController: AddEngineerViewControllerDelegate {
    func didAdd(_ engineer: Engineer) {
        
        guard engineers.index(of: engineer) == nil else {
            return
        }
        
        engineers.append(engineer)
    }
    
    func didRemove(_ engineer: Engineer) {
        engineers.remove(at: engineers.index(of: engineer)!)
    }
}

// MARK: CollectionView Methods

extension EngineerCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "engineerCell", for: indexPath) as! EngineerCollectionViewCell
        cell.nameLabel.text = engineers[indexPath.row].name
        cell.companyLabel.text = engineers[indexPath.row].company
        cell.backgroundColor = UIColor.pmGreen
        
        let radius: CGFloat = 2.0
        cell.contentView.layer.cornerRadius = radius;
        cell.contentView.layer.borderWidth = 1.0;
        cell.contentView.layer.borderColor = UIColor.clear.cgColor;
        cell.contentView.layer.masksToBounds = true;
        
        cell.layer.shadowColor = UIColor.gray.cgColor;
        cell.layer.shadowOffset = CGSize(width: 0, height: 2.0);
        cell.layer.shadowRadius = 1.0;
        cell.layer.shadowOpacity = 1.0;
        cell.layer.masksToBounds = false;
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath;
        
        let remoteStatus = engineers[indexPath.row].remote == true ? "Remote" : "Not Remote"
        cell.isRemoteLabel.text = "\(remoteStatus)"
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        engineerToEdit = engineers[indexPath.row]
        performSegue(withIdentifier: "presentAddEngineerVC", sender: nil)
    }
}

