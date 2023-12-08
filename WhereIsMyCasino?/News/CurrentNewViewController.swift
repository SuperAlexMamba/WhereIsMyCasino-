//
//  CurrentNewViewController.swift
//  WhereIsMyCasino?
//
//  Created by Слава Орлов on 29.11.2023.
//

import UIKit

class CurrentNewViewController: UITableViewController {

    @IBOutlet weak var imageNew: UIImageView!
        
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var newItem: News?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        
        titleLabel.text = newItem?.title
        descriptionLabel.text = newItem?.description
        descriptionLabel.sizeToFit()
        imageNew.image = newItem?.image
        imageNew.layer.cornerRadius = 10
        imageNew.clipsToBounds = true
        dateLabel.text = newItem?.daysAgo
    }
    
    override func loadView() {
        super.loadView()
        
        descriptionLabel.text = newItem?.description
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                
        return descriptionLabel.frame.height + imageNew.frame.height + titleLabel.frame.height + dateLabel.frame.height + 200
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
}
