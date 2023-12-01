//
//  LoadingViewController.swift
//  1
//
//  Created by Слава Орлов on 28.11.2023.
//

import UIKit


class LoadingViewController: UIViewController {

    @IBOutlet weak var loadingWheel: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                        
    }
    
    override func viewWillLayoutSubviews() {
        startLoading()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.stopLoading()
        }
    }
    
    
    func startLoading() {
        
        animateWheel()
        
    }
    
    private func stopLoading() {
        
        loadingWheel.layer.removeAllAnimations()
        
        dismiss(animated: false)
        
        UserDefaults.standard.setValue(true, forKey: "loaded")
        
    }
    
    private func animateWheel() {
        
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 1
        rotation.isCumulative = true
        rotation.repeatCount = Float.infinity
        loadingWheel.layer.add(rotation, forKey: "rotationAnimation")
        
    }

}
