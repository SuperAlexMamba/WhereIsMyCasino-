//
//  CustomListMainTableCell.swift
//  1
//
//  Created by Слава Орлов on 28.11.2023.
//

import UIKit

class CustomListMainTableCell: UITableViewCell {

    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var imageOfCasino: UIImageView!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
