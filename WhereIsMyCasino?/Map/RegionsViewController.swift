//
//  RegionsViewController.swift
//  WhereIsMyCasino?
//
//  Created by Слава Орлов on 29.11.2023.
//
import UIKit

class RegionsViewController: UIViewController {
    
    var regions: [Region] = []
    
    var filteredRegions: [Region] = []
        
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                        
        setupUI()
        setupRegions()
        
        filteredRegions = regions

        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.delegate = self
        
    }
        
    private func setupUI() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        searchBar.keyboardAppearance = .dark
        
    }
    
    private func setupRegions() {
        guard let casinosArray = StorageManager.shared.loadCasinosFromFile() else { return }
        
        var uniqueCitiesByCountry: [String: Set<String>] = [:]
        
        for casino in casinosArray {
            let location = casino.location
            if uniqueCitiesByCountry[location.country] == nil {
                uniqueCitiesByCountry[location.country] = Set<String>()
            }
            uniqueCitiesByCountry[location.country]?.insert(location.city)
        }
        
        regions = uniqueCitiesByCountry.map { country, citiesSet in
            return Region(country: country, cities: Array(citiesSet), isExpanded: false)
        }
    }

    
    @objc func toggleExpansion(sender: UIButton) {
        let section = sender.tag
        filteredRegions[section].isExpanded.toggle()
        tableView.reloadSections(IndexSet(integer: section), with: .none)
        tableView.reloadData()
    }
}

extension RegionsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return filteredRegions.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredRegions[section].isExpanded ? filteredRegions[section].cities.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let city = filteredRegions[indexPath.section].cities[indexPath.row]
        
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
        
        headerView.backgroundColor = .black
        
        regionButton.translatesAutoresizingMaskIntoConstraints = false
        chevronButton.translatesAutoresizingMaskIntoConstraints = false
        
        regionButton.setTitle(filteredRegions[section].country, for: .normal)
        regionButton.setTitleColor(.white, for: .normal)
        
        chevronButton.setImage(UIImage(systemName: filteredRegions[section].isExpanded ? "chevron.up" : "chevron.down"), for: .normal)
        chevronButton.tintColor = .white
        
        headerView.addSubview(regionButton)
        headerView.addSubview(chevronButton)
                
        NSLayoutConstraint.activate([
            chevronButton.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: 0),
            chevronButton.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 10),
            chevronButton.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -10),
            
            regionButton.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 8),
            regionButton.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: -8),
            regionButton.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 10)
        ])
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let mapVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MapVIewController") as? MapViewController else {
            return
        }

        let selectedRegion = filteredRegions[indexPath.section]
        let selectedCity = selectedRegion.cities[indexPath.row]

        mapVC.selectedRegion = selectedRegion
        mapVC.selectedCity = selectedCity
        
        guard let savedCasinos = StorageManager.shared.loadCasinosFromFile() else { return }
        
        mapVC.casinosInCity = savedCasinos.filter { casino in
            return casino.location.country == selectedRegion.country && casino.location.city == selectedCity
        }

        mapVC.title = selectedCity

        self.navigationController?.pushViewController(mapVC, animated: true)
    }

    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}

extension RegionsViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredRegions = regions
        } else {
            let resultFilteredRegions = regions.filter { $0.country.localizedCaseInsensitiveContains(searchText) }
            
            let resultFilteredCities = regions.filter { $0.cities.contains { $0.localizedCaseInsensitiveContains(searchText) } }
            
            filteredRegions = resultFilteredRegions.isEmpty ? resultFilteredCities : resultFilteredRegions
            
            print("---▼---", "resultFilteredRegions")
            resultFilteredRegions.forEach({ print($0.country )})
            print("---▲---", "resultFilteredRegions")
            
            print("---▼---", "filteredRegions")
            filteredRegions.forEach({ print($0.country )})
            print("---▲---", "filteredRegions")
        
        }
        tableView.reloadData()
        tableView.reloadInputViews()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        self.view.endEditing(true)
        
    }
}

