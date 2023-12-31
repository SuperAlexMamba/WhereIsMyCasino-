//
//  CustomListMainTableCell.swift
//  1
//
//  Created by Слава Орлов on 28.11.2023.
//

import UIKit

class CustomListMainTableCell: UICollectionViewCell {

    @IBOutlet weak var ratingView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var imageOfVenue: UIImageView!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var typesStackView: UIStackView!
    
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.heightAnchor.constraint(equalToConstant: 121).isActive = true
//        self.widthAnchor.constraint(equalToConstant: 342).isActive = true
                
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
            typesStackView.alignment = .center
            typesStackView.addArrangedSubview(moreLabel)
        }
    }

    func createLabel(for type: TypesGame) -> UILabel {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 76, height: 16))
        
        let font = UIFont.systemFont(ofSize: 11)
        
        label.textColor = .white
        label.textAlignment = .center
        label.font = font
        label.backgroundColor = #colorLiteral(red: 0.2352941176, green: 0.2039215686, blue: 0.262745098, alpha: 1)
        label.text = type.rawValue
        label.layer.cornerRadius = 3
        label.clipsToBounds = true
        label.sizeToFit()
                
        return label
    }

    func createMoreLabel(count: Int) -> UILabel {
        let moreLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 76, height: 16))
        
        let font = UIFont.systemFont(ofSize: 11)
        
        moreLabel.font = font
        moreLabel.textColor = .white
        moreLabel.textAlignment = .center
        moreLabel.backgroundColor = #colorLiteral(red: 0.2352941176, green: 0.2039215686, blue: 0.262745098, alpha: 1)
        moreLabel.text = "+\(count)"
    
        return moreLabel
    }
    
    private func setupView() {
        
        typesStackView.frame.size = typesStackView.intrinsicContentSize
        typesStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        typesStackView.spacing = 5
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 20
        ratingView.layer.cornerRadius = 5
        ratingView.clipsToBounds = true
        
        imageOfVenue.layer.cornerRadius = 8
        imageOfVenue.clipsToBounds = true
        
        titleLabel.makeOpenSansSemiBold(size: 20)
        
    }
}
