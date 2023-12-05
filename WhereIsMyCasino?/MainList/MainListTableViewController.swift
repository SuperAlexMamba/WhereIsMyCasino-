//
//  MainListTableViewController.swift
//  1
//
//  Created by Слава Орлов on 28.11.2023.
//

import UIKit

class MainListTableViewController: UITableViewController {
        
    var casino: [Casino]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        casino = CasinoModel.shared.casinosArray
        
        self.title = "Casino"
        
    }
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return casino?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 121
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedCasino = casino?[indexPath.row]
        
        guard let currentVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CurrentCasino") as? CurrentCasinoController else { return }
                    
            currentVC.casino = selectedCasino
            
            self.navigationController?.pushViewController(currentVC, animated: true)
                        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomListMainTableCell
        
        cell.contentMode = .scaleAspectFit
        
        if let item = casino?[indexPath.row] {
            
            setupCell(cell, with: item, at: indexPath)
            
        }
        
        return cell
    }
    
    func setupCell(_ cell: CustomListMainTableCell, with item: Casino, at indexPath: IndexPath) {
        
        cell.titleLabel.text = item.title
        cell.locationLabel.text = "\(item.location.city),\(item.location.country)"
        cell.ratingLabel.text = String(item.rating!)
        
        cell.imageOfCasino.image = nil
        
        cell.typesStackView.arrangedSubviews.forEach { view in
            cell.typesStackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        
        if let photo_url = item.photo_url {
            
            let cellIdentifire = "\(indexPath.section)-\(indexPath.row)-\(photo_url)"
            cell.tag = cellIdentifire.hash
            
            cell.imageOfCasino.image = nil
            
            NetworkManager.shared.loadImages(url: photo_url) { [weak cell] image in
                DispatchQueue.main.async {
                    
                    guard let cell = cell , let currentIndexPath = self.tableView.indexPath(for: cell) , currentIndexPath == indexPath else {
                        return
                    }
                    
                    cell.imageOfCasino.image = image
                    cell.setupStack(types: item.types_games ?? [])
                    cell.setNeedsLayout()
                    
                }
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
                destination.casino = sender as? Casino
            }

        }
        
    }
}
