//
//  CurrentCasinoController.swift
//  WhereIsMyCasino?
//
//  Created by Слава Орлов on 29.11.2023.
//

import UIKit

class CurrentCasinoController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var mainScrollView: UIScrollView!
    
    let imageNames = ["ImageCasino" , "ImageCasino" , "ImageCasino" , "ImageCasino"] // Num of news (no api)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Les Croupiers Casino Cardiff"
        
        navigationItem.titleView?.tintColor = .white
        
        mainScrollView.contentSize = CGSize(width: mainScrollView.bounds.width, height: view.bounds.height)
        
        
    }
    

    @IBAction func closeButton(_ sender: UIBarButtonItem) {
        
        dismiss(animated: true)
        
    }
    

}
