//
//  CounrtyTableViewCell.swift
//  countries-ios-app
//
//  Created by Ayris Gürbulak on 9.01.2022.
//

import UIKit
import RealmSwift

protocol CountryTableViewCellDelegate {
    func didSelectCell(code: String, name: String, saved: Bool)
    //func updateTableView()
}

class CountryTableViewCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var countryCodeLabel: UILabel!
    @IBOutlet weak var countryFavouriteButton: UIButton!
    
    private let dataManager = CountryDataManager()
    
    var delegate: CountryTableViewCellDelegate?
    
    let realm = try! Realm()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        countryNameLabel.isUserInteractionEnabled = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func favouriteButtonPressed(_ sender: UIButton) {

        if sender.imageView?.image == UIImage(systemName: "star") {
            countryFavouriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            let savedCountry = SavedCountry()
            savedCountry.name = countryNameLabel.text!
            savedCountry.code = countryCodeLabel.text!
            savedCountry.dateCreated = Date()
            self.save(country: savedCountry)
            
        }
        else if sender.imageView?.image == UIImage(systemName: "star.fill") {
            countryFavouriteButton.setImage(UIImage(systemName: "star"), for: .normal)
            self.delete(countryName: countryNameLabel.text!)
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
    
    func delete(countryName: String) {
        let countryForDeletion = realm.objects(SavedCountry.self).filter("name = '\(countryName)'")
        
        try! realm.write {
            realm.delete(countryForDeletion)
        }
    }
    
    @IBAction func labelPressed(_ sender: UITapGestureRecognizer) {
        let savedImage = countryFavouriteButton.imageView?.image
        var saved: Bool
        if savedImage == UIImage(systemName: "star") {
            saved = false
        }
        else {
            saved = true
        }
        delegate?.didSelectCell(code: countryCodeLabel.text!,name: countryNameLabel.text!,saved: saved)
    }
}
