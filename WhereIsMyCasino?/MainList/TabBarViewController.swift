//
//  TabBarViewController.swift
//  WhereIsMyCasino?
//
//  Created by Слава Орлов on 30.11.2023.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if UserDefaults.standard.bool(forKey: "loaded") != true {
            
            guard let loadingVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Loading") as? LoadingViewController else { return }
            
            self.present(loadingVC, animated: false)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabBarHeight: CGFloat = 200
        tabBar.frame.size.height = tabBarHeight
        
        for viewController in viewControllers ?? [] {
            viewController.view.frame.size.height = view.frame.height - tabBarHeight
        }
        
        self.tabBar.barTintColor = .white
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: tabBar.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 20, height: 10)).cgPath
        tabBar.layer.mask = maskLayer
        
        let borderLayer = CAShapeLayer()
        borderLayer.path = maskLayer.path
        borderLayer.lineWidth = 1.5
        borderLayer.strokeColor = UIColor.white.cgColor
        borderLayer.fillColor = UIColor.clear.cgColor
        tabBar.layer.addSublayer(borderLayer)
    }
    
    
}

