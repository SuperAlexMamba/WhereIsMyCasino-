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
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 10)
        label.backgroundColor = #colorLiteral(red: 0.1579799056, green: 0.1174086407, blue: 0.1931741536, alpha: 0.8470588235)
        label.text = type.rawValue
        return label
    }

    func createMoreLabel(count: Int) -> UILabel {
        let moreLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 76, height: 16))
        moreLabel.textColor = .white
        moreLabel.textAlignment = .center
        moreLabel.font = .systemFont(ofSize: 10)
        moreLabel.backgroundColor = #colorLiteral(red: 0.1579799056, green: 0.1174086407, blue: 0.1931741536, alpha: 0.8470588235)
        moreLabel.text = "+\(count)"
        return moreLabel
    }

}
