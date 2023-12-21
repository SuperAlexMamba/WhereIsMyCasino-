//
//  CurrentVenueController.swift
//  WhereIsMyCasino?
//
//  Created by Слава Орлов on 29.11.2023.
//

import UIKit
import Cosmos
import SDWebImage

class CurrentVenueController: UITableViewController {
    
    var venue: Venue?
    
    @IBOutlet weak var goToReviewsButton: UIButton!
    
    @IBOutlet weak var ratingView: UIView!
    
    @IBOutlet weak var titleOfVenue: UILabel!
    
    @IBOutlet weak var basedOnLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var descriptionOfVenue: UILabel!
        
    @IBOutlet weak var imageOfVenue: UIImageView!
    
    @IBOutlet weak var ratingOfVenue: UILabel!
    
    @IBOutlet weak var telephoneNumberOfVenue: UILabel!
    
    @IBOutlet weak var webSiteOfVenue: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var starsView: CosmosView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        navigationItem.titleView?.tintColor = .white
                
    }
    
    @IBAction func closeButton(_ sender: UIBarButtonItem) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func openReviews(_ sender: UIButton) {
        
        guard let ratingListVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RatingList") as? RatingListViewController else { return }
        
        ratingListVC.venue = self.venue
        
        self.navigationController?.pushViewController(ratingListVC, animated: true)
        
    }
    
    private func setupView() {
                
        if venue?.feed_backs == nil {
            basedOnLabel.text = "No reviews"
            goToReviewsButton.isEnabled = false
        }
        imageOfVenue.layer.cornerRadius = 8
        ratingView.layer.cornerRadius = 10
        ratingView.clipsToBounds = true
        imageOfVenue.clipsToBounds = true
        
        title = venue?.title
        titleOfVenue.text = title
        if venue?.description == nil {
            descriptionOfVenue.numberOfLines = 0
            descriptionOfVenue.lineBreakMode = .byWordWrapping
            descriptionOfVenue.text = "No description"
            
        }
        else {
            descriptionOfVenue.text = venue?.description
        }
        ratingOfVenue.text = "\(venue?.rating ?? 0.0)"
        telephoneNumberOfVenue.text = venue?.contact?.phone ?? "No telephone"
        webSiteOfVenue.text = venue?.contact?.site ?? "No website"
        locationLabel.text = "\(venue?.location.country ?? ""),\(venue?.location.city ?? "")"
        basedOnLabel.text = "Based on \(venue?.feed_backs?.count ?? 0) views"
        starsView.rating = venue?.rating ?? 0
        starsView.isUserInteractionEnabled = false
        
        if let url = venue?.photo_url {
            
            imageOfVenue.sd_setImage(with: URL(string: url))
            
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
}
