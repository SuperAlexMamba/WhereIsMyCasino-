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
        
        typesStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 20
        ratingView.layer.cornerRadius = 5
        ratingView.clipsToBounds = true
        
        typesStackView.spacing = 5
        
        imageOfCasino.layer.cornerRadius = 8
        imageOfCasino.clipsToBounds = true
        
        titleLabel.makeOpenSansSemiBold(size: 20)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        typesStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
        
    func setupStack(types: [TypesGame]) {
        
        typesStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        let maxTypesToShow = 3
        
        for (_, type) in types.prefix(maxTypesToShow).enumerated() {
            let label = createLabel(for: type)
            typesStackView.addArrangedSubview(label)
        }
        
        if types.count > maxTypesToShow {
            let remainingCount = types.count - maxTypesToShow
            let moreLabel = createMoreLabel(count: remainingCount)
            typesStackView.addArrangedSubview(moreLabel)
        }
    }

    func createLabel(for type: TypesGame) -> UILabel {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 76, height: 16))
        
        let font = UIFont.boldSystemFont(ofSize: 12)
        
        label.textColor = .white
        label.textAlignment = .center
                
        label.font = font
        label.backgroundColor = #colorLiteral(red: 0.2352941176, green: 0.2039215686, blue: 0.262745098, alpha: 1)
        label.text = type.rawValue
        
        label.sizeToFit()
        
        var frame = label.frame
        frame.size.width += 5
        label.frame = frame
        
        return label
    }

    func createMoreLabel(count: Int) -> UILabel {
        let moreLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 76, height: 16))
        
        let font = UIFont.boldSystemFont(ofSize: 12)
        
        moreLabel.font = font
        
        moreLabel.textColor = .white
        moreLabel.textAlignment = .center
        
        moreLabel.backgroundColor = #colorLiteral(red: 0.2352941176, green: 0.2039215686, blue: 0.262745098, alpha: 1)
        moreLabel.text = "+\(count)"
    
        return moreLabel
    }

}
