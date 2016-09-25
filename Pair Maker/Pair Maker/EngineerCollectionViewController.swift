import UIKit

class EngineerCollectionViewController: UICollectionViewController {
    var engineers = [Engineer]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        engineers.append(Engineer(name: "Alfred", company: "Alphabet", remote: true))
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return engineers.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "engineerCell", for: indexPath)
        let nameLabel = UILabel(frame: cell.frame)
        nameLabel.text = engineers[indexPath.row].name
        cell.contentView.addSubview(nameLabel)
        return cell
    }
}

