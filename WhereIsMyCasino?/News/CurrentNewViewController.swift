//
//  CurrentNewViewController.swift
//  WhereIsMyCasino?
//
//  Created by Слава Орлов on 29.11.2023.
//

import UIKit

class CurrentNewViewController: UIViewController {

    @IBOutlet weak var imageNew: UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var descriptionTextLabel: UITextView!
    
    var newItem: News?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @IBAction func exitAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setupView() {
        
        titleLabel.text = newItem?.title
        descriptionTextLabel.text = newItem?.description
        imageNew.image = newItem?.image
        dateLabel.text = newItem?.daysAgo

    }
}
