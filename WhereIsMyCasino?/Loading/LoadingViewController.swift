//
//  LoadingViewController.swift
//  1
//
//  Created by Слава Орлов on 28.11.2023.
//

import UIKit

class LoadingViewController: UIViewController {

    @IBOutlet weak var loadingWheel: UIImageView!
    
    var modelView = CasinoModel.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
                        
    }
    
    override func viewWillLayoutSubviews() {
        
        startLoading()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 20) {
            self.stopLoading()
        }
        
    }
    func startLoading() {
                
        NetworkManager.shared.getCasinoList { casino in
            
            guard let casino = casino else {
                return
            }
                        
            self.modelView.casinosArray = casino
            
            StorageManager.shared.saveCasinosToFile(casinos: self.modelView.casinosArray)
            
            if StorageManager.shared.loadCasinosFromFile() != nil {
                UserDefaults().set(true, forKey: "loadingViewControllerShown")
            }
            else {
                showAlert(in: self)
            }
            
        }
        animateWheel()
        
    }
    
    private func stopLoading() {
        
        loadingWheel.layer.removeAllAnimations()
        
        dismiss(animated: false)
        
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
