//
//  SavedTableViewController.swift
//  countries-ios-app
//
//  Created by Ayris Gürbulak on 7.01.2022.
//

import UIKit
import RealmSwift

class SavedTableViewController: UITableViewController {
    
    var countryList: Results<SavedCountry>?
    var countryCode: String = ""
    var countryName: String = ""
    var saved: Bool = false
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        navigationItem.title = C.title
        
        loadCategories()
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func loadCategories() {
        
        countryList = realm.objects(SavedCountry.self)
        tableView.reloadData()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == C.savedPageSegue {
                let destinationVC = segue.destination as! CountryDetailViewController
                destinationVC.countryCode = countryCode
                destinationVC.countryName = countryName
                destinationVC.saved = saved
            }
        }

}

// MARK: - SavedTableViewController data source methods
extension SavedTableViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Bundle.main.loadNibNamed(C.countryCellIdentifier, owner: self, options: nil)?.first as! CountryTableViewCell
        cell.delegate = self

        cell.cellView.layer.masksToBounds = true
        cell.cellView.layer.cornerRadius = 10
        cell.cellView.layer.borderWidth = 3
        cell.cellView.layer.borderColor = UIColor.black.cgColor
        cell.countryFavouriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        
        cell.countryNameLabel.text = countryList?[indexPath.section].name ?? "No saved yet"
        cell.countryCodeLabel.text = countryList?[indexPath.section].code ?? ""
        
        
      return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return countryList?.count ?? 0
    }
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
}

// MARK: - SavedTableViewController delegate methods

extension SavedTableViewController {
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
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

extension SavedTableViewController: CountryTableViewCellDelegate {
    func didSelectCell(code: String, name: String, saved: Bool) {
        DispatchQueue.main.async {
            self.countryCode = code
            self.countryName = name
            self.saved = saved
            self.performSegue(withIdentifier: C.savedPageSegue, sender: self)
        }
    }
    
    func updateTableView() {
        tableView.reloadData()
    }
}



