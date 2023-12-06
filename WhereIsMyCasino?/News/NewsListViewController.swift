//
//  NewsListViewController.swift
//  WhereIsMyCasino?
//
//  Created by Слава Орлов on 29.11.2023.
//

import UIKit

class NewsListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
        
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    var newsArray: [News] = []
        
    let imageNames = ["New8"] // Num of news (без api)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupModel()

        tableView.delegate = self
        tableView.dataSource = self
        
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        
        pageControl.numberOfPages = imageNames.count
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        scrollView.contentSize = CGSize(width: scrollView.frame.width * CGFloat(imageNames.count), height: scrollView.frame.height)
        
        for (index, imageName) in imageNames.enumerated() {
            let imageView = UIImageView(image: UIImage(named: imageName))
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.frame = CGRect(x: CGFloat(index) * scrollView.frame.width, y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
            scrollView.addSubview(imageView)
            
            let label = UILabel(frame: CGRect(x: 0, y: imageView.frame.height - 50, width: imageView.frame.width, height: 50))
            
            label.textColor = UIColor.white
            
            switch index {
            case 1:
                label.text = ""
                
            case 2:
                label.text = ""
                
            case 3:
                label.text = ""
                
            default:
                label.text = ""
            }
            label.textAlignment = .center
            imageView.addSubview(label)
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = Int(round(scrollView.contentOffset.x / scrollView.frame.width))
        pageControl.currentPage = pageIndex
    }
        
        // MARK: - UIScrollViewDataSource
        
    func scrollView(_ scrollView: UIScrollView, viewForZoomingIn view: UIView) -> UIView? {
        return nil
    }
        
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageIndex = Int(round(scrollView.contentOffset.x / scrollView.frame.width))
        pageControl.currentPage = pageIndex
    }
    
}

extension NewsListViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let currentNew = newsArray[indexPath.row]
        
        guard let CurrentNew = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CurrentNew") as? CurrentNewViewController else { return }
        
        CurrentNew.newItem = currentNew
        
        self.navigationController?.pushViewController(CurrentNew, animated: true)
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewsListCustomCell
        
        let item = newsArray[indexPath.row]
        
        cell.titleLabel.text = item.title
        cell.dateLabel.text = item.daysAgo
        cell.casinoImage.image = item.image
        
        return cell
    }
    
    
    private func setupModel() {
                
        self.newsArray.append(newOne)
        self.newsArray.append(newTwo)
        self.newsArray.append(newThree)
        self.newsArray.append(newFour)
        self.newsArray.append(newFive)
        self.newsArray.append(newSix)
        self.newsArray.append(newSeven)
        
    }
}
