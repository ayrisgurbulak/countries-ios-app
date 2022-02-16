//
//  CountryDetailViewController.swift
//  countries-ios-app
//
//  Created by Ayris Gürbulak on 11.01.2022.
//

import UIKit
import RealmSwift
import SVGKit

class CountryDetailViewController: UIViewController {

    @IBOutlet weak var countryImageView: UIImageView!
    @IBOutlet weak var countryCodeLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIBarButtonItem!
    
    let realm = try! Realm()
    
    var saved: Bool?
    
    private let dataManager = CountryDataManager()
    var country: CountryCodeData?
    var code: String?
    
    var favoritesBarButtonOn = UIBarButtonItem(image: UIImage(systemName: "star"))
    var favoritesBarButtonOff = UIBarButtonItem(image: UIImage(systemName: "star.fill"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countryCodeLabel.text = code
        fetchCodeData(code: code!)
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        favoritesBarButtonOn.target = self
        favoritesBarButtonOn.action = #selector(didTapFavoritesBarButtonOn(sender:))
        
        favoritesBarButtonOff.target = self
        favoritesBarButtonOff.action = #selector(didTapFavoritesBarButtonOFF(sender:))
        
        if saved == true {
            self.navigationItem.setRightBarButtonItems([favoritesBarButtonOff], animated: false)
        }
        else {
            self.navigationItem.setRightBarButtonItems([favoritesBarButtonOn], animated: false)
        }
        

    }
    
    func fetchCodeData(code: String) {
        dataManager.fetchCountryCodeData(code: code) { countryInfo in
            DispatchQueue.main.async {
                self.country = countryInfo
                self.navigationItem.title = self.country?.data.name
                self.updateView()
            }
        }

    }

    
    func updateView() {
        if let imageString = country?.data.flagImageUri {
            let imageUrl = URL(string: imageString)
            if let imageData = try? Data(contentsOf: imageUrl!)
            {
                let image = SVGKImage(data: imageData)
                self.countryImageView.image = image?.uiImage
            }
        }
    }
    
    
    
    @IBAction func informationButtonPressed(_ sender: UIButton) {
        let wikiDataId = country?.data.wikiDataId
        if let id = wikiDataId {
            let urlString = "https://www.wikidata.org/wiki/\(id)"
            UIApplication.shared.open(URL(string: urlString)!)
        }
            
    }
    
    @objc func didTapFavoritesBarButtonOn(sender: UIBarButtonItem) {
        self.navigationItem.setRightBarButtonItems([favoritesBarButtonOff], animated: false)
        let savedCountry = SavedCountry()
        savedCountry.name = (country?.data.name)!
        savedCountry.code = (country?.data.code)!
        savedCountry.dateCreated = Date()
        self.save(country: savedCountry)
    }
    
    @objc func didTapFavoritesBarButtonOFF(sender: UIBarButtonItem) {
        self.navigationItem.setRightBarButtonItems([favoritesBarButtonOn], animated: false)
        self.delete(countryName: (country?.data.name)!)
    }
    
    func delete(countryName: String) {
        let countryForDeletion = realm.objects(SavedCountry.self).filter("name = '\(countryName)'")
        
        try! realm.write {
            realm.delete(countryForDeletion)
        }
    }
    
    func save(country: SavedCountry) {
        do {
            try realm.write {
                realm.add(country)
            }
        } catch {
            print("error saving context \(error)")
        }
    }

}
