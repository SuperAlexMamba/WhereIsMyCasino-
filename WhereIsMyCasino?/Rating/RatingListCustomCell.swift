//
//  RatingListCustomCell.swift
//  WhereIsMyCasino?
//
//  Created by Слава Орлов on 29.11.2023.
//

import UIKit
import Cosmos

class RatingListCustomCell: UITableViewCell {
    
    @IBOutlet weak var profileNameLabel: UILabel!
        
    @IBOutlet weak var commentlabel: UILabel!
    
    @IBOutlet weak var starsView: CosmosView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
