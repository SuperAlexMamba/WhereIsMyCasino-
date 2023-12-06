//
//  OnboardingViewController.swift
//  1
//
//  Created by Слава Орлов on 28.11.2023.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var onboardImage: UIImageView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    let images = [UIImage(named: "Onboarding(1)"),
                  UIImage(named: "Onboarding(2)" ),
                  UIImage(named: "Onboarding(3)")]
    
    let descriptionStrings = ["The excitement awaits! Embark on Your Casino Journey, it begins now!",
                              "Explore the thrill of the game by locating casinos in different cities with our map",
                              "Dive into the world of casinos with the latest news and updates about events and bonuses."]
    
    let labelStrings = ["Ready To Play?",
                        "Discover Casinos Near You",
                        "Stay in the Loop with Casino News"]
    
    var attributedString: NSMutableAttributedString?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        pageControl.numberOfPages = 3
        
    }
    
    @IBAction func exit(_ sender: UIButton) {
        
        UserDefaults.standard.setValue(true, forKey: "showed")
        
        dismiss(animated: true)
        
    }
    
    @objc func exitFunc() {
        
        UserDefaults.standard.setValue(true, forKey: "showed")
        
        dismiss(animated: true)
    }
    
    private func setupView() {
        
        attributedString = NSMutableAttributedString(string: self.labelStrings[self.pageControl.currentPage])
        
        attributedString?.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: 8))
        
        titleLabel.attributedText = attributedString
        
        button.titleLabel?.makeOpenSansExtraBold(size: 28)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        
    }
    
    @IBAction func nextPage(_ sender: UIButton) {
        
        pageControl.currentPage += 1
        
        UIView.transition(with: onboardImage, duration: 0.5, options: .transitionFlipFromLeft) {
            
            self.onboardImage.image = self.images[self.pageControl.currentPage]
            
        }
        
        UIView.transition(with: descriptionLabel, duration: 0.5) {
            self.descriptionLabel.text = self.descriptionStrings[self.pageControl.currentPage]
        }
        
        UIView.transition(with: titleLabel, duration: 0.5) {
            
            self.attributedString = NSMutableAttributedString(string: self.labelStrings[self.pageControl.currentPage])
            self.titleLabel.attributedText = self.attributedString
            
            switch self.pageControl.currentPage {
                
            case 0:
                self.attributedString?.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: 8))
                self.titleLabel.attributedText = self.attributedString
            case 1:
                self.attributedString?.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: 16))
                self.titleLabel.attributedText = self.attributedString
            case 2:
                self.attributedString?.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: 28))
                self.titleLabel.attributedText = self.attributedString
            default:
                break
            }
            
        }
        
        if pageControl.currentPage == 2 {
            
            let currentFont = button.titleLabel?.font
            let currentTextColor = button.titleLabel?.textColor
            
            let attributedTitle = NSAttributedString(string: "Start", attributes: [
                .font: currentFont as Any,
                .foregroundColor: UIColor.white as Any
            ])

            button.setAttributedTitle(attributedTitle, for: .normal)
            
            button.removeTarget(self, action: #selector(nextPage), for: .touchUpInside)
            button.addTarget(self, action: #selector(exitFunc), for: .touchUpInside)
        }
    }
}
