//
//  SavedCountry.swift
//  countries-ios-app
//
//  Created by Ayris Gürbulak on 10.01.2022.
//

import Foundation
import RealmSwift

class SavedCountry: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var code: String = ""
    @objc dynamic var dateCreated: Date? 
}
