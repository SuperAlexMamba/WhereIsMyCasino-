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
        
    let imageNames = ["New9" , "New10" , "New11" , "New12"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupModel()
        setupView()

        tableView.delegate = self
        tableView.dataSource = self
        
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        
        pageControl.numberOfPages = imageNames.count
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
                
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
    
    private func setupView() {
        
        scrollView.layer.cornerRadius = 10
        scrollView.clipsToBounds = true
        scrollView.contentSize = CGSize(width: scrollView.frame.width * CGFloat(imageNames.count), height: scrollView.frame.height)
        
        for (index, imageName) in imageNames.enumerated() {
            let imageView = UIImageView(image: UIImage(named: imageName))
            imageView.contentMode = .scaleAspectFill
            imageView.layer.cornerRadius = 10
            imageView.clipsToBounds = true
            imageView.frame = CGRect(x: CGFloat(index) * scrollView.frame.width, y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
            scrollView.addSubview(imageView)
            
            let label = UILabel(frame: CGRect(x: 0, y: imageView.frame.height - 50, width: imageView.frame.width, height: 50))
            
            label.textColor = UIColor.white
            
            switch index {
            case 0:
                label.text = "Las Vegas Sands to spend almost 2 billion to buy Sands China Ltd shares in Macau"
                
            case 1:
                label.text = "In the USA, a nun who stole $ 800 thousand from a school for a casino was sent to prison"
                
            case 2:
                label.text = "UK Gambling Revenue increased by 7% in fiscal Year 2023"
                
            default:
                label.text = "A bill on combating match-fixing has been prepared in Peru"
            }
            label.textAlignment = .center
            label.numberOfLines = 2
            imageView.addSubview(label)
        }
        
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
