//
//  CountryDetailViewController.swift
//  countries-ios-app
//
//  Created by Ayris Gürbulak on 11.01.2022.
//

import UIKit
import RealmSwift

class CountryDetailViewController: UIViewController {

    @IBOutlet weak var countryImageView: UIImageView!
    @IBOutlet weak var countryCodeLabel: UILabel!
    @IBOutlet weak var backButtonItem: UIBarButtonItem!
    @IBOutlet weak var favouriteButton: UIBarButtonItem!
    
    let realm = try! Realm()
    
    var countryCode: String?
    var countryName: String?
    var saved: Bool?
    
    private let dataManager = CountryDataManager()
    var country: CountryCodeData?
    
    var favoritesBarButtonOn = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(didTapFavoritesBarButtonOn))
    var favoritesBarButtonOff = UIBarButtonItem(image: UIImage(systemName: "star.fill"), style: .plain, target: self, action: #selector(didTapFavoritesBarButtonOFF))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCodeData(code: countryCode!)
        countryCodeLabel.text = countryCode
        self.navigationItem.title = countryName
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
                self.updateView()
            }
        }
        
    }
    
    
    func updateView() {
        if let imageUrl = country?.data.flagImageUri {
            let downloadURL = NSURL(string: imageUrl)!
            print(downloadURL)
        }
    }
    
    
    
    @IBAction func informationButtonPressed(_ sender: UIButton) {
        let wikiDataId = country?.data.wikiDataId
        if let id = wikiDataId {
            let urlString = "https://www.wikidata.org/wiki/\(id)"
            UIApplication.shared.open(URL(string: urlString)!)
        }
            
        }
    
    /*@IBAction func favouriteButtonPressed(_ sender: UIBarButtonItem) {
        if sender.image == UIImage(systemName: "star") {
            self.navigationItem.setRightBarButtonItems([favoritesBarButtonOff], animated: false)
        }
        else if sender.image == UIImage(systemName: "star.fill") {
            self.navigationItem.setRightBarButtonItems([favoritesBarButtonOn], animated: false)
        }
        
        
        
    }*/
    
    @objc func didTapFavoritesBarButtonOn() {
        //self.navigationItem.setRightBarButtonItems([favoritesBarButtonOff], animated: false)
    }
    
    @objc func didTapFavoritesBarButtonOFF() {
        //self.navigationItem.setRightBarButtonItems([favoritesBarButtonOn], animated: false)
    }
    
}
