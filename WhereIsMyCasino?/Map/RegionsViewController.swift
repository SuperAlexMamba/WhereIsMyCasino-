//
//  RegionsViewController.swift
//  WhereIsMyCasino?
//
//  Created by Слава Орлов on 29.11.2023.
//

struct Region {
    var name: String
    var cities: [String]
    var isExpanded: Bool
}
    
import UIKit

class RegionsViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
        
    private var regions = [Region]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        let region1 = Region(name: "Minsk Region", cities: ["Minsk" , "Slutsk" , "Soligorsk", "Borisov", "Logoisk", "Molodechno"], isExpanded: false)
        
        let region2 = Region(name: "SPB Region", cities: ["SPB" , "Kirovsk" , "Kudrovo", "Murino", "Kupchino", "Pushkin"], isExpanded: false)

        regions.append(region1)
        regions.append(region2)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.delegate = self
    }
    
    private func setupUI() {
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    @objc func toggleExpansion(sender: UIButton) {
        print("Tapnul")
        let section = sender.tag
        regions[section].isExpanded = !regions[section].isExpanded
        tableView.reloadSections(IndexSet(integer: section), with: .automatic)
    }
    
    private func setupConstraints(regionButton: UIButton , chevronButton: UIButton , in headerView: UIView) {
        
        NSLayoutConstraint.activate([
        
            chevronButton.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: 0),
            chevronButton.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 10),
            chevronButton.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -10),
            
            regionButton.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 8),
            regionButton.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: -8),
            regionButton.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 10)
        
        ])
    }
}

extension RegionsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return regions.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return regions[section].isExpanded ? regions[section].cities.count : 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let mapVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MapVIewController") as? MapViewController else { return }
        
        let region = regions[indexPath.section]
        let city = region.cities[indexPath.item]
        
        print(city)
        
        mapVC.cityString = city
        
        self.navigationController?.pushViewController(mapVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let region = regions[indexPath.section]
        let city = region.cities[indexPath.row]
        
        var contentCell = UIListContentConfiguration.cell()
        
        contentCell.text = city
        
        contentCell.textProperties.color = .white
        
        cell.contentConfiguration = contentCell
        
        cell.backgroundColor = .black
        
        cell.selectionStyle = .none
        
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
                
        let headerView = UIView()
        
        let chevronButton = UIButton()
        
        let regionButton = UIButton()
        
        regionButton.tag = section
                
        regionButton.addTarget(self, action: #selector(toggleExpansion), for: .touchUpInside)
        chevronButton.addTarget(self, action: #selector(toggleExpansion), for: .touchUpInside)
        
        headerView.backgroundColor = .black
                
        regionButton.translatesAutoresizingMaskIntoConstraints = false
        
        chevronButton.translatesAutoresizingMaskIntoConstraints = false
        
        regionButton.setTitle( regions[section].name, for: .normal)
        
        regionButton.setTitleColor(.white, for: .normal)
        
        chevronButton.setImage(UIImage(systemName: regions[section].isExpanded ? "chevron.down" : "chevron.right"), for: .normal)
        
        chevronButton.tintColor = .white
        
        headerView.addSubview(regionButton)
        headerView.addSubview(chevronButton)
        
        setupConstraints(regionButton: regionButton, chevronButton: chevronButton, in: headerView)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}

extension RegionsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
}
