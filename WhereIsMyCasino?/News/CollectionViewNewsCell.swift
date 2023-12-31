//
//  CollectionViewNewsCell.swift
//  WhereIsMyCasino?
//
//  Created by Слава Орлов on 12.12.2023.
//

import UIKit

class CollectionViewNewsCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var hotNewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.heightAnchor.constraint(equalToConstant: 205).isActive = true
        self.widthAnchor.constraint(equalToConstant: 425).isActive = true
        
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
    }
}
    
    

