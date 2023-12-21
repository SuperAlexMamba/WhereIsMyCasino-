//
//  ListRatingViewController.swift
//  WhereIsMyCasino?
//
//  Created by Слава Орлов on 29.11.2023.
//

import UIKit

class RatingListViewController: UITableViewController {

    var venue: Venue?
    
    @IBOutlet weak var ratingView: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ratingView.title = "\(venue?.rating ?? 0)"
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return venue?.feed_backs?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(venue?.feed_backs?.count ?? 0) reviews"
    }

    @IBAction func close(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RatingListCustomCell
        
        let item = venue?.feed_backs?[indexPath.row]
        
        cell.profileNameLabel.text = item?.nickname
        cell.starsView.rating = item?.mark ?? 0
        cell.commentlabel.text = item?.text?.cons
    
        return cell
    }
    
}
