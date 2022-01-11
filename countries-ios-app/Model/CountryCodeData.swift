//
//  CountryCodeData.swift
//  countries-ios-app
//
//  Created by Ayris Gürbulak on 11.01.2022.
//

import Foundation

struct CountryCodeData: Decodable {
    let data: countryCodeData
}

struct countryCodeData: Decodable {
    let name: String
    let code: String
    let flagImageUri: String
    let wikiDataId: String
}
