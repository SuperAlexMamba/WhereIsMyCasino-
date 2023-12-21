//
//  TabBarViewController.swift
//  WhereIsMyCasino?
//
//  Created by Слава Орлов on 30.11.2023.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if UserDefaults.standard.bool(forKey: "showed") == false {
            
            guard let onboardingViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Onboarding") as? OnboardingViewController else { return }
            
            present(onboardingViewController, animated: true)
        }
    }
                
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
    }
    
    private func setupView() {
        
        let tabBarHeight: CGFloat = 200
        
        tabBar.isTranslucent = true
        tabBar.barTintColor = .black
        tabBar.backgroundColor = .black
        tabBar.backgroundImage = UIImage()
        tabBar.frame.size.height = tabBarHeight
        tabBar.barTintColor = .black
        tabBar.alpha = 1
        
        for viewController in viewControllers ?? [] {
            viewController.view.frame.size.height = view.frame.height - tabBarHeight
        }
                
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

