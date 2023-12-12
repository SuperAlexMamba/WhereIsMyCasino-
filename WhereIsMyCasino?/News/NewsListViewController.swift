//
//  NewsListViewController.swift
//  WhereIsMyCasino?
//
//  Created by Слава Орлов on 29.11.2023.
//

import UIKit

struct HotNews {
    
    let imageNames: [String] = ["New8", "New9", "New10", "New11"]
    
    let labelTexts: [String] = ["Las Vegas Sands to spend almost 2 billion to buy Sands China Ltd shares in Macau",
                                
        "In the USA, a nun who stole $800 thousand from a school for a casino was sent to prison",
                                
        "UK Gambling Revenue increased by 7% in fiscal Year 2023",
                                
        "A bill on combating match-fixing has been prepared in Peru"]
    
}

class NewsListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
            
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    var newsArray: [News] = []
    
    let hotNews = HotNews()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupModel()

        tableView.delegate = self
        tableView.dataSource = self
        
        collectionView.delegate = self
        collectionView.dataSource = self
    
        pageControl.numberOfPages = hotNews.imageNames.count
        
        collectionView.layer.cornerRadius = 8
        collectionView.clipsToBounds = true
        
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

extension NewsListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return HotNews().imageNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewNewsCell
        
        cell.hotNewLabel.text = hotNews.labelTexts[indexPath.row]
        cell.imageView.image = UIImage(named: hotNews.imageNames[indexPath.row])

        
        
        return cell
    }

}
