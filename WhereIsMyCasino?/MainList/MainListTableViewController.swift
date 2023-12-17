//
//  MainListTableViewController.swift
//  1
//
//  Created by Слава Орлов on 28.11.2023.
//

import UIKit
import SDWebImage

class MainListTableViewController: UICollectionViewController {
        
    var casino: [Venue]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        casino = StorageManager.shared.loadCasinosFromFile()
        
        self.title = "Casino"
    }
    // MARK: - Collectionview data source
                
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return casino?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedCasino = casino?[indexPath.row]
        
        guard let currentVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CurrentCasino") as? CurrentCasinoController else { return }
        
        currentVC.casino = selectedCasino
        
        self.navigationController?.pushViewController(currentVC, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomListMainTableCell
        
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        
        if let item = casino?[indexPath.row] {
            setupCell(cell, with: item, at: indexPath)
        }
        
        return cell
    }
    
     
        
        func collectionView(
            _ collectionView: UICollectionView,
            layout collectionViewLayout: UICollectionViewLayout,
            sizeForItemAt indexPath: IndexPath
        ) -> CGSize {

            return .init(width: collectionView.bounds.width, height: 128)
        }
    
    
    func setupCell(_ cell: CustomListMainTableCell, with item: Venue, at indexPath: IndexPath) {
        
        cell.titleLabel.text = item.title
        cell.locationLabel.text = "\(item.location.city),\(item.location.country)"
        cell.ratingLabel.text = String(item.rating!)
                
        cell.imageOfCasino.image = nil
        
        cell.typesStackView.arrangedSubviews.forEach { view in
            cell.typesStackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        
        cell.setupStack(types: item.types_games ?? [])
        cell.setNeedsLayout()
        
        if let photo_url = item.photo_url {
            
            let cellIdentifire = "\(indexPath.section)-\(indexPath.row)-\(photo_url)"
            cell.tag = cellIdentifire.hash
            
            cell.imageOfCasino.image = nil
            cell.activityView.startAnimating()
            
            if let url = URL(string: photo_url) {
                
                cell.imageOfCasino.sd_setImage(with: url) { image, error, cashetype, url in
                    
                    if let error = error {
                        print("Ошибка загрузки \(error.localizedDescription)")
                        
                        if error.localizedDescription.contains("404") {
                            DispatchQueue.main.async {
                                cell.imageOfCasino.image = UIImage(named: "ImageCasino")
                                cell.activityView.stopAnimating()
                                print("404")
                            }
                        }
                    }
                    else {
                        cell.activityView.stopAnimating()
                        print("Ok")
                    }
                }
            }
            
            else {
                cell.imageOfCasino.image = UIImage(named: "ImageCasino")
                cell.setupStack(types: item.types_games ?? [])
                cell.setNeedsLayout()
            }
        }
        
        else {
            cell.imageOfCasino.image = UIImage(named: "ImageCasino")
            cell.setupStack(types: item.types_games ?? [])
            cell.setNeedsLayout()
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "ToCurrentVC" {
            if let destination = segue.destination as? CurrentCasinoController {
                destination.casino = sender as? Venue
            }
        }
    }
}
