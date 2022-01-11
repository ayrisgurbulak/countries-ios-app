//
//  HomeTableViewController.swift
//  countries-ios-app
//
//  Created by Ayris Gürbulak on 7.01.2022.
//

import UIKit
import RealmSwift

class HomeTableViewController: UITableViewController {
    
    var countryList:[countryData] = []
    var countryCode: String = ""
    var countryName: String = ""
    var saved: Bool = false

    
    let cellSpacingHeight: CGFloat = 0
    var dataManager = CountryDataManager()
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        navigationItem.title = C.title
        
        tableView.separatorStyle = .none
        
        fetchData()
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func fetchData() {
        dataManager.fetchCountryData { countries in
            countries.data.forEach { country in
                DispatchQueue.main.async {
                    self.countryList.append(country)
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == C.homePageSegue {
                let destinationVC = segue.destination as! CountryDetailViewController
                destinationVC.countryCode = countryCode
                destinationVC.countryName = countryName
                destinationVC.saved = saved
            }
        }

}

// MARK: - HomeTableViewController data source methods

extension HomeTableViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Bundle.main.loadNibNamed(C.countryCellIdentifier, owner: self, options: nil)?.first as! CountryTableViewCell
        
        cell.delegate = self

        cell.cellView.layer.masksToBounds = true
        cell.cellView.layer.cornerRadius = 10
        cell.cellView.layer.borderWidth = 3
        cell.cellView.layer.borderColor = UIColor.black.cgColor
        cell.selectionStyle = .none
        
        let country = countryList[indexPath.section]
        
        let item = realm.objects(SavedCountry.self).filter("name = '\(country.name)'")
        
        if !item.isEmpty {
                cell.countryFavouriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }
        else {
            cell.countryFavouriteButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
        
        cell.countryNameLabel.text = country.name
        cell.countryCodeLabel.text = country.code
        
      return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return countryList.count
    }
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
}

// MARK: - HomeTableViewController delegate methods

extension HomeTableViewController {
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}

extension HomeTableViewController: CountryTableViewCellDelegate {
    func didSelectCell(code: String, name: String, saved: Bool) {
        DispatchQueue.main.async {
            self.countryCode = code
            self.countryName = name
            self.saved = saved
            self.performSegue(withIdentifier: C.homePageSegue , sender: self)
        }
    }
    
    func updateTableView() {
        //
    }
    
}



