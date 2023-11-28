//
//  CurrentCasinoController.swift
//  WhereIsMyCasino?
//
//  Created by Слава Орлов on 29.11.2023.
//

import UIKit

class CurrentCasinoController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var currentScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainScrollView.contentSize = CGSize(width: mainScrollView.bounds.width, height: view.bounds.height)
        
        mainScrollView.isDirectionalLockEnabled = true
        
        currentScrollView.delegate = self
        currentScrollView.isPagingEnabled = true
        
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        currentScrollView.contentSize = CGSize(width: currentScrollView.frame.width * CGFloat(3), height: currentScrollView.frame.height)
        
        // Добавление картинок в scrollView
        
            let imageView = UIImageView(image: UIImage(named: "locationImage"))
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.frame = CGRect(x: CGFloat(3) * currentScrollView.frame.width, y: 0, width: currentScrollView.frame.width, height: currentScrollView.frame.height)
            currentScrollView.addSubview(imageView)
        
    }
    
    
    
    
    @IBAction func closeButton(_ sender: UIBarButtonItem) {
        
        dismiss(animated: true)
        
    }
    

}
