//
//  CustomListMainTableCell.swift
//  1
//
//  Created by Слава Орлов on 28.11.2023.
//

import UIKit

class CustomListMainTableCell: UITableViewCell {

    @IBOutlet weak var ratingView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var imageOfCasino: UIImageView!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var typesStackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        ratingView.layer.cornerRadius = 5
        ratingView.clipsToBounds = true
        
        typesStackView.spacing = 5
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func setupStack(types : [TypesGame]) {
        
        for type in types {
            
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 76, height: 16))
            
            label.textColor = .white
            
            label.textAlignment = .center
            
            label.font = .systemFont(ofSize: 10)
            
            label.backgroundColor = #colorLiteral(red: 0.1579799056, green: 0.1174086407, blue: 0.1931741536, alpha: 0.8470588235)
            
            label.text = type.rawValue
            self.typesStackView.addArrangedSubview(label)
            print(type.rawValue)
            self.updateFocusIfNeeded()
        }
        
    }

}
