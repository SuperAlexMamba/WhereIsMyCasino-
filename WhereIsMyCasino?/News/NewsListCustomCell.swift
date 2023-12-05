//
//  NewsListCustomCell.swift
//  WhereIsMyCasino?
//
//  Created by Слава Орлов on 29.11.2023.
//

import UIKit

class NewsListCustomCell: UITableViewCell {
    
    lazy var casinoImage: UIImageView = {
        
        let image = UIImageView()
        
        image.image = UIImage(named: "ImageCasino")
        
        image.translatesAutoresizingMaskIntoConstraints = false
        
        image.layer.cornerRadius = 10
        
        image.clipsToBounds = true
        
        return image
    }()
    
    lazy var titleLabel: UILabel = {
        
        let label = UILabel()
        
        label.text = "Veikkaus to Shutter 20 Gaming Venues, Could Fire 200 Before Christmas"
        
        label.font = UIFont(name: "OpenSans-Regular", size: 16)
        
        label.numberOfLines = 2
        
        label.textColor = .white
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        
        let label = UILabel()
        
        label.text = "1 hour ago"
        
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
        
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
                
        setupView()
        
    }
    
    private func setupView() {
        
        self.frame.size.height = 100
        
        addSubview(casinoImage)
        addSubview(titleLabel)
        addSubview(dateLabel)
        
        setupConstraints()
                
    }
    
    private func setupConstraints() {
        
        let safeArea = contentView.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
        
            casinoImage.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 0),
            casinoImage.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 12),
            casinoImage.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 12),
            casinoImage.widthAnchor.constraint(equalToConstant: 100),
            casinoImage.heightAnchor.constraint(equalToConstant: 75),
            
            titleLabel.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: 0),
            titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 12),
            titleLabel.leftAnchor.constraint(equalTo: casinoImage.rightAnchor, constant: 12),
            
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
            dateLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 18),
            dateLabel.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: 0),
            dateLabel.leftAnchor.constraint(equalTo: casinoImage.rightAnchor, constant: 12)
                    
        ])
    }
}
