//
//  Constants.swift
//  countries-ios-app
//
//  Created by Ayris Gürbulak on 7.01.2022.
//

import Foundation


struct C {
    static let title = "Countries"
    static let homePageSegue = "homeToDetail"
    static let savedPageSegue  = "savedToDetail"
    static let countryCellIdentifier = "CountryTableViewCell"
    static let url = "https://wft-geo-db.p.rapidapi.com/v1/geo/countries"
    static let headers = [
        "x-rapidapi-host": "wft-geo-db.p.rapidapi.com",
        "x-rapidapi-key": "18cdd5701emsh8e39ad354d0aaf4p1c8907jsnda8748aa4a2f"
    ]
}
