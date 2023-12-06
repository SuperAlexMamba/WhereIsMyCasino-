//
//  CurrentCasinoController.swift
//  WhereIsMyCasino?
//
//  Created by Слава Орлов on 29.11.2023.
//

import UIKit
import Cosmos
import SDWebImage

class CurrentCasinoController: UIViewController, UIScrollViewDelegate {
    
    var casino: Casino?
    
    @IBOutlet weak var goToReviewsButton: UIButton!
    
    @IBOutlet weak var ratingView: UIView!
    
    @IBOutlet weak var titleOfCasino: UILabel!
    
    @IBOutlet weak var basedOnLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var descriptionOfCasino: UILabel!
    
    @IBOutlet weak var mainScrollView: UIScrollView!
    
    @IBOutlet weak var imageOfCasino: UIImageView!
    
    @IBOutlet weak var ratingOfCasino: UILabel!
    
    @IBOutlet weak var telephoneNumberOfCasino: UILabel!
    
    @IBOutlet weak var webSiteOfCasino: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var starsView: CosmosView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        navigationItem.titleView?.tintColor = .white
        
        mainScrollView.contentSize = CGSize(width: mainScrollView.bounds.width, height: descriptionLabel.frame.maxY + 20)
        
    }
    
    @IBAction func closeButton(_ sender: UIBarButtonItem) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func openReviews(_ sender: UIButton) {
        
        guard let ratingListVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RatingList") as? RatingListViewController else { return }
        
        ratingListVC.casino = self.casino
        
        self.navigationController?.pushViewController(ratingListVC, animated: true)
        
    }
    
    private func setupView() {
        
        mainScrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        mainScrollView.bounces = false
        
        if casino?.feed_backs == nil {
            goToReviewsButton.isEnabled = false
            goToReviewsButton.tintColor = .lightGray
        }
        imageOfCasino.layer.cornerRadius = 8
        ratingView.layer.cornerRadius = 10
        ratingView.clipsToBounds = true
        imageOfCasino.clipsToBounds = true
        title = casino?.title
        titleOfCasino.text = title
        if casino?.description == nil {
            descriptionOfCasino.numberOfLines = 0
            descriptionOfCasino.lineBreakMode = .byWordWrapping
            
            descriptionLabel.isHidden = true
        }
        else {
            descriptionOfCasino.text = casino?.description
        }
        ratingOfCasino.text = "\(casino?.rating ?? 0.0)"
        telephoneNumberOfCasino.text = casino?.contact?.phone ?? "No telephone"
        webSiteOfCasino.text = casino?.contact?.site ?? "No website"
        locationLabel.text = "\(casino?.location.country ?? ""),\(casino?.location.city ?? "")"
        basedOnLabel.text = "Based on \(casino?.feed_backs?.count ?? 0) views"
        starsView.rating = casino?.rating ?? 0
        starsView.isUserInteractionEnabled = false
        
        if let url = casino?.photo_url {
            
            imageOfCasino.sd_setImage(with: URL(string: url))
            
        }
    }
}
