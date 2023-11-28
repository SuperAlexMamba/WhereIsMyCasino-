//
//  OnboardingViewController.swift
//  1
//
//  Created by Слава Орлов on 28.11.2023.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var continueButton: UIButton!
    
    var pageViewController: UIPageViewController!
    var images = ["Onboarding(1)" , "Onboarding(2)" , "Onboarding(3)"]
    var descriptionLabels = ["The excitement awaits! Embark on Your Casino Journey, it begins now!",
                             "Explore the thrill of the game by locating casinos in different cities with our map ",
                             "Dive into the world of casinos with the latest news and updates about events and bonuses."]
    
    
    var currentIndex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        continueButton.layer.cornerRadius = 8
        
        setupPageViewController()
        
    }
    
    func setupPageViewController() {
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.dataSource = self
        pageViewController.delegate = self
        
        let startingViewController = viewControllerAtIndex(0)
        pageViewController.setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
        
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        configurePageControl()
    }
        
    func configurePageControl() {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = images.count
        pageControl.currentPage = 0
        pageControl.tintColor = UIColor.black
        pageControl.pageIndicatorTintColor = UIColor.gray
        pageControl.currentPageIndicatorTintColor = UIColor.black
        let safeArea = view.safeAreaLayoutGuide
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(pageControl)
//                
        NSLayoutConstraint.activate([
            
            pageControl.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 158)
        
        ])
        
    }

    func viewControllerAtIndex(_ index: Int) -> ContentViewController {
        let contentViewController = ContentViewController()
        contentViewController.imageName = images[index]
        contentViewController.descriptionText = descriptionLabels[index]
        contentViewController.pageIndex = index
        return contentViewController
    }
    


}

extension OnboardingViewController: UIPageViewControllerDelegate , UIPageViewControllerDataSource {
    
    // MARK: - UIPageViewControllerDataSource
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! ContentViewController).pageIndex
        if index == 0 || index == NSNotFound {
            return nil
        }
        index -= 1
        return viewControllerAtIndex(index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! ContentViewController).pageIndex
        if index == NSNotFound {
            return nil
        }
        index += 1
        if index == images.count {
            // После последней вьюшки закрываем экран
            dismiss(animated: true, completion: nil)
            return nil
        }
        return viewControllerAtIndex(index)
    }
    
    // MARK: - UIPageViewControllerDelegate
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return images.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
